//
//  TheMainViewController.m  
//  NavCtrl
//
//  Created by Rafael M. Trasmontero on 4/5/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "TheMainViewController.h"
#import "UIImage+animatedGIF.h"

@interface TheMainViewController ()
@property DAO *dataManager;
@property NSTimer *myTimer;
@end

@implementation TheMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataManager = [DAO sharedManager];

    
    //DISPLAY EDIT BUTTON ON LEFTSIDE OF BAR
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditMode)];
    
    //DISPLAY ADD + BUTTON TO RIGHT SIDE OF BAR
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                               target:self
                                               action:@selector(pushToAddCompanyView)]
                                              autorelease];
    
    //SET TITLE OF HEADER
    self.title = @"Company";
    
    //NSNOTIFICATIONCENTER ADD OBSERVER WHEN DATA IS READY
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedFinNotificationForFinFetch:) name:@"Data Ready" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedFinNotificationForFinFetch:) name:@"Data Missing" object:nil];
    
    //SET TABLEVIEW DELEGATES
    self.companyTableView.delegate = self;
    self.companyTableView.dataSource = self;
    
    //HIDE THE POPULATED STACK UNDOREDO HOLDER
    [self.populatedUndoRedoHolderView setHidden:YES];
    
    [self fetchImages];
    
}

-(void)fetchImages
{
    for (Company *currentCompany in self.dataManager.companyListDAO){
        
        NSURLSessionConfiguration *sessConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        [[[NSURLSession sharedSession]dataTaskWithURL:currentCompany.companyLogoURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage *imageToSet = [UIImage imageWithData:data];
                currentCompany.fetchedLogoImage = imageToSet;
                [self.companyTableView reloadData];
                sessConfig.timeoutIntervalForRequest = 5.0;
            });
        }]resume];
    }
}

-(void)timedRecieveNotification{
    self.myTimer = [[[NSTimer alloc]init]autorelease];
    
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval: 60.0 target: self
                                             selector: @selector(timedRecieveNotification) userInfo: nil repeats: YES];
    [self.companyTableView reloadData];
}

- (void)receivedFinNotificationForFinFetch:(NSNotification *) notification {
    
    if ([[notification name] isEqualToString:@"Data Ready" ] ||[[notification name] isEqualToString:@"Added New Company"]){
        
        
       for (int i = 0; i < [self.dataManager.companyListDAO count]; i++) {
           Company *company =  [self.dataManager.companyListDAO objectAtIndex:i];
           if(![[self.dataManager.fetchedFinDataArrayDAO objectAtIndex:i] isEqualToString:@""]){
               company.financialDataString = [self.dataManager.fetchedFinDataArrayDAO objectAtIndex:i];
           }else{
                company.financialDataString = @"N/A";
           }
           
           
       }
        
        [self.companyTableView reloadData];

        
    } else if ([[notification name] isEqualToString:@"Data Missing"]) {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Error"
                                     message:@"Error Fetching Financial Data"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        
        
        UIAlertAction* confirmButton = [UIAlertAction
                                        actionWithTitle:@"Confirm"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            //Handle your yes please button action here
                                        }];
        
        [alert addAction:confirmButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //IF COMPANYLIST IS GREATER THAN 1 SHOW POPULATED VIEW
    if([self.dataManager.companyListDAO count] >= 1){
        [self.populatedStackView setHidden:NO];
    }
    
    
    //MOVE OBJECTS UNDERNEATH NAVBAR LOWER
    [self.navigationController.navigationBar setTranslucent:NO];
    
    [self.dataManager getAPIFinancialData];
    [self fetchImages];
    [self.companyTableView reloadData];
}



-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.dataManager.companyListDAO.count;
}

#pragma mark - Cell For Row At Index

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    Company *currentCompany = [self.dataManager.companyListDAO objectAtIndex:indexPath.row];
    
    if([currentCompany.fetchedLogoImage isEqual:@""]){
        [cell.imageView setImage:[UIImage imageNamed:@"StockMarket.png"]];
    } else {
        [cell.imageView setImage:currentCompany.fetchedLogoImage];
    }
    
    cell.textLabel.text = currentCompany.companyName;
    //ALIGN TEXT LABEL TO LEFT/CENTER/RIGHT
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    //MAKE THE IMAGE VIEW FRAME PER CELL OF SIMILAR SIZE
    CGSize itemSize = CGSizeMake(40, 40);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    //ASSIGN CUSTOM EDIT BUTTON TO ACCESSORY VIEW CELL TO EDIT NAMES AND URL
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [editButton setImage:[UIImage imageNamed:@"editPencil(48x48)"] forState:UIControlStateNormal];
    
    [editButton setFrame:CGRectMake(0, 0, 24, 24)];
    
    //ADD METHOD/TARGET TO THE EDIT BUTTON;
    [editButton addTarget:self
                   action:@selector(pushToEditCompany:)
         forControlEvents:UIControlEventTouchUpInside];
    
    //***ASSIGN TAG TO THE BUTTON ***
    [editButton setTag:indexPath.row];
    
    //SHOW THE EDIT BUTTON
    //cell.accessoryView = self.editButton; // <--- SHOW ON CELL RIGHT AWAY
    cell.editingAccessoryView = editButton; // <--- SHOW ON EDIT VIEW
    
    //ADD STOCK INFO ON DETAIL TEXT LABEL
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",currentCompany.financialDataString];
    
    //CHANGE TEXT COLOR DETAILTEXTLABEL
    cell.detailTextLabel.textColor = [UIColor redColor];
    
    return cell;
    
}

#pragma mark - Deleting

// Override to support EDITING the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSInteger selectedIndex = indexPath.row;
        
        //REMOVE COMPANY FROM ARRAY
        [self.dataManager.companyListDAO removeObjectAtIndex:selectedIndex];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        //IF COMPANY ARRAY IS EMPTY
        if(self.dataManager.companyListDAO.count == 0){
            [self.populatedStackView setHidden:YES];
            [self.view reloadInputViews];
        }
    
    }
    
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    
    else {
        
    }
    
}


#pragma mark - Did Select Row Table View Cell

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //DEFINE THE COMPANY THAT IS CLICKED
    Company *selectedCompany = self.dataManager.companyListDAO[indexPath.row];
    
    MainViewController *companyDetailsView = [[[MainViewController alloc]init]autorelease];
    
    //SET THE HEADER TITLE OF THE PRODUCT VIEW CONTROLLER NEXT PAGE
    companyDetailsView.title = [NSString stringWithFormat:@"%@ Products", selectedCompany.companyName];
    
    //LET THE DETAILS VIEW KNOW WHCIH COMPANY WAS SELECTED
    companyDetailsView.companyToDisplay = selectedCompany;
    //LET THE DAO KNOW THE CURRENT COMPANY
    _dataManager.currentCompanyDAO = selectedCompany;
    
    //PUSHES TO THE DIFFERENT PRODUCTS FROM THE COMPANY TO THE PRODUCT VIEW CONTROLLER
    CATransition* transition = [CATransition animation];
    transition.duration = 0.7f;
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition
                                                forKey:kCATransition];
    [self.navigationController pushViewController:companyDetailsView animated:YES];
    
    
}

//METHOD TO HIDE AND SHOW FOOTERVIEW WHEN EDIT CLICKED
-(void)toggleEditMode {
    
    if (self.companyTableView.isEditing) {
        [self.companyTableView setEditing:NO animated:YES];
        self.navigationItem.leftBarButtonItem.title = @"Edit";
        [self.populatedUndoRedoHolderView setHidden:YES];
    } else {
        [self.companyTableView setEditing:YES animated:YES];
        self.navigationItem.leftBarButtonItem.title = @"Done";
        [self.populatedUndoRedoHolderView setHidden:NO];
    }
    
}

//METHOD TO GO TO NEW COMPANY TABLE VIEW SCREEN
-(void)pushToAddCompanyView{
    
    NewCompanyViewController *addNewCompanyView = [[NewCompanyViewController alloc]init];
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.7f;
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromRight;
    [self.navigationController.view.layer addAnimation:transition
                                                forKey:kCATransition];
    [self.navigationController pushViewController:addNewCompanyView animated:YES];
    
    [addNewCompanyView release];
}

//METHOD TO SEGUE TO EDIT COMPANY NAME AND LOGO URL
-(void)pushToEditCompany: (UIButton*) sender {
    
    //LET EDIT COMPANY SCREEN KNOW WHICH CURRENT COMPANY WAS CLICKED FOR EDITING
    EditCompanyViewController *editScreen = [[EditCompanyViewController alloc]init];
    
    //USE THE TAG SET ON THE BUTTON TO DISPLAY THE COMPANY TO BE EDITED  ***
    editScreen.currentCompany = [self.dataManager.companyListDAO objectAtIndex:sender.tag];
    
    NSLog(@"%@",editScreen.currentCompany.companyName);
    
    //SEGUE TO THE NEW VIEW/ ANIMATED TRANSITION
    CATransition* transition = [CATransition animation];
    transition.duration = 0.7f;
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromLeft;
    [self.navigationController.view.layer addAnimation:transition
                                                forKey:kCATransition];
    [self.navigationController pushViewController:editScreen animated:YES];

    [editScreen release];
}


- (IBAction)addToCompaniesEmptyButton:(UIButton *)sender {
    NewCompanyViewController *addNewCompanyVC = [[[NewCompanyViewController alloc]init]autorelease];
    [self.navigationController pushViewController:addNewCompanyVC animated:YES];
}


#pragma mark CoreData
- (IBAction)populatedUndoButtonPressed:(UIButton *)sender {
   NavControllerAppDelegate *appDelegate = (NavControllerAppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate.managedObjectContext undo];
    [self.dataManager loadFetchedFromCoreData];
    [self fetchImages];
    [self.companyTableView reloadData];
}

- (IBAction)populatedRedoButtonPressed:(UIButton *)sender {
    NavControllerAppDelegate *appDelegate = (NavControllerAppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate.managedObjectContext redo];
    [self.dataManager loadFetchedFromCoreData];
    [self fetchImages];
    [self.companyTableView reloadData];
}

- (IBAction)emptyUndoButtonPressed:(UIButton *)sender {
    NavControllerAppDelegate *appDelegate = (NavControllerAppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate.managedObjectContext undo];
    [self.dataManager loadFetchedFromCoreData];
    [self.companyTableView reloadData];
}

- (IBAction)emptyRedoButtonPressed:(UIButton *)sender {
    NavControllerAppDelegate *appDelegate = (NavControllerAppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate.managedObjectContext redo];
    [self.dataManager loadFetchedFromCoreData];
    [self.companyTableView reloadData];
}

- (void)dealloc {
    _companyTableView.delegate = nil;
    _companyTableView.dataSource = nil;
    [_companyTableView release];
    [_emptyViewAndMessage release];
    [_emptyStateLogoImageView release];
    [_noCompaniesLabel release];
    [_populatedStackView release];
    [_populatedUndoRedoHolderView release];
    [_emptyUndoRedoHolderView release];
    [_fetchedFinancials release];
    [super dealloc];
}



@end

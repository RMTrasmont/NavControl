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
@end

@implementation TheMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //SET THE DAO PROPERTY OF THIS VIEW
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNotification:) name:@"Data Ready" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNotification:) name:@"Data Missing" object:nil];
    
    
    //TEST
    NSLog(@"TEST*****TheMainViewController*****LOADED");
    
    //SET TABLEVIEW DELEGATES
    self.companyTableView.delegate = self;
    self.companyTableView.dataSource = self;
    
    //ANIMATE BACKGROUND ON EMPTYVIEW, GIF TO IMAGE ASYNC
    //1.LOAD ANIMATED IMAGE FROM GIF ASYNCHRONOUSLY
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage *animatedFly =  [UIImage animatedImageWithAnimatedGIFURL:[NSURL URLWithString:@"https://68.media.tumblr.com/1acc0097ed89aaee8b6d32151b7dcbad/tumblr_n6rbvoK1GV1tcytp3o1_500.gif"]];
        //**********************BACK TO MAIN THREAD*****************************
        //2.ALL IMAGES FETCHED,GO BACK TO THE MAIN QUEUE,AND ASSIGN IMAGES
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.gifBackGroundImageView setImage:animatedFly];
        });
    });
    
    
    //HIDE THE POPULATED STACK UNDOREDO HOLDER
    [self.populatedUndoRedoHolderView setHidden:YES];
    
    //INIT MANAGED OBJECT CONTEXT FOR USE WITH (OPTION 1)
    self.dataManager.managedObjectContextDAO.undoManager = [[NSUndoManager alloc]init];

}




//****************************************************************************************

- (void)receivedNotification:(NSNotification *) notification {
    
    if ([[notification name] isEqualToString:@"Data Ready"]) {
        
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


//****************************************************************************************

-(void)viewWillAppear:(BOOL)animated{
    
    //IF COMPANYLIST IS GREATER THAN 1 SHOW POPULATED VIEW
    if([self.dataManager.companyListDAO count] >= 1){
        [self.populatedStackView setHidden:NO];
    }
    
    //MOVE OBJECTS UNDERNEATH NAVBAR LOWER
    [self.navigationController.navigationBar setTranslucent:NO];
 
    [self.dataManager getAPIFinancialData];
    
    
    [self.companyTableView reloadData];
    

}
//****************************************************************************************

-(void)viewWillDisappear:(BOOL)animated{
    
    //NSNOTIFICATIONCENTER REMOVE OBSERVER WHEN DATA IS ALREADY USED
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"Data is Ready" object:nil];
    
    
}
//****************************************************************************************
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
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
    
    Company *currentCompany = self.dataManager.companyListDAO[indexPath.row];
    
    //**********************RUN ON DIFF THREAD********************************
    //1. GET ALL IMAGES FROM ONLINE RUN ON DIFFERENT THREAD 
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage *imageToSet = [UIImage imageWithData:[NSData dataWithContentsOfURL:currentCompany.companyLogoURL]];
        currentCompany.fetchedLogoImage = imageToSet;
        
        //**********************BACK TO MAIN THREAD*****************************
        //2.ALL IMAGES FETCHED,GO BACK TO THE MAIN QUEUE,AND ASSIGN IMAGES
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell.imageView setImage:imageToSet];
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

        });

    });
    //*****************************************************************
    
    
    //ASSIGN CUSTOM EDIT BUTTON TO ACCESSORY VIEW CELL TO EDIT NAMES AND URL
    //UIButton *editButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
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
        
        //LET DAO KNOW THE CURRENT MANAGED COMPANY
        self.dataManager.currentManagedCompanyDAO  = self.dataManager.managedCompanyListDAO[selectedIndex];
        
        //REMOVE COMPANY FROM ARRAY
        [self.dataManager.companyListDAO removeObjectAtIndex:selectedIndex];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        //REMOVE MANAGED COMPANY FROM CORE DATA
        [self.dataManager removeManagedCompanyFromCoreData:self.dataManager.currentManagedCompanyDAO];
            
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
    
    //LET DAO KNOW THE CURRENT MANAGED COMPANY
    self.dataManager.currentManagedCompanyDAO = self.dataManager.managedCompanyListDAO[indexPath.row];
    
    //INIT A VIEW CONTROLLER "CLICK A ROW AND GET A NEW VIEW W/ LIST OF DIFFERENT PRODUCTS"
    MainViewController *companyDetailsView = [[MainViewController alloc]init];
    
    //SET THE HEADER TITLE OF THE PRODUCT VIEW CONTROLLER NEXT PAGE
    companyDetailsView.title = [NSString stringWithFormat:@"%@ Products", selectedCompany.companyName];
    
    //LET THE DETAILS VIEW KNOW WHCIH COMPANY WAS SELECTED
    companyDetailsView.companyToDisplay = selectedCompany;
    
    //LET THE DAO KNOW THE CURRENT COMPANY
    self.dataManager.currentCompanyDAO = selectedCompany;
    
    //PUSHES TO THE DIFFERENT PRODUCTS FROM THE COMPANY TO THE PRODUCT VIEW CONTROLLER
    
    [self.navigationController
     pushViewController:companyDetailsView
     animated:YES];
    
    
    
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
    
    //INITIALIZE THE VIEW YOU'RE TRYING TO SEND TO
    NewCompanyViewController *addNewCompanyView = [[NewCompanyViewController alloc]init];
    
    //SEGUE TO NewComapanyViewController
    [self.navigationController pushViewController:addNewCompanyView animated:YES];
    
}

//METHOD TO SEGUE TO EDIT COMPANY NAME AND LOGO URL
-(void)pushToEditCompany: (UIButton*) sender {
    
    //TEST
    NSLog(@"INDEX OF SELECTED ACC. BUTTON = %ld", (long)sender.tag);
    
    //LET EDIT COMPANY SCREEN KNOW WHICH CURRENT COMPANY WAS CLICKED FOR EDITING
    EditCompanyViewController *editScreen = [[EditCompanyViewController alloc]init];
    
    //USE THE TAG SET ON THE BUTTON TO DISPLAY THE COMPANY TO BE EDITED  ***
    editScreen.currentCompany = [self.dataManager.companyListDAO objectAtIndex:sender.tag];
    
    NSLog(@"%@",editScreen.currentCompany.companyName);
    
    //USE THE SENDER TAG LET DAO KNOW WHICH COMPANY
    self.dataManager.currentManagedCompanyDAO = [self.dataManager.managedCompanyListDAO objectAtIndex:sender.tag];
    
    //SEGUE TO THE NEW VIEW
    [self.navigationController pushViewController:editScreen animated:YES];
    
}


- (void)dealloc {
    [_companyTableView release];
    [_emptyViewAndMessage release];
    [_gifBackGroundImageView release];
    [_emptyStateLogoImageView release];
    [_noCompaniesLabel release];
    [_populatedStackView release];
    [_populatedUndoRedoHolderView release];
    [_emptyUndoRedoHolderView release];
    [super dealloc];
}


- (IBAction)addToCompaniesEmptyButton:(UIButton *)sender {
    NewCompanyViewController *addNewCompanyVC = [[NewCompanyViewController alloc]init];
    [self.navigationController pushViewController:addNewCompanyVC animated:YES];}

-(void)pushToEmptyView{
    EmptyViewController *emptyView = [[EmptyViewController alloc]init];
    [self.navigationController pushViewController:emptyView animated:YES];
    
}

//(OPTION 1)
- (IBAction)populatedUndoButtonPressed:(UIButton *)sender {
   //NavControllerAppDelegate *appDelegate = (NavControllerAppDelegate*)[UIApplication sharedApplication].delegate;
    [self.dataManager.managedObjectContextDAO undo];
    [self.dataManager loadFetchedFromCoreData];
    [self.companyTableView reloadData];
}

- (IBAction)populatedRedoButtonPressed:(UIButton *)sender {
    //NavControllerAppDelegate *appDelegate = (NavControllerAppDelegate*)[UIApplication sharedApplication].delegate;
    [self.dataManager.managedObjectContextDAO redo];
    [self.dataManager loadFetchedFromCoreData];
    [self.companyTableView reloadData];}

//(OPTION 2)
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

@end

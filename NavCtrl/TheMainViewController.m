//
//  TheMainViewController.m
//  NavCtrl
//
//  Created by Rafael M. Trasmontero on 4/5/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "TheMainViewController.h"

@interface TheMainViewController ()
@property DAO *dataManager;
@end

@implementation TheMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //SET THE DAO PROPERTY OF THIS VIEW
    self.dataManager = [DAO sharedManager];
    
    //TEST CORE DATA*
    //NSLog(@"TEST COMPANY %@",self.dataManager.managedCompanyListDAO);
    NSLog(@"TEST MANAGED COMPANY PRODUCT %@",self.dataManager.managedCompanyListDAO[0].products);
    
     //Uncomment the following line to preserve selection between presentations.
//    self.clearsSelectionOnViewWillAppear = NO;
    
    //DISPLAY EDIT BUTTON ON LEFTSIDE OF BAR
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditMode)];
    
    //DISPLAY ADD + BUTTON TO RIGHT SIDE OF BAR
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                               target:self
                                               action:@selector(segueToAddCompanyView)]
                                              autorelease];
    
    //SET TITLE OF HEADER
    self.title = @"Company";
    
    //NSNOTIFICATIONCENTER OBSERVER WHEN DATA FROM WED ARE ALL TRANSFERED IN DAO
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(financialData) name:@"Data Recieved" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(financialData) name:@"Data Not Found" object:nil];
    [self.dataManager financialData];
    
    //TEST
    NSLog(@"TEST*****TheMainViewController*****LOADED");
    
    //SET TABLEVIEW DELEGATES
    self.companyTableView.delegate = self;
    self.companyTableView.dataSource = self;
    
    //m\TURN INTO method WHEN COMPANIES ARE EMPTY HIDE TABLEVIEW & SHOW EMPTY VIEW
    if([self.dataManager.companyListDAO count] == 0){
        [self.companyTableView setHidden:YES];
        [self.emptyViewAndMessage setHidden:NO];
    } else {
        [self.companyTableView setHidden:NO];
        [self.emptyViewAndMessage setHidden:YES];
    }
    
 
}

//****************************************************************************************
-(void)viewWillAppear:(BOOL)animated{
    
    [self.dataManager financialData];
    [self.companyTableView reloadData];
    
    //HANDLES EDIT BUTTON SHOWS ONLY WHEN EDIT CLICKED & NOT WHEN VIEW FIRST LOADS*
    if ([self.companyTableView isEditing]) {
        [self.undoRedoHolder setHidden:NO];
    }else {
        [self.undoRedoHolder setHidden:YES];
    }
    
    //MOVE OBJECTS UNDERNEATH NAVBAR LOWER
    [self.navigationController.navigationBar setTranslucent:NO];
    
}
//****************************************************************************************

-(void)viewDidAppear:(BOOL)animated{
    
    [self.dataManager financialData];
    [self.companyTableView reloadData];
    
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
//            [cell.imageView setFrame:CGRectMake(0,0,38,38)];
            cell.textLabel.text = currentCompany.companyName;
            
            //ALIGN TEXT LABEL TO LEFT/CENTER/RIGHT
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
//           [cell.imageView sizeToFit];
            [cell.imageView clipsToBounds];
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
                   action:@selector(segueToEditCompany:)
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
        self.dataManager.selectedIndexForRemovalInCoreData = selectedIndex;
        
        //REMOVE COMPANY
        [self.dataManager.companyListDAO removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        //REMOVE MANAGED COMPANY FROM CORE DATA
        [self.dataManager removeManagedCompanyFromCoreData:selectedIndex];
        
        if([self.dataManager.companyListDAO count] == 0){
            [self.companyTableView setHidden:YES];
            [self.emptyViewAndMessage setHidden:NO];
        } else {
            [self.companyTableView setHidden:NO];
            [self.emptyViewAndMessage setHidden:YES];
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
    
    //INIT A VIEW CONTROLLER "CLICK A ROW AND GET A NEW VIEW W/ LIST OF DIFFERENT PRODUCTS"
    MainViewController *companyDetailsView = [[MainViewController alloc]init];
    
    //SET THE HEADER TITLE OF THE PRODUCT VIEW CONTROLLER NEXT PAGE
    companyDetailsView.title = [NSString stringWithFormat:@"%@ Products", selectedCompany.companyName];
    
    //***SAVE LAST KNOW INDEXPATH SELECTED FOR USE TO ADD PRODUCTS***
    self.dataManager.indexOfLastCompanyTouched = indexPath.row;
    companyDetailsView.companyToDisplay = selectedCompany;
    
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
        [self.undoRedoHolder setHidden:YES];
    } else {
        [self.companyTableView setEditing:YES animated:YES];
        self.navigationItem.leftBarButtonItem.title = @"Done";
        [self.undoRedoHolder setHidden:NO];
    }
    
}

//METHOD TO GO TO NEW COMPANY TABLE VIEW SCREEN
-(void)segueToAddCompanyView{
    
    //INITIALIZE THE VIEW YOU'RE TRYING TO SEND TO
    NewCompanyViewController *addNewCompanyView = [[NewCompanyViewController alloc]init];
    
    //SEGUE TO NewComapanyViewController
    [self.navigationController pushViewController:addNewCompanyView animated:YES];
    
}

//METHOD TO SEGUE TO EDIT COMPANY NAME AND LOGO URL
-(void)segueToEditCompany: (UIButton*) sender {
    
    //TEST
    NSLog(@"INDEX OF SELECTED ACC. BUTTON = %ld", (long)sender.tag);
    
    //ALLOC A NEW EDIT COMPANY VIEW CONTROLLER
    EditCompanyViewController *editScreen = [[EditCompanyViewController alloc]init];
    
    //USE THE TAG SET ON THE BUTTON TO DISPLAY THE COMPANY TO BE EDITED  ***
    editScreen.currentCompany = [self.dataManager.companyListDAO objectAtIndex:sender.tag];
    
    //USE THE SENDER TAG TO ASSIGN
    self.dataManager.indexOfLastCompanyTouched = sender.tag;
    
    //SEGUE TO THE NEW VIEW
    [self.navigationController pushViewController:editScreen animated:YES];
    
}


- (void)dealloc {
    [_companyTableView release];
    [_undoRedoHolder release];
    [_emptyViewAndMessage release];
    [_emptyMessage release];
    [super dealloc];
}
- (IBAction)emptyAddCompanyButton:(UIButton *)sender {
    [self segueToAddCompanyView];
}

- (IBAction)undoButton:(UIButton *)sender {
}

- (IBAction)Redo:(UIButton *)sender {
}



@end

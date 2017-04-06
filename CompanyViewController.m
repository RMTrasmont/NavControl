//
//  CompanyViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "CompanyViewController.h"
#import "ProductViewController.h"
#import "NewCompanyViewController.h"
@interface CompanyViewController ()

@property (nonatomic) DAO *dataManager;

@end

@implementation CompanyViewController

//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //SET THE DAO PROPERTY OF THIS VIEW(self.dataManager) AS DAO OF THE DAO CLASS(sharedManager)
    self.dataManager = [DAO sharedManager];//<---- *LOOK OVER ******
    
    //TEST CORE DATA*
    //NSLog(@"TEST COMPANY %@",self.dataManager.managedCompanyListDAO);
    NSLog(@"TEST MANAGED COMPANY PRODUCT %@",self.dataManager.managedCompanyListDAO[0].products);
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
 
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
    
    
}

//****************************************************************************************
-(void)viewWillAppear:(BOOL)animated{

    [self.dataManager financialData];
    [self.tableView reloadData];
    
    //FOOTERVIEW SHOWS UP WHEN EDIT BUTTON CLICKED
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,self.view.frame.size.height/15)];
    footerView.backgroundColor = [UIColor redColor];
    
    
    UIButton *undoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [undoButton setTitle:@"Undo" forState:UIControlStateNormal];
    //[undoButton addTarget:self action:@selector(undoChnages) forControlEvents:UIControlEventTouchUpInside];
    undoButton.frame=CGRectMake( (footerView.frame.size.width / 8) , -5, 70, 35);
    [undoButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [undoButton setTintColor:[UIColor whiteColor]];

    [footerView addSubview:undoButton];
    UIButton *redoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [redoButton setTitle:@"Redo" forState:UIControlStateNormal];
    //[redoButton addTarget:self action:@selector(redoChange) forControlEvents:UIControlEventTouchUpInside];
    redoButton.frame = CGRectMake((footerView.frame.size.width /1.6)  , -5, 70, 35);
    [redoButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [redoButton setTintColor:[UIColor whiteColor]]; ;
    [footerView addSubview:redoButton];
    
    self.tableView.tableFooterView = footerView;
    
    if (![self.tableView isEditing]) {
        [self.tableView.tableFooterView setHidden:YES];
    }
    
}
//****************************************************************************************

-(void)viewDidAppear:(BOOL)animated{
    
    [self.dataManager financialData];
    [self.tableView reloadData];

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
    
    //ASSIGN COMPANY NAME TO THE CELL TEXT LABEL
    cell.textLabel.text = currentCompany.companyName;
    
    //ALIGN TEXT LABEL TO LEFT/CENTER/RIGHT
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    
    //ASSIGN COMPANY LOGO TO CELL...make ImageViewFrame 48x48
    [cell.imageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:currentCompany.companyLogoURL]]];
    [cell.imageView setFrame:CGRectMake(0,0,48,48)];
    //[cell.imageView sizeToFit];
    //[cell.imageView clipsToBounds];
    
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




 //Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//     //Return NO if you do not want the specified item to be editable.
//    return YES;
//}


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
    self.productViewController = [[MainViewController alloc]init];
   
    //SET THE HEADER TITLE OF THE PRODUCT VIEW CONTROLLER NEXT PAGE
    self.productViewController.title = [NSString stringWithFormat:@"%@ Products", selectedCompany.companyName];
    
    //***SAVE LAST KNOW INDEXPATH SELECTED FOR USE TO ADD PRODUCTS***
    self.dataManager.indexOfLastCompanyTouched = indexPath.row;
    self.productViewController.companyToDisplay = selectedCompany;
    
    //PUSHES TO THE DIFFERENT PRODUCTS FROM THE COMPANY TO THE PRODUCT VIEW CONTROLLER
    
    [self.navigationController
        pushViewController:self.productViewController
        animated:YES];

}

//METHOD TO HIDE AND SHOW FOOTERVIEW WHEN EDIT CLICKED
-(void)toggleEditMode {
    
    if (self.tableView.isEditing) {
        [self.tableView setEditing:NO animated:YES];
        self.navigationItem.leftBarButtonItem.title = @"Edit";
        [self.tableView.tableFooterView setHidden:YES];
    } else {
        [self.tableView setEditing:YES animated:YES];
        self.navigationItem.leftBarButtonItem.title = @"Done";
        [self.tableView.tableFooterView setHidden:NO];
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

@end
    


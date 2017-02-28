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

@property (nonatomic) DAO *dataManager;   //<---- USE DAO AS PROPERTY ******

@end

@implementation CompanyViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //SET THE DAO PROPERTY OF THIS VIEW(self.dataManager) AS DAO OF THE DAO CLASS(sharedManager)
    self.dataManager = [DAO sharedManager];                                                     //<---- *LOOK OVER ******
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
   // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //DISPLAY EDIT BUTTON ON LEFTSIDE OF BAR
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    //DISPLAY ADD + BUTTON TO RIGHT SIDE OF BAR
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                               target:self
                                               action:@selector(segueToAddCompanyView)]  //<---MAKE & DEFINE METHOD
                                               autorelease];
    
    //SET TITLE OF HEADER
    self.title = @"Company";
    
    
    
}


//****************************************************************************************
-(void)viewWillAppear:(BOOL)animated{
    
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
    return self.dataManager.companyListDAO.count;     //<---- *LOOK OVER ******
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //ASSIGN COMPANY FROM ARRAY TO TABLE CELLS DEPENDING ON INDEX... "COMPANYARRAY[1] goes in INDEXPATH[1] etc"
    
    Company *currentCompany = self.dataManager.companyListDAO[indexPath.row];
    
    //ASSIGN COMPANY NAME TO THE CELL TEXT LABEL
    cell.textLabel.text = currentCompany.companyName;
    
    //ALIGN TEXT LABEL TO LEFT/CENTER/RIGHT
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    
    //ASSIGN COMPANY LOGO TO CELL...
    [cell.imageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:currentCompany.companyLogoURL]]];
    
    //ASSIGN CUSTOM BUTTON TO ACCESSORY VIEW CELL TO EDIT NAMES AND URL...
        //NOTE: cell.editingAccessoryView(SHOWS UP ON CELL WHEN "EDIT" IS CLICKED)
        //NOTE: cell.accessoryView(SHOWS UP ON CELL WITHOUT "EDIT" BEING CLICKED)
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [editButton setImage:[UIImage imageNamed:@"editPencil(48x48)"] forState:UIControlStateNormal];
    [editButton setFrame:CGRectMake(0, 0, 24, 24)];
        //ADD METHOD TO THE BUTTON;
    [editButton addTarget:self                                  
                action:@selector(segueToEditCompanyScreen)  // <--- NEED TO CREATE METHOD*****************
                forControlEvents:UIControlEventTouchUpInside];
    
    //cell.accessoryView = editButton;                // <--- SHOW ON CELL RIGHT AWAY
    cell.editingAccessoryView = editButton;       // <--- SHOW ON CELL ONCE EDIT BUTTON CLICKED
    
    
    return cell;


}




 //Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//     //Return NO if you do not want the specified item to be editable.
//    return YES;
//}



// Override to support EDITING the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
   if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataManager.companyListDAO removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    
   else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
       
    }
  


}
 
 

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //DEFINE THE COMPANY THAT IS CLICKED
    
    Company *selectedCompany = self.dataManager.companyListDAO[indexPath.row];
    
    //INIT A VIEW CONTROLLER "CLICK A ROW AND GET A NEW VIEW W/ LIST OF DIFFERENT PRODUCTS"
    
    self.productViewController = [[ProductViewController alloc]init];   // <--- Order Matters*
   
    //SET THE HEADER TITLE OF THE PRODUCT VIEW CONTROLLER NEXT PAGE
    
    self.productViewController.title = [NSString stringWithFormat:@"%@ Products", selectedCompany.companyName];
    
    //***SAVE LAST KNOW INDEXPATH SELECTED FOR USE TO ADD PRODUCTS***
    self.dataManager.indexOfLastCompanyTouched = [indexPath row];
    
    // PUSHES TO THE DIFFERENT PRODUCTS FROM THE COMPANY TO THE PRODUCT VIEW CONTROLLER
    
    [self.navigationController
        pushViewController:self.productViewController
        animated:YES];
    
    

}


//DELETE FUNCTION TO DELETE ROW OF COMPANIES
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    //REMOVES THE ACTUAL OBJECT FROM THE NSMUTABLE ARRAY THE TABLEVIEW USES
//    [self.dataManager.companyListDAO removeObjectAtIndex:indexPath.row];
//    
//    //CALL TO REFRESH THE DATA AND UPDATE NUMBER OF ITEMS
//    [tableView reloadData];
//}

//METHOD TO GO TO NEW COMPANY TABLE VIEW SCREEN
-(void)segueToAddCompanyView{
    
    //INITIALIZE THE VIEW YOU'RE TRYING TO SEND TO
    NewCompanyViewController *addNewCompanyView = [[NewCompanyViewController alloc]init];
    
    //SEGUE TO NewComapanyViewController
    [self.navigationController pushViewController:addNewCompanyView animated:YES];
     
}

//METHOD TO SEGUE TO EDIT COMPANY NAME AND LOGO URL
-(void)segueToEditCompanyScreen{
    
    //INITALIZE THE VIEW YOU'RE TRYING TO GO TO
    
    //SEGUE TO THE NEW VIEW
    
}



@end
    


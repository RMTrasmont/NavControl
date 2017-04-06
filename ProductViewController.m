//
//  ProductViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "ProductViewController.h"
#import "WebVCViewController.h"
#import "NewProductsViewController.h"
#import "DAO.h"

@interface ProductViewController ()

@property (nonatomic)DAO *dataManager;

@end

@implementation ProductViewController

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
    
    self.dataManager = [DAO sharedManager];
    
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    //DISPLAY ADD + BUTTON TO RIGHT SIDE OF BAR
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                               target:self
                                               action:@selector(segueToAddProductView)]   //<---MAKE & DEFINE METHOD
                                               autorelease];
    
    
    
    //DISPLAY "BACK" BUTTON TO LEFT SIDE OF BAR
//    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]
//                                               initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
//                                               target:self
//                                               action:@selector(segueToCompanyView)]     //<---MAKE & DEFINE
//                                               autorelease];
//    
    
   //CUSTOM "SHOOT BACK" BUTTON
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backButton.frame = CGRectMake(0, 0, 36, 36);
    backButton.showsTouchWhenHighlighted = YES;
    [backButton setImage:[UIImage imageNamed:@"simpleBackArrow"] forState:UIControlStateNormal];
    backButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    //ADD ACTION TO BUTTON
    [backButton addTarget:self action:@selector(segueToCompanyView) forControlEvents:UIControlEventTouchUpInside];
    //CONVERT FROM UIBUTTON TO UIBARBUTTON
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    self.navigationItem.leftBarButtonItem = backBarButtonItem;


    
}

//********************************************************************************************
//A VIEW WILL APPEAR THAT CATEGORIZES THE VIEW Brands -> Products  self.Title refers Title at the TOP Part of the View

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    
    
}

//********************************************************************************************


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
    return self.dataManager.companyListDAO[self.dataManager.indexOfLastCompanyTouched].companyProductList.count;
}

//********************************************************************************************
#pragma mark - Table View Cells

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Product *currentProduct = self.dataManager.companyListDAO[self.dataManager.indexOfLastCompanyTouched].companyProductList[indexPath.row];
    
    // Configure the cell...
    cell.textLabel.text = currentProduct.productName;
    
    //CENTER THE TEXT IN THE CELLS
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    //ASSIGN CUSTOM BUTTON TO ACCESSORY VIEW CELL TO EDIT NAMES AND URL...
    //NOTE: cell.editingAccessoryView(SHOWS UP ON CELL WHEN "EDIT" IS CLICKED)
    //NOTE: cell.accessoryView(SHOWS UP ON CELL WITHOUT "EDIT" BEING CLICKED)
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [editButton setImage:[UIImage imageNamed:@"editPencil(48x48)"] forState:UIControlStateNormal];
    [editButton setFrame:CGRectMake(0, 0, 24, 24)];
    //ADD METHOD TO THE BUTTON;
    [editButton addTarget:self
                   action:@selector(segueToEditProductScreen:)
         forControlEvents:UIControlEventTouchUpInside];
    
    //***ADD TAG TO THE BUTTON THAT IS INDEXPATH.ROW***
    [editButton setTag:indexPath.row];
    
    cell.accessoryView = editButton;           // <--- SHOW ON CELL RIGHT AWAY
    //cell.editingAccessoryView = editButton;  // <--- SHOW ON CELL ONCE EDIT BUTTON CLICKED

    
    return cell;
}

//********************************************************************************************
// DO ALL CUSTOMIZING OF CELLS HERE INSIDE THIS METHOD

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
     Product *currentProduct = self.dataManager.companyListDAO[self.dataManager.indexOfLastCompanyTouched].companyProductList[indexPath.row];
    
    //INITIALIZE CUSTOM OBJECT TO ASSIGN WEB URL TO ITS URL PROPERTY
    WebVCViewController *webVC = [[WebVCViewController alloc]init];
    
   //SETS THE NEXT VIEW'S WEBURL TO BE WHAT WE SELECTED IT HERE ON THIS PAGE
    webVC.webURL = currentProduct.productURL;
    
    //*** SAVE LAST CLICKED PRODUCT INDEX ****
    self.dataManager.indexOfLastProductTouched = indexPath.row;
    
    //PUSHES THE NEXT VIEW
    [self.navigationController pushViewController:webVC animated:YES];
    
    
    //PRINT OUT NAME OF COMPANY AND ATTRIBUTES
    NSLog(@"%@",currentProduct.productName);
    NSLog(@"%@",currentProduct.productURL);

}

//********************************************************************************************

//DELETE PRODUCTS ON TABLEVIEW CELL METHOD
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //REMOVES THE ACTUAL OBJECT FROM THE NSMUTABLE ARRAY THE TABLEVIEW USES
    [self.dataManager.companyListDAO[self.dataManager.indexOfLastCompanyTouched].companyProductList removeObjectAtIndex:indexPath.row];
    
    //CALL TO REFRESH THE DATA AND UPDATE NUMBER OF ITEMS
    [tableView reloadData];
    

}

//********************************************************************************************
//PUSH TO THE VIEW TO ADD PRODUCTS
-(void)segueToAddProductView{
    
    //INIT A VIEW CONTROLLER OF THE KIND NEWPRODUCT
    NewProductsViewController *addNewProductView = [[NewProductsViewController alloc]init];
    
    //SEGUE TO THAT NEW PRODUCTS VIEW CONTROLLER
    [self.navigationController pushViewController:addNewProductView animated:YES];
}

////********************************************************************************************
//MOVE BACK TO MAIN COMPANYVIEW
-(void)segueToCompanyView{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//METHOD TO SEGUE "PUSH" TO EDIT PRODUCT SCREEN
-(void)segueToEditProductScreen:(UIButton *)sender{
    
    //TEST
    NSLog(@"INDEX OF SELECTED ACC. BUTTON = %ld", (long)sender.tag);
    
    EditProductViewController *editScreen = [[EditProductViewController alloc]init];
    
    //ASSIGN VALUES TO THE CURRENT PARENT COMPANY AND CURRENT PRODUCT TO EDIT SCREEN
    Company *currentCompany = [self.dataManager.companyListDAO objectAtIndex:self.dataManager.indexOfLastCompanyTouched];
    editScreen.currentParentCompany = currentCompany;
    
    Product *currentProduct = [currentCompany.companyProductList objectAtIndex:sender.tag];
    editScreen.currentProduct = currentProduct;
    
    //SET THE VALUE OF THE LAST EDIT BUTTON TOUCHED
    self.dataManager.indexOfLastAccessoryButtonTouched = sender.tag;
    
    [self.navigationController pushViewController:editScreen animated:YES];
}

////********************************************************************************************
////ADD FOOTERVIEW
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    
//    UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,self.view.frame.size.height)];
//    footerView.backgroundColor = [UIColor redColor];
//    [self tableView:self.tableView heightForFooterInSection:self.view.frame.size.height * 0.05];
//    UIButton *undoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [undoButton setTitle:@"Undo" forState:UIControlStateNormal];
//    //[undoButton addTarget:self action:@selector(undoChnages) forControlEvents:UIControlEventTouchUpInside];
//    undoButton.frame=CGRectMake( (footerView.frame.size.width / 8) , -5, 70, 35);
//    [undoButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
//    [footerView addSubview:undoButton];
//    
//    UIButton *redoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [redoButton setTitle:@"Redo" forState:UIControlStateNormal];
//    //[redoButton addTarget:self action:@selector(redoChange) forControlEvents:UIControlEventTouchUpInside];
//    redoButton.frame = CGRectMake((footerView.frame.size.width /1.6)  , -5, 70, 35);
//    [redoButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
//    
//    [footerView addSubview:redoButton];
//    
//    return footerView;
//    
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return self.view.frame.size.height * 0.05;
//}


@end

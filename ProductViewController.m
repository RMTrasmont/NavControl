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
    backButton.frame = CGRectMake(0, 0, 60, 48);
    backButton.showsTouchWhenHighlighted = YES;
    [backButton setImage:[UIImage imageNamed:@"shootBack"] forState:UIControlStateNormal];
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
    return cell;
}

//********************************************************************************************
// DO ALL CUSTOMIZING OF CELLS HERE INSIDE THIS METHOD

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //INITIALIZE CUSTOM OBJECT TO ASSIGN WEB URL TO ITS URL PROPERTY
    WebVCViewController *webVC = [[WebVCViewController alloc]init];
    
    Product *currentProduct = self.dataManager.companyListDAO[self.dataManager.indexOfLastCompanyTouched].companyProductList[indexPath.row];
    
    //SET URL VARIABLE FOR PRODUCTSURL
    self.productURL = currentProduct.productURL;
    
   
    //SETS THE NEXT VIEW'S WEBURL TO BE WHAT WE SELECTED IT HERE ON THIS PAGE
    webVC.webURL = self.productURL;
    
    //PUSHES THE NEXT VIEW
    [self.navigationController pushViewController:webVC animated:NO];

}

//********************************************************************************************


//CONVERT NSARRAY INTO NSMUTABLE ARRAY
- (NSMutableArray *)createMutableArray:(NSArray *)array
{
    return [NSMutableArray arrayWithArray:array];
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

@end

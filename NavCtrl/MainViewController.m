//
//  MainViewController.m
//  NavControllerMainViewRefactor
//
//  Created by Rafael M. Trasmontero on 4/3/17.
//  Copyright © 2017 TurnToTech. All rights reserved.
//

#import "MainViewController.h"
#import "DAO.h"

@interface MainViewController ()

@property DAO *dataManager;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataManager = [DAO sharedManager];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    //DISPLAY ADD + BUTTON TO RIGHT SIDE OF BAR
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                               target:self
                                               action:@selector(pushToAddProductView)]
                                              autorelease];
    
    
    
    //CUSTOM "BACK" BUTTON
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backButton.frame = CGRectMake(0, 0, 40, 40);
    backButton.showsTouchWhenHighlighted = YES;
    [backButton setImage:[UIImage imageNamed:@"simpleBackArrow"] forState:UIControlStateNormal];
    backButton.imageEdgeInsets = UIEdgeInsetsMake(10,10,10,10);
    //ADD ACTION TO BUTTON
    [backButton addTarget:self action:@selector(popToCompanyView) forControlEvents:UIControlEventTouchUpInside];
    //CONVERT FROM UIBUTTON TO UIBARBUTTON
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    [backBarButtonItem release];
    //SET TABLEVIEW DELEGATE
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    

    
    //ASSIGN IMAGE IN DETAILS VIEW AS THE FETCHED IMAGES FROM THE MAIN VIEW
    [self.logoImageView setImage:self.companyToDisplay.fetchedLogoImage];
    
    //ASSIGN STOCK INFO ON LABEL ON DETAILS VIEW
    self.stockPriceLabel.text = self.companyToDisplay.financialDataString;
    
}

//**************************************************************************************

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
    //MOVE OBJECTS UNDERNEATH NAVBAR LOWER
    [self.navigationController.navigationBar setTranslucent:NO];
    
    //ADD MESSAGE TO EMPTY PRODUCTS VIEW
    self.emptyProductsLabel.text = [NSString stringWithFormat:@"Add %@ products to track",self.dataManager.currentCompanyDAO.companyName];

    //HIDE/SHOW TABLEVIEW DEPENDING ON NUMBER OF PRODUCTS
    if(self.dataManager.currentCompanyDAO.companyProductList.count >= 1){
        [self.tableView setHidden:NO];
        //[self.tableView reloadData];
    } else if(self.dataManager.currentCompanyDAO.companyProductList.count == 0){
        [self.tableView setHidden:YES];
        //[self.tableView reloadData];
    }

    [self.tableView reloadData];

}

//*************************************************************************************


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
    return self.companyToDisplay.companyProductList.count;
}

//*************************************************************************************


#pragma mark - Table View Cells

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.tableView = tableView;
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];    }
    
    Product *currentProduct = self.dataManager.currentCompanyDAO.companyProductList[indexPath.row];
    
    //**********************RUN ON DIFF THREAD/GCD********************************
    //1. GET ALL IMAGES FROM ONLINE RUN ON DIFFERENT THREAD
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage *imageToSet = [UIImage imageWithData:[NSData dataWithContentsOfURL:currentProduct.productImageURL]];
        currentProduct.fetchedLogoImage = imageToSet;
        
        //**********************BACK TO MAIN THREAD*****************************
        //2.ALL IMAGES FETCHED,GO BACK TO THE MAIN QUEUE,AND ASSIGN IMAGES
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell.imageView setImage:imageToSet];
            cell.textLabel.text = currentProduct.productName;
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
    
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [editButton setImage:[UIImage imageNamed:@"editPencil(48x48)"] forState:UIControlStateNormal];
    [editButton setFrame:CGRectMake(0, 0, 24, 24)];
    //ADD METHOD TO THE BUTTON;
    [editButton addTarget:self
                   action:@selector(pushToEditProductScreen:)
         forControlEvents:UIControlEventTouchUpInside];
    
    //***ADD TAG TO THE BUTTON THAT IS INDEXPATH.ROW***
    [editButton setTag:indexPath.row];
    
    cell.accessoryView = editButton;           // <--- SHOW ON CELL RIGHT AWAY
    //cell.editingAccessoryView = editButton;  // <--- SHOW ON CELL ONCE EDIT BUTTON CLICKED
    
    return cell;
}

//*************************************************************************************
// DO ALL CUSTOMIZING OF CELLS HERE INSIDE THIS METHOD

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Product *currentProduct = [self.dataManager.currentCompanyDAO.companyProductList objectAtIndex:[indexPath row]];
    
    //INITIALIZE CUSTOM OBJECT TO ASSIGN WEB URL TO ITS URL PROPERTY
    WebVCViewController *webVC = [[WebVCViewController alloc]init];
    
    //SETS THE NEXT VIEW'S WEBURL TO BE WHAT WE SELECTED IT HERE ON THIS PAGE
    webVC.webURL = currentProduct.productURL;
    
    //PUSHES THE NEXT VIEW// ANIMATED
    //[self.navigationController pushViewController:webVC animated:YES];
    CATransition* transition = [CATransition animation];
    transition.duration = 0.8f;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFade;
    [self.navigationController.view.layer addAnimation:transition
                                                forKey:kCATransition];
    [self.navigationController pushViewController:webVC animated:YES];

    [webVC release];
    
    //PRINT OUT NAME OF COMPANY AND ATTRIBUTES
    NSLog(@"%@",currentProduct.productName);
    NSLog(@"%@",currentProduct.productURL);
    
}

//*************************************************************************************

//DELETE PRODUCTS ON TABLEVIEW CELL METHOD
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    //REMOVES THE ACTUAL OBJECT FROM THE NSMUTABLE ARRAY THE TABLEVIEW USES
//    [self.dataManager.currentCompanyDAO.companyProductList removeObjectAtIndex:indexPath.row];
//    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    
//    //self.dataManager.currentManagedCompanyDAO.products
//    ManagedCompany *mC = self.dataManager.currentManagedCompanyDAO;
//    //CONVERT NS SET TO NS ARRAY TO USE INDEXPATH TO GET MANAGED PRODUCT
//    NSMutableArray *productArray = [[NSMutableArray alloc]initWithArray:[mC.products allObjects]];
//    ManagedProduct *mP = productArray[indexPath.row];
//    [productArray release];
//    
//    //LET DAO KNOW THE CURRENT MANAGED PRODUCT
//    self.dataManager.currentManagedProductDAO = mP;
    
    
    //REMOVE MANAGED MANAGED PRODUCT FROM CORE DATA
//    [self.dataManager removeManagedProductFromCoreData:mP fromManagedCompany:mC];
    
    //IF PRODUCTS ARRAY IS EMPTY HIDE TABLE
    if(self.dataManager.currentCompanyDAO.companyProductList.count == 0){
        [self.tableView setHidden:YES];
        [self.tableView reloadData];
    }
    
    //CALL TO REFRESH THE DATA AND UPDATE NUMBER OF ITEMS
    [tableView reloadData];
    
    
}

//***********************************************************************************
//PUSH TO THE VIEW TO ADD PRODUCTS
-(void)pushToAddProductView{
    
    //INIT A VIEW CONTROLLER OF THE KIND NEWPRODUCT
    NewProductsViewController *addNewProductView = [[NewProductsViewController alloc]init];
    
    //SEGUE TO THAT NEW PRODUCTS VIEW CONTROLLER
    //[self.navigationController pushViewController:addNewProductView animated:YES];
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.4f;
    transition.type = kCATransitionReveal ;
    transition.subtype = kCATransitionFromRight;
    [self.navigationController.view.layer addAnimation:transition
                                                forKey:kCATransition];
    [self.navigationController pushViewController:addNewProductView animated:YES];

    
    [addNewProductView release];
}

//************************************************************************************

-(void)viewDidDisappear:(BOOL)animated{
//    for(Product *product in _companyToDisplay.companyProductList){
//        product.fetchedLogoImage = nil;
//        product.productImageURL = nil;
//    }
}

//MOVE BACK TO MAIN COMPANYVIEW
-(void)popToCompanyView{
    [self.navigationController popViewControllerAnimated:YES];
    
    
   
}

//METHOD TO SEGUE "PUSH" TO EDIT PRODUCT SCREEN
-(void)pushToEditProductScreen:(UIButton *)sender{
    
    //TEST
    NSLog(@"INDEX OF SELECTED ACC. BUTTON = %ld", (long)sender.tag);
    
    EditProductViewController *editScreen = [[EditProductViewController alloc]init];
    
    //ASSIGN VALUES TO THE CURRENT PARENT COMPANY AND CURRENT PRODUCT TO EDIT SCREEN
    Company *currentCompany = self.dataManager.currentCompanyDAO;
    editScreen.currentParentCompany = currentCompany;
    
    Product *currentProduct = [currentCompany.companyProductList objectAtIndex:sender.tag];
    editScreen.currentProduct = currentProduct;
    
    //SET THE VALUE OF THE LAST EDIT BUTTON TOUCHED
//    self.dataManager.indexOfLastAccessoryButtonTouched = sender.tag;
    
    //ANIMATED TRANSITION
    //[self.navigationController pushViewController:editScreen animated:YES];
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.4f;
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition
                                                forKey:kCATransition];
    [self.navigationController pushViewController:editScreen animated:YES];
    
    
    [editScreen release];
}


////************************************************************************************
- (void)dealloc {
    [_companyToDisplay release];
    [_detailsHolderView release];
    [_logoImageView release];
    [_stockPriceLabel release];
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    [_tableView release];
    [_undoRedoHolderView release];
    [_emptyProductsSubView release];
    [_emptyProductsLabel release];
    [_currentManagedProductSet release];
    [_sortDescriptors release];
    [super dealloc];
}
- (IBAction)undoButton:(UIButton *)sender {
    NavControllerAppDelegate *appDelegate = (NavControllerAppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate.managedObjectContext undo];
    [self.dataManager loadFetchedFromCoreData];
    [self.tableView reloadData];
}

- (IBAction)redoButton:(UIButton *)sender {
    NavControllerAppDelegate *appDelegate = (NavControllerAppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate.managedObjectContext redo];
    [self.dataManager loadFetchedFromCoreData];
    [self.tableView reloadData];
}
- (IBAction)emptyProductsAddProductButton:(UIButton *)sender {
    NewProductsViewController *pVC = [[NewProductsViewController alloc]init];
    [self.navigationController pushViewController:pVC animated:YES];
    [pVC release];
}



@end

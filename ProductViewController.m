//
//  ProductViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "ProductViewController.h"
#import "WebVCViewController.h"
@interface ProductViewController ()

@property (retain,nonatomic)NSMutableArray *mutableProductList;

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

    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //ARRAY OF PRODUCTS
    self.products = @[@"iPad",@"iPod Touch",@"iPhone",@"Galaxy S4", @"Galaxy Note", @"Galaxy Tab",@"Pixel",@"Pixel XL",@"Pixel C",@"V10",@"V20",@"G5"];
    
    //MUTABEL ARRAY OF PRODUCST
    

}

//********************************************************************************************
//A VIEW WILL APPEAR THAT CATEGORIZES THE VIEW Brands -> Products  self.Title refers Title at the TOP Part of the View

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    //IF THE TITLE ON TOP OF TABLE IS THIS...PLACES THESE PRODUCTS ON THE ROWS BELOW IT
    //CREATE A NEW ARRAY EACH TIME -->[[NSMutableArray alloc]initWithObjects:
    if ([self.title isEqualToString:@"Apple mobile devices"]) {
        _mutableProductList = [[NSMutableArray alloc]initWithObjects:@"iPad",@"iPod Touch",@"iPhone", nil];
    } else if ([self.title isEqualToString:@"Samsung mobile devices"]){
        _mutableProductList = [[NSMutableArray alloc]initWithObjects:@"Galaxy S4", @"Galaxy Note", @"Galaxy Tab", nil];
    } else if ([self.title isEqualToString:@"Google mobile devices"]){
        _mutableProductList = [[NSMutableArray alloc]initWithObjects:@"Pixel",@"Pixel XL",@"Pixel C" , nil];
    } else {
        _mutableProductList = [[NSMutableArray alloc]initWithObjects:@"V10",@"V20",@"G5", nil];
    }
    
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
    return [_mutableProductList count];
}

//********************************************************************************************

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    cell.textLabel.text = [_mutableProductList objectAtIndex:[indexPath row]];
    return cell;
}

//********************************************************************************************
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];

    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
 
 */

//********************************************************************************************
// DO ALL CUSTOMIZING OF CELLS HERE INSIDE THIS METHOD

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //INITIALIZE CUSTOM OBJECT TO ASSIGN WEB URL TO ITS URL PROPERTY
    WebVCViewController *webVC = [[WebVCViewController alloc]init];
    
    
    //Apple Products
    if([self.title isEqualToString:@"Apple mobile devices"]){
    switch (indexPath.row){
        case 0:
          self.productURL = @"http://www.apple.com/ipad/";
            break;
        case 1:
            self.productURL = @"http://www.apple.com/ipod-touch/";
            break;
        case 2:
            self.productURL = @"http://www.apple.com/iphone/";
            break;
        default:
            break;
        }
    }
    //Samsung Products
       else if ([self.title isEqualToString:@"Samsung mobile devices"]){
        switch (indexPath.row) {
            case 0:
                self.productURL = @"http://www.samsung.com/us/mobile/phones/all-phones/s/galaxy_s4/_/n-10+11+hv1rp+trouu";
                break;
            case 1:
                self.productURL = @"http://www.samsung.com/us/mobile/phones/all-phones/s/galaxy_note5/_/n-10+11+hv1rp+troum";
                break;
            case 2:
                self.productURL = @"http://www.samsung.com/us/search/searchMain?Dy=1&Nty=1&Ntt=galaxy+tabpro+s";
                break;
            default:
                break;
        }
    }
    //Google Products
       else if ([self.title isEqualToString:@"Google mobile devices"]){
           switch (indexPath.row) {
               case 0:
                   self.productURL = @"https://store.google.com/search?q=pixel";
                   break;
               case 1:
                   self.productURL = @"https://store.google.com/search?q=pixel%20xl";
                   break;
               case 2:
                   self.productURL = @"https://store.google.com/search?q=pixel%20c";
                   break;
               default:
                   break;
           }
       }
    //LG Products
       else {
           switch (indexPath.row) {
               case 0:
                   self.productURL = @"http://www.lg.com/us/mobile-phones/v10";
                   break;
               case 1:
                   self.productURL = @"http://www.lg.com/us/mobile-phones/v20";
                   break;
               case 2:
                   self.productURL = @"http://www.lg.com/us/mobile-phones/g5#G5Modularity";
                   break;
               default:
                   break;
           }
       }
    
    
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
   [_mutableProductList removeObjectAtIndex:indexPath.row];
    
    //CALL TO REFRESH THE DATA AND UPDATE NUMBER OF ITEMS
    [tableView reloadData];
}

//********************************************************************************************
//ALLOW REORDER OF CELLS
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
}
//********************************************************************************************


@end

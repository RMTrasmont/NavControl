//
//  CompanyDAO.h
//  NavCtrl
//
//  Created by Rafael M. Trasmontero on 2/13/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"
#import "Product.h"
#import "NewCompanyViewController.h"
#import "NewProductsViewController.h"
#import "CompanyViewController.h"
#import "ProductViewController.h"
@interface DAO : NSObject


//Singleton

+ (id)sharedManager;

-(void)firstRun;

// COMPANY AND NEW PRODUCT PROPERTIES GET SET HERE
@property(strong,nonatomic)NSMutableArray <Company *> *companyListDAO;

//PROPERTY FOR LAST TOUCHED COMPANY INDEX
@property (nonatomic) NSInteger indexOfLastCompanyTouched;

//CREATE A COMPANY METHOD
-(Company *)makeNewCompanyWithName:(NSString *)name andLogoURL:(NSURL *)logoURL;

//CREATE A PRODUCT METHOD
-(Product *)makeNewProductWithName:(NSString *)name andURL:(NSURL *)url;

//ADD COMPANY  TO COMAPNYLIST IN DAO METHOD
-(void)addCompanyToList:(Company *)company;



@end

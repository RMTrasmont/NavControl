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

@interface DAO : NSObject

//Singleton

+ (id)sharedManager;

-(void)firstRun;

//AN ARRAY OF COMPANIES
@property (strong,nonatomic) NSMutableArray *companyList;

//"CREAT ,READ, UPDATE ,DELETE"

//**************************CREATE***********************************
//- (NSMutableArray *)companyArray;
//
//- (NSMutableArray *)productsArray;
//
//- (Company *)companyName: (NSString *)name withImage:(UIImage *)imageName andProducts:(NSMutableArray *)products;
//
//- (Product *)productName:(NSString *)name fromCompany:(NSString *)company withURL:(NSURL *)url;

//**************************READ***********************************



//**************************UPDATE***********************************
//add products to Company array
//-(void)addProduct:(NSString *)productName toCompany:(NSString *)companyName;


//**************************DELETE***********************************
//delete products from company array
//delete company itself

@end

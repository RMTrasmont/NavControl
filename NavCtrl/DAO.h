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
#import <CoreData/CoreData.h>
#import "ManagedCompany+CoreDataClass.h"
#import "ManagedProduct+CoreDataClass.h"
#import "ManagedCompany+CoreDataProperties.h"
#import "ManagedProduct+CoreDataProperties.h"
#import "NavControllerAppDelegate.h"
@interface DAO : NSObject <NSFetchRequestResult>

+ (id)sharedManager;
-(void)firstRun;
@property (strong,nonatomic)NSMutableArray <Company *> *companyListDAO;
@property (strong,nonatomic)NSMutableArray<ManagedCompany *> *managedCompanyListDAO;
-(Company *)makeNewCompanyWithName:(NSString *)name withLogoURL:(NSURL *)logoURL andStockSymbol:(NSString *)ticker;
-(Product *)makeNewProductWithName:(NSString *)name withWebURL:(NSURL *)webURL andImageURL:(NSURL *)imageURL;
-(void)addCompanyToList:(Company *)company;
-(void)removeCompanyFromList;
-(void)getAPIFinancialData;
@property (strong,nonatomic)NSArray *fetchedFinDataArrayDAO;
@property (strong,nonatomic) NSManagedObjectContext *managedObjectContextDAO;
-(void) loadFetchedFromCoreData;
-(void)initializeCoreData;
@property (strong,nonatomic)Company *currentCompanyDAO;
@property (strong,nonatomic)Company *theNewCompanyDAO;
@property(strong,nonatomic)Product *theNewProductDAO;
@property (strong,nonatomic)ManagedCompany *currentManagedCompanyDAO;
@property (strong,nonatomic)Company *companyBeingEditedDAO;
@property (nonatomic)BOOL editingCompanyNameDAO;
@property (nonatomic)BOOL editingCompanyLogoURLDAO;
@property(strong,nonatomic)ManagedProduct *currentManagedProductDAO;
@property(strong,nonatomic)Product *productBeingEditedDAO;
@property (nonatomic)BOOL editingProductNameDAO;
@property (nonatomic)BOOL editingProductURLDAO;
@property(nonatomic)BOOL editingProductImageURLDAO;
@end

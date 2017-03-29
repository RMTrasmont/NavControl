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
#import <CoreData/CoreData.h>        //<---
#import "ManagedCompany+CoreDataClass.h" //<---
#import "ManagedProduct+CoreDataClass.h"  //<---
#import "ManagedCompany+CoreDataProperties.h"  //<---
#import "ManagedProduct+CoreDataProperties.h"  //<---

@interface DAO : NSObject <NSFetchRequestResult>


//SINGLETON

+ (id)sharedManager;

-(void)firstRun;

//COMPANY & MANAGED COMAPNY ARRAYS
@property(strong,nonatomic)NSMutableArray <Company *> *companyListDAO;
@property (strong,nonatomic)NSMutableArray<ManagedCompany *> *managedCompanyListDAO;

//INDEXES
@property (nonatomic) NSInteger indexOfLastCompanyTouched;
@property (nonatomic) NSInteger indexOfLastProductTouched;
@property (nonatomic) NSInteger indexOfLastAccessoryButtonTouched;

//CREATION METHODS
-(Company *)makeNewCompanyWithName:(NSString *)name withLogoURL:(NSURL *)logoURL andStockSymbol:(NSString *)ticker;
-(Product *)makeNewProductWithName:(NSString *)name andURL:(NSURL *)url;

//ADD COMPANY METHOD
-(void)addCompanyToList:(Company *)company;

//REMOVE COMPANY METHOD
-(void)removeCompanyFromList;

//GET STOCK QUOTE
-(void)getAPIFinancialData;

//CORE DATA STACK 
@property (strong,nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong,nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong,nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong,nonatomic) NSManagedObject *currentManagedObject;
@property (strong,nonatomic) NSFetchedResultsController *fetchedController;

//METHODS FOR SAVING TO CORE DATA
-(void)initializeCoreData;
-(void)saveManagedObject;
-(void)saveNewCompanyToCoreData;
-(void)saveNewProductToCoreData;
-(void)saveEditedCompanyToCoreData;
-(void)saveEditedProductToCoreData;
-(void)removeManagedCompanyFromCoreData:(NSInteger )index;

//PROPERTY FOR REMOVING COMPANY
@property (nonatomic)NSInteger selectedIndexForRemovalInCoreData;
//PROPERTIES FROM ADDING NEW COMPANY
@property (strong,nonatomic)NSString *theNewCompanyNameDAO;
@property (strong,nonatomic)NSURL *theNewCompanyURLDAO;
@property (strong, nonatomic)NSString *theNewCompanyStockSymbolDAO;
//PROPERTIES FOR NEW ADDING PRODUCT
@property (strong,nonatomic)NSString *theNewProductNameDAO;
@property (strong,nonatomic)NSURL *theNewProductURLDAO;
//PROPERTY FOR EDITTITING COMPANY
@property (strong,nonatomic)NSString *editedCompanyNameDAO;
@property (strong,nonatomic)NSURL *editedCompanyLogoURLDAO;
@property (strong,nonatomic)NSString *originalCompanyNameDAO;
@property (strong,nonatomic)NSURL *originalCompanyLogoURLDAO;
@property (nonatomic)BOOL editingCompanyNameDAO;
@property (nonatomic)BOOL editingCompanyLogoURLDAO;
//PROPERTY FOR EDITTING PRODUCT
@property (strong,nonatomic)NSString *editedProductNameDAO;
@property (strong,nonatomic)NSURL *editedProductURLDAO;
@property (strong,nonatomic)NSString *originalProductNameDAO;
@property (strong,nonatomic)NSURL *originalProductURLDAO;
@property (nonatomic)BOOL editingProductNameDAO;
@property (nonatomic)BOOL editingProductURLDAO;

@end

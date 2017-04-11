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
#import <CoreData/CoreData.h>
#import "ManagedCompany+CoreDataClass.h"
#import "ManagedProduct+CoreDataClass.h"
#import "ManagedCompany+CoreDataProperties.h"
#import "ManagedProduct+CoreDataProperties.h"
@interface DAO : NSObject <NSFetchRequestResult>

//SINGLETON
+ (id)sharedManager;
-(void)firstRun;
//COMPANY & MANAGED COMAPNY ARRAYS
@property (strong,nonatomic)NSMutableArray <Company *> *companyListDAO;
@property (strong,nonatomic)NSMutableArray<ManagedCompany *> *managedCompanyListDAO;
//CREATION METHODS
-(Company *)makeNewCompanyWithName:(NSString *)name withLogoURL:(NSURL *)logoURL andStockSymbol:(NSString *)ticker;
-(Product *)makeNewProductWithName:(NSString *)name andURL:(NSURL *)url;
//ADD COMPANY METHOD
-(void)addCompanyToList:(Company *)company;
//REMOVE COMPANY METHOD
-(void)removeCompanyFromList;
//SAVE CONTEXT
-(void)saveContext;
//GET STOCK QUOTE
-(void)getAPIFinancialData;
@property (strong,nonatomic)NSArray *fetchedFinDataArrayDAO;
//CORE DATA STACK
@property (strong,nonatomic) NSManagedObjectContext *managedObjectContext;
//METHODS FOR SAVING TO CORE DATA
-(void)initializeCoreData;
-(void)saveManagedObject;
-(void)saveNewCompanyToCoreData;
-(void)saveNewProductToCoreData;
-(void)saveEditedCompanyToCoreData;
-(void)saveEditedProductToCoreData;
-(void)removeManagedCompanyFromCoreData:(ManagedCompany *)managedCompany;
-(void)removeManagedProductFromCoreData:(ManagedProduct *)mP fromManagedCompany:(ManagedCompany *)mC;

//PROPERTY FOR REMOVING COMPANY
//@property (nonatomic)NSInteger selectedIndexForRemovalInCoreData;
@property (strong,nonatomic)Company *currentCompanyDAO;
//PROPERTIES FROM ADDING NEW COMPANY
@property (strong,nonatomic)Company *theNewCompanyDAO;
//PROPERTIES FOR NEW ADDING PRODUCT
@property(strong,nonatomic)Product *theNewProductDAO;
//PROPERTY FOR EDITTITING COMPANY
@property (strong,nonatomic)ManagedCompany *currentManagedCompanyDAO;
@property (strong,nonatomic)Company *companyBeingEditedDAO;
@property (nonatomic)BOOL editingCompanyNameDAO;
@property (nonatomic)BOOL editingCompanyLogoURLDAO;
//PROPERTY FOR EDITTING PRODUCT
@property(strong,nonatomic)ManagedProduct *currentManagedProductDAO;
@property(strong,nonatomic)Product *productBeingEditedDAO;
@property (nonatomic)BOOL editingProductNameDAO;
@property (nonatomic)BOOL editingProductURLDAO;

@end

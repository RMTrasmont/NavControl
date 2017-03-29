//
//  CompanyDAO.m
//  NavCtrl
//
//  Created by Rafael M. Trasmontero on 2/13/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "DAO.h"

@implementation DAO

//SINGLETON
//A singleton is a special kind of class where only one instance of the class exists for the current process. In the case of an iPhone app, the one instance is shared across the entire app.
// DAO file is Turned into a Singleton.
//************************************************************************************
+ (id)sharedManager {
    static DAO *sharedMyManager = nil;
    static dispatch_once_t onceToken; 
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (instancetype)init  //<--- ***** override init for DAO class when called to initilize a _compapanylist array AND to call [self firstRun]
{
    self = [super init];
    if (self) {
        self.companyListDAO = [[NSMutableArray alloc]init];
        [self initializeCoreData];
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"DidFirstRun"]){
            [self loadFetchedFromCoreData];
            NSLog(@"LOADING FROM CORE DATA");
        } else {
            [self firstRun];
            NSLog(@"FIRST RUN");
        }
    }
    return self;
}

//**************************************************************************************
//CREATED ALL COMPANIES IN ONE METHOD // OOP STAGE 2
#pragma mark - firstRun

-(void)firstRun{
    //NOTE CREATE CUSTOM INIT FOR EASIER USE IN FUTURE
    
    //TEST
    NSLog(@"DAO TEST RUN");
    
    //APPLE *****************************************************************************
    //CREATE PRODUCTS
    Product *iPad = [[Product alloc]init];
    iPad.productName = @"iPad";
    iPad.productCompany = @"Apple";
    iPad.productURL = [NSURL URLWithString: @"http://www.apple.com/ipad/"];
    
    Product *iPod = [[Product alloc]init];
    iPod.productName = @"iPod Touch";
    iPod.productCompany = @"Apple";
    iPod.productURL = [NSURL URLWithString:@"http://www.apple.com/ipod-touch/"];
    
    Product *iphone = [[Product alloc]init];
    iphone.productName = @"iPhone";
    iphone.productCompany = @"Apple";
    iphone.productURL = [NSURL URLWithString:@"http://www.apple.com/iphone/"];
    
    //CREATE ARRAY OF PRODUCTS (TO PUT INTO COMPANY'S PRODUCTS ARRAY )
    //NSMutableArray *appleProducts = [NSMutableArray arrayWithObjects:iPad,iPod,iphone, nil];
    
    
    //CREATE COMPANY
    Company *apple = [[Company alloc]init];
    apple.companyName = @"Apple";
    apple.companyImage = [UIImage imageNamed:@"appleLogo"];
    //apple.companyProductList = appleProducts;
    apple.companyLogoURL = [NSURL URLWithString:@"https://cdn3.iconfinder.com/data/icons/picons-social/57/56-apple-48.png"];
    apple.companyProductList = [NSMutableArray arrayWithObjects:iPad,iPod,iphone, nil];
    apple.companyStockSymbol = @"AAPL";
    
    //ADD COMPANY TO DAO ARRAY OF COMPANIES
    [self.companyListDAO addObject:apple];
    
    
    //SAMSUNG ****************************************************************************

    //CREATE PRODUCTS
    Product *galaxyS4 = [[Product alloc]init];
    galaxyS4.productName = @"Galaxy S4";
    galaxyS4.productCompany = @"Samsung";
    galaxyS4.productURL = [NSURL URLWithString:@"http://www.samsung.com/us/mobile/phones/all-phones/s/galaxy_s4/_/n-10+11+hv1rp+trouu"];
    
    Product *galaxyNote = [[Product alloc]init];
    galaxyNote.productName = @"Galaxy Note";
    galaxyNote.productCompany = @"Samsung";
    galaxyNote.productURL = [NSURL URLWithString:@"http://www.samsung.com/us/mobile/phones/all-phones/s/galaxy_note5/_/n-10+11+hv1rp+troum"];
    
    Product *galaxyTab = [[Product alloc]init];
    galaxyTab.productName = @"Galaxy Tab";
    galaxyTab.productCompany = @"Samsung";
    galaxyTab.productURL = [NSURL URLWithString:@"http://www.samsung.com/us/search/searchMain?Dy=1&Nty=1&Ntt=galaxy+tabpro+s"];
    
    //CREATE ARRAY OF PRODUCTS
    //NSMutableArray *samsungProducts = [NSMutableArray arrayWithObjects:galaxyS4,galaxyNote,galaxyTab, nil];
    
    //CREATE COMPANY
    Company *samsung = [[Company alloc]init];
    samsung.companyName = @"Samsung";
    samsung.companyImage = [UIImage imageNamed:@"samsungLogo"];
    //samsung.companyProductList = samsungProducts;
    samsung.companyLogoURL = [NSURL URLWithString:@"https://cdn2.iconfinder.com/data/icons/well-known-1/1024/Android-48.png"];
    samsung.companyProductList = [NSMutableArray arrayWithObjects:galaxyS4,galaxyNote,galaxyTab, nil];
    samsung.companyStockSymbol = @"SSU.DE"; //<--- German Stock Index
    
    //ADD COMPANY TO DAO ARRAY OF COMAPANIES
    [self.companyListDAO addObject:samsung];
    
    //GOOGLE **************************************************************************
    
    //CREATE PRODUCTS
    
    Product *pixel = [[Product alloc]init];
    pixel.productName = @"Pixel";
    pixel.productCompany = @"Google";
    pixel.productURL = [NSURL URLWithString:@"https://store.google.com/search?q=pixel"];
    
    Product *pixelXL = [[Product alloc]init];
    pixelXL.productName = @"Pixel XL";
    pixelXL.productCompany = @"Google";
    pixelXL.productURL = [NSURL URLWithString:@"https://store.google.com/search?q=pixel%20xl"];
    
    Product *pixelC = [[Product alloc]init];
    pixelC.productName = @"Pixel C";
    pixelC.productCompany = @"Google";
    pixelC.productURL = [NSURL URLWithString:@"https://store.google.com/search?q=pixel%20c"];
    
    //CREATE AN ARRAY OF PRODUCTS
    //NSMutableArray *googleProducts = [NSMutableArray arrayWithObjects:pixel,pixelXL,pixelC, nil];
    
    //CREATE COMPANY
    Company *google = [[Company alloc]init];
    google.companyName = @"Google";
    google.companyImage = [UIImage imageNamed:@"googleLogo"];
    //google.companyProductList = googleProducts;
    google.companyLogoURL = [NSURL URLWithString:@"https://cdn4.iconfinder.com/data/icons/picons-social/57/40-google-plus-3-48.png"];
    google.companyProductList = [NSMutableArray arrayWithObjects:pixel,pixelXL,pixelC, nil];
    google.companyStockSymbol = @"GOOG";
    
    //ADD COMPANY TO DAO ARRAY OF COMPANIES
    [self.companyListDAO addObject:google];
    
    
    //LG *********************************************************************************
    
    //CREATE PRODUCTS
    
    Product *v10 = [[Product alloc]init];
    v10.productName = @"V10";
    v10.productCompany = @"LG";
    v10.productURL = [NSURL URLWithString:@"http://www.lg.com/us/mobile-phones/v10"];
    
    Product *v20 = [[Product alloc]init];
    v20.productName = @"V20";
    v20.productCompany = @"LG";
    v20.productURL = [NSURL URLWithString:@"http://www.lg.com/us/mobile-phones/v20"];
    
    Product *g5 = [[Product alloc]init];
    g5.productName = @"G5";
    g5.productCompany = @"LG";
    g5.productURL = [NSURL URLWithString:@"http://www.lg.com/us/mobile-phones/g5#G5Modularity"];
    
    //CREATE ARRAY OF PRODUCTS
    
    //NSMutableArray *lgProducts = [NSMutableArray arrayWithObjects:v10,v20,g5, nil];
    
    //CREATE COMPANY
    
    Company *lg = [[Company alloc]init];
    lg.companyName = @"LG";
    lg.companyImage = [UIImage imageNamed:@"lgLogo"];
    //lg.companyProductList = lgProducts;
    lg.companyLogoURL = [NSURL URLWithString:@"https://cdn4.iconfinder.com/data/icons/flat-brand-logo-2/512/lg-48.png"];
    lg.companyProductList = [NSMutableArray arrayWithObjects:v10,v20,g5, nil];
    lg.companyStockSymbol = @"LGLG.F"; // <--- German Stock Index
    
    //ADD COMPANY TO DAO ARRAY OF COMPANIES
    [self.companyListDAO addObject:lg];
    
    
    //CORE DATA ***************************************************************************
    //WHEN APP FIRST RUNS SAVE PROPERTIES TO CORE DATA
    //THE SECOND TIME IT RUNS IT WILL "FETCH" FROM CORE DATA
    
    for (Company *company in self.companyListDAO) {
        
        //CREATE A MANAGED COMPANY
        ManagedCompany *mC = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedCompany" inManagedObjectContext:self.managedObjectContext];
        
        //ASSIGN ATTRIBUTES TO MANAGED COMPANY
        mC.mCName = company.companyName;
        mC.mCLogoURL = [NSString stringWithFormat:@"%@", company.companyLogoURL];
        mC.mCStockSymbol = company.companyStockSymbol;
        mC.mCFinancialDataString = company.financialDataString;
        [self.managedCompanyListDAO addObject:mC];
        mC.products = [[NSMutableSet alloc]init];
        
        for (Product *product in company.companyProductList) {
            
            //CREATE A MANANGED PRODUCT
            ManagedProduct *mP = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:self.managedObjectContext];
            
            //ASSIGN ATTRIBUTES TO MANAGED PRODUCT
            mP.mPProductName = product.productName;
            mP.mPProducURL = [NSString stringWithFormat:@"%@",product.productURL];
           // [mC.products setByAddingObject:mP];
            [mC addProductsObject:mP];  //*****<------use when adding product****
            
            [self saveManagedObject];
        }
        
        
        [self saveManagedObject];
        [self saveContext];
        
        
    }
    
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"DidFirstRun"];
}






//*****************************ADD COMPANY TO DAO ARRAY LIST************************

-(void)addCompanyToList:(Company *)company{
    [self.companyListDAO addObject:company];
}

//*****************************REMOVE COMPANY TO DAO ARRAY LIST************************

-(void)removeCompanyFromList{
    [self.companyListDAO removeObject:self.companyListDAO[self.indexOfLastCompanyTouched]];
}


//***************************CREATE NEW PRODUCT METHOD**********************************

-(Product *)makeNewProductWithName:(NSString *)name andURL:(NSURL *)url{
    Product *newProduct = [[Product alloc]init];
    if(self = [super init]){
        newProduct.productName = name;
        newProduct.productURL = url;
    }
    return newProduct;
}


//************************CREATE NEW COMPANY METHOD***************************************

-(Company *)makeNewCompanyWithName:(NSString *)name withLogoURL:(NSURL *)logoURL andStockSymbol:(NSString *)ticker{
    Company *newCompany = [[Company alloc]init];
    if(self = [super init]){
        newCompany.companyName = name;
        newCompany.companyLogoURL = logoURL;
        newCompany.companyStockSymbol = ticker;
    }
    
    return newCompany;
}

#pragma mark API Data
//******************************METHOD TO GET STOCK QUOTE******************************

-(void)getAPIFinancialData{
    //LET COMPANY VIEWCONTROLLER KNOW TO RELOAD ITS DATA <---
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"GetFinancialDataFromDAO" object:nil];

    //************************************
    //GET ARRAY OF COMPANY SYMBOLS
    NSMutableArray *tickerArray = [[NSMutableArray alloc]init];
    
    //GET STOCK SYMBOLS AND ADD TO ARRAY
    for(Company *company in self.companyListDAO){
        [tickerArray addObject:company.companyStockSymbol];
    }
    
    //CONVERT ARRAY OF TICKERS INTO STRING
    NSString *tickerString = [tickerArray componentsJoinedByString:@","];
    
    //REPLACE COMMAS WITH PLUS SIGNS
    NSString *tickerForFinanceSearch =[tickerString stringByReplacingOccurrencesOfString:@"," withString:@"+"];
    
    //1*. ADD TICKER SYMBOLS TO API URL
    NSString *financeURLString = [NSString stringWithFormat:@"http://finance.yahoo.com/d/quotes.csv?s=%@&f=sap2",tickerForFinanceSearch];
    
    NSURL *financeURL = [NSURL URLWithString:financeURLString];
    
    
    //****************************************
    
    //2*.NOTE: NSURLSESSION WORKS ASYNCHRONUSLY, DOWNLOAD TASK GETS HIT BEFORE THE DATA INSIDE THE BLOCK. NOTE THE NUMBERS
    //TO USE THE INFO THAT IS RETRIEVED FROM INSIDE THE  NSURLSESSION BLOCK, YOU NEED TO EMPLOY "COMPLETION BLOCK PATTERN"
    //THIS METHOD SHOULD *NOT* RETURN ANYTHING, BUT RATHER PASS THE DATA BACK IN A "COMPLETION BLOCK"
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession]     // <--- use "Delegate based" or "Block based" style
                                        dataTaskWithURL:financeURL
                                        completionHandler:^(NSData *data,
                                                            NSURLResponse *response,
                                                            NSError *error){
                                              
                                        //4*: HANDLE RESPONSE  **ASYNCHRONIZATION STARTS HERE**
                                            //check for error
                                        if(!error){
                                                
                                        //GET THE DATA FROM THE URL DATA IS "CSV"
                                        NSData *financialData = [NSData dataWithContentsOfURL:financeURL];
                                        
                                        //TURN FINANCIAL DATA INTO STRING note: returns "Symbol,Price,Change"
                                        NSString *stringData = [[NSString alloc]initWithData:financialData encoding:NSUTF8StringEncoding];
                                        //FURTHER REMOVE THE QUOTATION MARKS ""
                                        NSString *stringDataWOQuotes = [stringData stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                                              
                                        //TURN INTO AN ARRAY (of symbol,prices,change)
                                        NSArray *dataArray = [stringDataWOQuotes componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\n"]];
                                         
                                        //variable to count data recieved
                                        int stockDataTransfered = 0;
                                        
                                        //IMPLEMENT do{}while() completion handler
                                        //ASSIGN EACH STRING TO A COMPANY FINANCIAL DATA STRING
                                        //IMPLEMENT NSNOTIFICATION
                                            do{
                                                    for (int i = 0; i < self.companyListDAO.count; i++) {
                                                if(dataArray[i] != nil){
                                                    self.companyListDAO[i].financialDataString = dataArray[i];
                                                    stockDataTransfered++;
                                                }else {
                                                    break;
                                                  }
                                                }
                                            }while (stockDataTransfered < (dataArray.count));
                                        
                                                //NSNOTIFICATION HERE IF NO ERROR, DO SOMETHING
                                                // "dispatch_async" takes you to main thread
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                [[NSNotificationCenter defaultCenter]postNotificationName:@"Recieved All Data" object:self];
                                            });
                                        } else {
                                        //if theres error
                                                //NSNOTIFICATION HERE IF THERES ERROR
                                            dispatch_async(dispatch_get_main_queue(),^{
                                                [[NSNotificationCenter defaultCenter]postNotificationName:@"Data Missing" object:self];
                                            });
                                        }
                                }];
    //3*.
    [dataTask resume];
}


//****************************INITIALIZE CORE DATA**********************************


- (void)initializeCoreData
{
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreDataModel" withExtension:@"momd"];
    
    //MANAGED OBJECT MODEL
    NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSAssert(mom != nil, @"Error initializing Managed Object Model");
    //PERSISTENCE COORDINATOR
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    //MANAGED OBJECT CONTEXT
    NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [moc setPersistentStoreCoordinator:psc];
    [self setManagedObjectContext:moc];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsURL = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [documentsURL URLByAppendingPathComponent:@"DataModel.sqlite"];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        NSError *error = nil;
        NSPersistentStoreCoordinator *psc = [[self managedObjectContext] persistentStoreCoordinator];
        NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
        NSAssert(store != nil, @"Error initializing PSC: %@\n%@", [error localizedDescription], [error userInfo]);
    
        //ERROR HANDLING
        if (!store) {
            NSLog(@"Error Fetching Store File from URL");
        }
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            // update the UI
        });
    
    
    });
}

//******************************SAVE TO CORE DATA***************************************
#pragma mark - Save Managed Object

-(void)saveManagedObject{
NSError *error = nil;
if ([[self managedObjectContext] save:&error] == NO) {
    NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
    }
}

//SAVE CONTEXT
#pragma mark - Save Context

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            
            NSLog(@"Saving didn't work so well.. Error: %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Fetch From Core Data
//******************************FETCH/LOAD FROM CORE DATA********************************
-(void) loadFetchedFromCoreData {
    
    //AFTER TRANSFER TO CORE DATA, NOW FETCH & LOAD FROM CORE DATA
    NSFetchRequest* fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ManagedCompany"];
    NSError *error = nil;
    
    //SET MANAGED COMPANY LIST AS THE THE OBJECTS FROM CORE DATA AS AN ARRAY PROPERTY
    self.managedCompanyListDAO = [[NSMutableArray alloc] initWithArray:[self.managedObjectContext executeFetchRequest:fetchRequest error:&error]];
    
   
    //ERROR HANDLING
    if (error != nil) {
        NSLog(@"Error %@",[error localizedDescription]);
    } else {
        for(ManagedCompany *mC in self.managedCompanyListDAO){
            
            Company *company = [[Company alloc]init];
            company.companyName = mC.mCName;
            company.companyStockSymbol = mC.mCStockSymbol;
            company.companyLogoURL = [NSURL URLWithString:mC.mCLogoURL];;
            company.financialDataString = mC.mCFinancialDataString;
            company.companyProductList = [[NSMutableArray alloc]init];
            [self.companyListDAO addObject:company];
           
            
            for(ManagedProduct *mP in mC.products){
                Product *product = [[Product alloc]init];
                product.productName = mP.mPProductName;
                product.productURL = [NSURL URLWithString: mP.mPProducURL];
                [company.companyProductList addObject:product];
                
                }
            
            }
        
        }
    [self saveManagedObject];
    [self saveContext];

    }


//***********************************************************************************
#pragma mark - Saving to Core Data

-(void)saveNewCompanyToCoreData{
    //ADD MANAGED OBJECT
    ManagedCompany *mC = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedCompany" inManagedObjectContext: self.managedObjectContext];
    //ASSIGN ATTRIBUTES
    mC.mCName = self.theNewCompanyNameDAO;
    mC.mCLogoURL = [NSString stringWithFormat:@"%@",self.theNewCompanyURLDAO];
    mC.mCStockSymbol = self.theNewCompanyStockSymbolDAO;
    [self saveManagedObject];
    
    //ADD MANAGED COMPANY TO MANAGED COMPANY ARRAY
    [self.managedCompanyListDAO addObject:mC];
    
    [self saveContext];
}

-(void)saveNewProductToCoreData{
    //ADD MANAGED PRODUCT
    ManagedProduct *mP = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:self.managedObjectContext];
    mP.mPProductName = self.theNewProductNameDAO;
    mP.mPProducURL = [NSString stringWithFormat:@"%@",self.theNewProductURLDAO];
    
    ManagedCompany *currentManagedCompany = [self.managedCompanyListDAO objectAtIndex:self.indexOfLastCompanyTouched];
    
    //CORE DATA RETURNS PRODUCT SET NOT ARRAY SO MANIPULATED
    NSMutableSet *productSet = [[NSMutableSet alloc]initWithSet:currentManagedCompany.products];
    [productSet addObject:mP];
    
    currentManagedCompany.products = productSet;
    
    //SAVE TO CORE DATA
    [self saveManagedObject];
    [self saveContext];
    
}
#pragma mark - WORKING EDIT COMPANY
-(void)saveEditedCompanyToCoreData{
  
    //EDIT MANAGED PRODUCT
    ManagedCompany *currentManagedCompany = [self.managedCompanyListDAO objectAtIndex:self.indexOfLastAccessoryButtonTouched];
    
    //ORIGINAL VALUES OF CURRENT MANAGED COMPANY
    NSString *originalMCName = currentManagedCompany.mCName;
    NSString *originalMCLogoURL = currentManagedCompany.mCLogoURL;
    
    //NEW VALUES OF CURRENT MANGED COMPANY
    NSString *newMCName = self.editedCompanyNameDAO;
    NSString *newLogoURL = [NSString stringWithFormat:@"%@",self.editedCompanyLogoURLDAO];
    
    //SET THE EDITED NEW MANAGED COMPANY NAME TO REPLACE  ORIGINAL ONE
    //IF THERE'S INPUT CHANGE IT, IF NO INPUT, DON'T CHANGE THE NAME
    if(self.editingCompanyNameDAO){
        currentManagedCompany.mCName = newMCName;
    } else {
        currentManagedCompany.mCName = originalMCName;
    }
    
    // SET THE EDITED NEW MANAGED COMPANY LOGO URL TO REPLACE ORIGINAL ONE
    // IF THERE'S INPUT CHANGE IT, IF NO INPUT, DON'T CHANGE URL
    if(self.editingCompanyLogoURLDAO){
        currentManagedCompany.mCLogoURL = newLogoURL;
    } else {
        currentManagedCompany.mCLogoURL = originalMCLogoURL;
    }
    
    //SAVE MANAGED OBJECT
    [self saveManagedObject];
    [self saveContext];
    
}

-(void)saveEditedProductToCoreData{
    
    ManagedCompany *currentCompany = [self.managedCompanyListDAO objectAtIndex:self.indexOfLastCompanyTouched];
    
    //GET THE SET
    NSMutableSet *currentProductSet = [[NSMutableSet alloc]initWithSet:currentCompany.products];
    
    //CONVERT SET INTO ARRAY
    NSMutableArray *productsArray = [NSMutableArray arrayWithArray:[currentProductSet allObjects]];
    
    //REMOVE THE PRODUCT FROM ARRAY AND CHANGE VALUES IF NEEDED
    ManagedProduct *currentProduct = [productsArray objectAtIndex:self.indexOfLastAccessoryButtonTouched];
    
    if(self.editingProductNameDAO){
        currentProduct.mPProductName = self.editedProductNameDAO;
    } else {
        currentProduct.mPProductName = self.originalProductNameDAO;
    }
    
    if(self.editingProductURLDAO){
        currentProduct.mPProducURL = [NSString stringWithFormat:@"%@",self.editedProductURLDAO];
    } else {
        currentProduct.mPProducURL = [NSString stringWithFormat:@"%@",self.originalProductURLDAO];
    }
    
    //UPDATE CONVERT ARRAY INTO SET
    NSMutableSet *editedSet = [NSMutableSet setWithArray:productsArray];
    
    //SET THE COMAPNY PRODUCTS AS THE EDITED SET
    currentCompany.products = [[NSMutableSet alloc]initWithSet:editedSet];
    
    //SAVE TO CORE DATA
    [self saveManagedObject];
    [self saveContext];

}

#pragma mark - remove Company

-(void)removeManagedCompanyFromCoreData:(NSInteger )index{
    
    //INDEX OF SELECTED CELL
    self.selectedIndexForRemovalInCoreData = index;
    
    //REMOVE OBJECT FORM MANAGED COMPANY LIST ARRAY
    ManagedCompany *companyToDelete = self.managedCompanyListDAO[index];
    [self.managedCompanyListDAO removeObject:companyToDelete];
    
    //DELETE CONTEXT
    [self.managedObjectContext deleteObject:companyToDelete];
    
    [self saveContext];
    
}

@end

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
//********************************************************
+ (id)sharedManager {
    static DAO *sharedMyManager = nil;
    static dispatch_once_t onceToken;        //<--- THREAD SAFETY, THIS SINGLETON CODE IS CALLED ONLY ONCE PER APP
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (instancetype)init  //<--- ***** override init for DAO class when called to initilize a _compapanylist array AND to call [self firstRun]
{
    self = [super init];
    if (self) {
        _companyListDAO = [[NSMutableArray alloc]init];
        [self firstRun];
    }
    return self;
}
//********************************************************
//CREATED ALL COMPANIES IN ONE METHOD // OOP STAGE 2


-(void)firstRun{
    //NOTE CREATE CUSTOM INIT FOR EASIER USE IN FUTURE
    
    //TEST
    NSLog(@"DAO TEST RUN");
    
    //APPLE ********************************************************
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
    
    //ADD COMPANY TO DAO ARRAY OF COMPANIES
    [self.companyListDAO addObject:apple];
    
    
    //SAMSUNG ********************************************************

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
    
    //ADD COMPANY TO DAO ARRAY OF COMAPANIES
    [self.companyListDAO addObject:samsung];
    
    //GOOGLE ********************************************************
    
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
    
    //ADD COMPANY TO DAO ARRAY OF COMPANIES
    [self.companyListDAO addObject:google];
    
    //LG ********************************************************
    
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
    //ADD COMPANY TO DAO ARRAY OF COMPANIES
    
    [self.companyListDAO addObject:lg];
    
}



//****************************************************************************************


//ADD COMPANY TO DAO ARRAY LIST
-(void)addCompanyToList:(Company *)company{
    [self.companyListDAO addObject:company];
}

//****************************************************************************************
//CREATE NEW PRODUCT METHOD
-(Product *)makeNewProductWithName:(NSString *)name andURL:(NSURL *)url{
    Product *newProduct = [[Product alloc]init];
    if(self = [super init]){
        newProduct.productName = name;
        newProduct.productURL = url;
    }
    return newProduct;
}


//****************************************************************************************
//CREATE NEW COMPANY METHOD
-(Company *)makeNewCompanyWithName:(NSString *)name andLogoURL:(NSURL *)logoURL{
    Company *newCompany = [[Company alloc]init];
    if(self = [super init]){
        newCompany.companyName = name;
        newCompany.companyLogoURL = logoURL;
    }
    
    return newCompany;
}


//*************************************IMAGES***************************************************
//METHODS TO GET IMAGE FROM URL
-(UIImage *) getImageFromURL:(NSString *)fileURL {
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    UIImage *result = [UIImage imageWithData:data];
    return result;
}

//METHOD TO SAVE THE IMAGE
-(void) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
    if ([[extension lowercaseString] isEqualToString:@"png"]) {
        [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
    } else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"]) {
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
    } else {
        NSLog(@"Image Save Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", extension);
    }
}

//METHOD TO LOAD THE IMAGE
-(UIImage *) loadImage:(NSString *)fileName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
    UIImage *result = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.%@", directoryPath, fileName, extension]];
    
    return result;
}

//EXAMPLE IMPLEMENTATION

//Definitions
//NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];

//GET IMAGE FROM URL
//UIImage * imageFromURL = [self getImageFromURL:@"http://www.yourdomain.com/yourImage.png"];

//SAVE IMAGE TO DIRECTORY
//[self saveImage:imageFromURL withFileName:@"My Image" ofType:@"png" inDirectory:documentsDirectoryPath];

//LOAD IMAGE FORM DIRECTORY
//UIImage * imageFromWeb = [self loadImage:@"My Image" ofType:@"png" inDirectory:documentsDirectoryPath];

//****************************************************************************************



@end

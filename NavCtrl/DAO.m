//
//  CompanyDAO.m
//  NavCtrl
//
//  Created by Rafael M. Trasmontero on 2/13/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "DAO.h"

@implementation DAO

+ (id)sharedManager {
    static DAO *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

-(void)firstRun{
    //NOTE CREATE CUSTOM INIT FOR EASIER USE IN FURTURE
    
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
    NSMutableArray *appleProducts = [NSMutableArray arrayWithObjects:iPad,iPod,iphone, nil];
    
    //CREATE COMPANY
    Company *apple = [[Company alloc]init];
    apple.companyName = @"Apple";
    apple.companyImage = [UIImage imageNamed:@"appleLogo"];
    apple.companyProductList = appleProducts;
    
    //ADD COMPANY TO DAO ARRAY OF COMPANIES
    [self.companyList addObject:apple];

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
    NSMutableArray *samsungProducts = [NSMutableArray arrayWithObjects:galaxyS4,galaxyNote,galaxyTab, nil];
    
    //CREATE COMPANY
    Company *samsung = [[Company alloc]init];
    samsung.companyName = @"Samsung";
    samsung.companyImage = [UIImage imageNamed:@"samsungLogo"];
    samsung.companyProductList = samsungProducts;
    
    //ADD COMPANY TO DAO ARRAY OF COMAPANIES
    [self.companyList addObject:samsung];
    
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
    NSMutableArray *googleProducts = [NSMutableArray arrayWithObjects:pixel,pixelXL,pixelC, nil];
    
    //CREATE COMPANY
    Company *google = [[Company alloc]init];
    google.companyName = @"Google";
    google.companyImage = [UIImage imageNamed:@"googleLogo"];
    google.companyProductList = googleProducts;
    
    //ADD COMPANY TO DAO ARRAY OF COMPANIES
    [self.companyList addObject:google];
    
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
    
    NSMutableArray *lgProducts = [NSMutableArray arrayWithObjects:v10,v20,g5, nil];
    
    //CREATE COMPANY
    
    Company *lg = [[Company alloc]init];
    lg.companyName = @"LG";
    lg.companyImage = [UIImage imageNamed:@"lgLogo"];
    lg.companyProductList = lgProducts;
    
    //ADD COMPANY TO DAO ARRAY OF COMPANIES
    
    [self.companyList addObject:lg];
}




















//-(Company *)initWithProducts{
//    if (self = [super init] ){
//        Company *company = [[Company alloc] init];
//        company.companyProductList = [NSMutableArray arrayWithObjects:iPad,iPod,iPhone, nil];
//    }
//}

//"CREAT ,READ, UPDATE ,DELETE"

//**************************CREATE***********************************
//-(NSMutableArray *)companyList{
//    NSMutableArray *companies = [[NSMutableArray alloc]init];
//    return companies;
//}
//
//- (NSMutableArray *)productsArray{
//    NSMutableArray *products = [[NSMutableArray alloc]init];
//    return products;
//}
//
//-(Company *)companyName: (NSString *)name withImage:(UIImage *)imageName andProducts:(NSMutableArray *)products{
//    Company *company = [[Company alloc]init];
//    company.companyName = name;
//    company.companyImage = imageName;
//    company.companyProductList = products;
//    return company;
//}
//
//-(Product *)productName:(NSString *)name fromCompany:(NSString *)company withURL:(NSURL *)url{
//    Product *product = [[Product alloc]init];
//    product.productName = name;
//    product.productCompany = company;
//    product.productURL = url;
//    return product;
//}

//**************************READ***********************************



//**************************UPDATE***********************************
//add products to Company array
//-(void)addProduct:(NSString *)productNamed toCompany:(NSString *)companyNamed{
//    //get the array
//    NSMutableArray *companies = [self companyArray];
//    //get the company
//    for (Company *company in companies){
//        if (company.companyName == companyNamed){
//            NSMutableArray *products = company.companyProductList;
//            
//        }
//    }
//}



//**************************DELETE***********************************
//delete products from company array
//delete company itself from company array



@end

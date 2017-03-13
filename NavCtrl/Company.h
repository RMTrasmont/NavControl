//
//  Company.h
//  NavCtrl
//
//  Created by Rafael M. Trasmontero on 2/13/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Company : NSObject 

@property (strong,nonatomic)NSString *companyName;
@property (strong,nonatomic)UIImage *companyImage;
@property (strong,nonatomic)NSMutableArray *companyProductList;
@property (strong,nonatomic)NSURL *companyLogoURL;
@property (strong,nonatomic)NSString *companyStockSymbol;   //< -- user provided
@property (strong,nonatomic)NSString *stockPrice;
@property (strong,nonatomic)NSString *stockChange;
@property (strong,nonatomic)NSString *financialDataString;
@property (strong,nonatomic)NSMutableArray *financialData; // [symbol,price,change]
@end

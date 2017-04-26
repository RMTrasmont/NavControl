//
//  Company.m
//  NavCtrl
//
//  Created by Rafael M. Trasmontero on 2/13/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "Company.h"

@implementation Company

-(void)dealloc{
    [_companyName release];
    [_companyImage release];
    [_companyProductList release];
    [_companyLogoURL release];
    [_fetchedLogoImage release];
    [_companyStockSymbol release];
    [_stockPrice release];
    [_stockChange release];
    [_financialDataString release];
    [_financialData release];
    [super dealloc];
}
@end

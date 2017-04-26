//
//  ProductClass.m
//  NavCtrl
//
//  Created by Rafael M. Trasmontero on 2/13/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "Product.h"

@implementation Product

-(void)dealloc{
    [_productCompany release];
    [_productName release];
    [_productURL release];
    [_productImageURL release];
    [_fetchedLogoImage release];
    [super dealloc];
}
@end

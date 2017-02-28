//
//  ProductClass.h
//  NavCtrl
//
//  Created by Rafael M. Trasmontero on 2/13/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (strong,nonatomic)NSString *productCompany;
@property (strong,nonatomic)NSString *productName;
@property (strong,nonatomic)NSURL *productURL;


@end

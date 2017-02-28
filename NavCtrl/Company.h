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

@end

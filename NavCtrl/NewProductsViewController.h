//
//  NewProductsViewController.h
//  NavCtrl
//
//  Created by Rafael M. Trasmontero on 2/21/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"
#import "CompanyViewController.h"
#import "ProductViewController.h"
@interface NewProductsViewController : UIViewController <UITextFieldDelegate>
@property (strong,nonatomic) NSString *productName;
@property (strong,nonatomic)NSURL *productURL;
@property (strong,nonatomic)NSURL *productImageURL;
@end

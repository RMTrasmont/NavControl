//
//  NewCompanyViewController.h
//  NavCtrl
//
//  Created by Rafael M. Trasmontero on 2/16/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"
#import "NewProductsViewController.h"
@interface NewCompanyViewController : UIViewController <UITextFieldDelegate>   // <----
@property (strong,nonatomic) NSString *theNewCompanyName;
@property (strong,nonatomic) NSURL *theNewCompanyURL;
@property (strong, nonatomic)NSString *theNewCompanyStockSymbol;
@end

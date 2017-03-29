//
//  ProductViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "ProductViewController.h"
#import "WebVCViewController.h"
#import "NewProductsViewController.h"
#import "DAO.h"
#import "Company.h"
#import "EditProductViewController.h"
@interface ProductViewController : UITableViewController

@property(strong,nonatomic) WKWebView *webView;

@end

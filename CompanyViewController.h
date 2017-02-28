//
//  CompanyViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyViewController.h"
#import "ProductViewController.h"
#import "NewCompanyViewController.h"
#import "DAO.h"
#import "EditCompanyViewController.h"
@class ProductViewController;

@interface CompanyViewController : UITableViewController

@property (nonatomic,retain) IBOutlet  ProductViewController *productViewController;

@end

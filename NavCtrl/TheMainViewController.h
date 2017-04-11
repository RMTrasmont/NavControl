//
//  TheMainViewController.h
//  NavCtrl
//
//  Created by Rafael M. Trasmontero on 4/5/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"
#import "DAO.h"
#import "MainViewController.h"
#import "CompanyViewController.h"
@interface TheMainViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

//@property (strong,nonatomic)Company *currentCompany;
@property (retain,nonatomic)MainViewController *companyProductsDetailView;
//SHOWN WHEN POPULATED
@property (retain, nonatomic) IBOutlet UITableView *companyTableView;
@property (retain, nonatomic) IBOutlet UIView *undoRedoHolder;
- (IBAction)undoButton:(UIButton *)sender;
- (IBAction)Redo:(UIButton *)sender;
//SHOWN WHEN EMPTY
@property (retain, nonatomic) IBOutlet UIView *emptyViewAndMessage;
@property (retain, nonatomic) IBOutlet UILabel *emptyMessage;
- (IBAction)emptyAddCompanyButton:(UIButton *)sender;
//FETCHED FINANCE DATA
@property(strong,nonatomic)NSMutableArray *fetchedFinancials;

@end

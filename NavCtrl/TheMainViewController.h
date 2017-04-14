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
#import "NavControllerAppDelegate.h"
#import "EmptyViewController.h"

@interface TheMainViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

//@property (strong,nonatomic)Company *currentCompany;
@property (retain,nonatomic)MainViewController *companyProductsDetailView;
//SHOWN WHEN POPULATED
@property (retain, nonatomic) IBOutlet UIStackView *populatedStackView;
@property (retain, nonatomic) IBOutlet UITableView *companyTableView;
@property (retain, nonatomic) IBOutlet UIView *populatedUndoRedoHolderView;
- (IBAction)populatedUndoButtonPressed:(UIButton *)sender;
- (IBAction)populatedRedoButtonPressed:(UIButton *)sender;
//METHOD TO PUSH TO EMPTY VIEW
-(void)pushToEmptyView;

//SHOWN WHEN EMPTY(MIGHT NOT USE)
@property (retain, nonatomic) IBOutlet UIView *emptyViewAndMessage;
@property (retain, nonatomic) IBOutlet UIImageView *gifBackGroundImageView;
@property (retain, nonatomic) IBOutlet UIImageView *emptyStateLogoImageView;
@property (retain, nonatomic) IBOutlet UILabel *noCompaniesLabel;
- (IBAction)addToCompaniesEmptyButton:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UIView *emptyUndoRedoHolderView;
- (IBAction)emptyUndoButtonPressed:(UIButton *)sender;
- (IBAction)emptyRedoButtonPressed:(UIButton *)sender;



//FETCHED FINANCE DATA
@property(strong,nonatomic)NSMutableArray *fetchedFinancials;

@end

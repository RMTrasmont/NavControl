//
//  MainViewController.h
//  NavControllerMainViewRefactor
//
//  Created by Rafael M. Trasmontero on 4/3/17.
//  Copyright © 2017 TurnToTech. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Company.h"
#import "TheMainViewController.h"
#import "WebVCViewController.h"
#import "EditProductViewController.h"
#import "UIImage+animatedGIF.h"

@interface MainViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property(copy) NSArray<NSSortDescriptor *> *sortDescriptors;
@property (retain, nonatomic) Company *companyToDisplay;
@property (retain, nonatomic) IBOutlet UIView *emptyProductsSubView;
@property (retain, nonatomic) IBOutlet UILabel *emptyProductsLabel;
- (IBAction)emptyProductsAddProductButton:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UIView *detailsHolderView;
@property (retain, nonatomic) IBOutlet UIImageView *logoImageView;
@property (retain, nonatomic) IBOutlet UILabel *stockPriceLabel;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIView *undoRedoHolderView;
@property (retain, nonatomic) NSSet *currentManagedProductSet;
- (IBAction)undoButton:(UIButton *)sender;
- (IBAction)redoButton:(UIButton *)sender;


///Users/Rafael/Xcode Practice & Project/Turn To Tech/Assignments/NavControllerMainViewRefactor/NavControllerMainViewRefactor/MainViewController.h
///Users/Rafael/Desktop/4.NavController/NavCtrl/NavCtrl/TheMainViewController.m



@end

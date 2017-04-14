//
//  EmptyViewController.h
//  NavCtrl
//
//  Created by Rafael M. Trasmontero on 4/2/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewCompanyViewController.h"
#import "UIImage+animatedGIF.h"
@interface EmptyViewController : UIViewController

@property (retain, nonatomic) IBOutlet UIImageView *emptyImageLogo;

@property (retain, nonatomic) IBOutlet UILabel *emptyMessageLabel;

- (IBAction)addCompanyButton:(UIButton *)sender;

@property (retain, nonatomic) IBOutlet UIImageView *animatedImageView;

@property (retain, nonatomic) IBOutlet UIView *undoRedoHolderView;

- (IBAction)undoButtonPressed:(UIButton *)sender;

- (IBAction)redoButtonPressed:(UIButton *)sender;



@end

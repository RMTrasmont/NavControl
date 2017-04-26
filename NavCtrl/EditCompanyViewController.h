//
//  EditCompanyViewController.h
//  NavCtrl
//
//  Created by Rafael M. Trasmontero on 2/28/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"
#import "Company.h"

@interface EditCompanyViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) Company *currentCompany;

@end

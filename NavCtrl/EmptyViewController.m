//
//  EmptyViewController.m
//  NavCtrl
//
//  Created by Rafael M. Trasmontero on 4/2/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "EmptyViewController.h"

@interface EmptyViewController ()


@end

@implementation EmptyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //ADD EMPTY STOCK IMAGE
    UIImageView *emptyImage =[[UIImageView alloc]
                              initWithFrame:CGRectMake((self.view.frame.size.width/2)-50,
                                                       (self.view.frame.size.height/2)- 200,
                                                       100,100)];
    emptyImage.image=[UIImage imageNamed:@"StockImage"];
    [self.view addSubview:emptyImage];
    
    //ADD LABEL
    UILabel *emptyLabel = [[UILabel alloc]initWithFrame:
                           CGRectMake((self.view.frame.size.width/2)-150,(self.view.frame.size.height/2)-120, 300,100)];
    [emptyLabel setText:@"You have not added any Companies"];
    [emptyLabel setTextAlignment:NSTextAlignmentCenter];
    [emptyLabel setTextColor:[UIColor grayColor]];
    [self.view addSubview:emptyLabel];
    
    //ADD BUTTON (need to add action to segue to add company)
    UIButton *emptyAddButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    emptyAddButton.frame = CGRectMake((self.view.frame.size.width/2)-65,
                                      (self.view.frame.size.height/2)-55,
                                      130, 50);
    [emptyAddButton setTitle:@"+ Add Company" forState:UIControlStateNormal];
    emptyAddButton.titleLabel.textColor = [UIColor redColor];
    [emptyAddButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [emptyAddButton addTarget:self action:@selector(segueToAddCompany) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:emptyAddButton];
    
}



-(void)segueToAddCompany{
    NewCompanyViewController *addNewCompanyVC = [[NewCompanyViewController alloc]init];
    [self.navigationController pushViewController:addNewCompanyVC animated:YES];
}



@end

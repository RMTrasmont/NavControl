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
    
    //1.LOAD ANIMATED IMAGE FROM GIF ASYNCHRONOUSLY
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
       UIImage *animatedFly =  [UIImage animatedImageWithAnimatedGIFURL:[NSURL URLWithString:@"http://rs1264.pbsrc.com/albums/jj486/barryfromtexas/Internet%20Fun/bug_crawls_on_screen.gif~c200"]];
        //**********************BACK TO MAIN THREAD*****************************
        //2.ALL IMAGES FETCHED,GO BACK TO THE MAIN QUEUE,AND ASSIGN IMAGES
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.animatedImageView setImage:animatedFly];
        });
    });

    
    

}



-(void)segueToAddCompany{
    NewCompanyViewController *addNewCompanyVC = [[NewCompanyViewController alloc]init];
    [self.navigationController pushViewController:addNewCompanyVC animated:YES];
}
- (IBAction)addCompanyButton:(UIButton *)sender {
    NewCompanyViewController *addNewCompanyVC = [[NewCompanyViewController alloc]init];
    [self.navigationController pushViewController:addNewCompanyVC animated:YES];
}

- (void)dealloc {
    [_emptyImageLogo release];
    [_emptyMessageLabel release];
    [_animatedImageView release];
    [_undoRedoHolderView release];
    [super dealloc];
}

- (IBAction)undoButtonPressed:(UIButton *)sender {
}

- (IBAction)redoButtonPressed:(UIButton *)sender {
}
@end

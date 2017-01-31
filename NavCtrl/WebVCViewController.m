//
//  WebVCViewController.m
//  NavCtrl
//
//  Created by Rafael M. Trasmontero on 1/30/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "WebVCViewController.h"
#import "ProductViewController.h"
@interface WebVCViewController ()

@end

@implementation WebVCViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString: self.webURL];
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    
    WKWebView * webVCView  = [[WKWebView alloc] initWithFrame: self.view.frame];
    [webVCView  loadRequest: request];
    webVCView.frame = CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y , self.view.frame.size.width, self.view.frame.size.height);
    
    [self.view addSubview: webVCView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

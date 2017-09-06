//
//  WebVCViewController.m
//  NavCtrl
//
//  Created by Rafael M. Trasmontero on 1/30/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "WebVCViewController.h"
@interface WebVCViewController ()

@end

@implementation WebVCViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebView * webVCView  = [[WKWebView alloc] initWithFrame: self.view.frame];
    [webVCView loadRequest:[NSURLRequest requestWithURL: self.webURL]];
    webVCView.frame = CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y , self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview: webVCView];
    
    [webVCView release];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [_webURL release];
    [super dealloc];
}
@end

//
//  XYAdDetailVC.m
//  XYIntroductionAndLaunch
//
//  Created by XY Lv on 17/2/8.
//  Copyright © 2017年 吕欣宇. All rights reserved.
//
//*********************************************************************************
//                                                             *                 *
//                                                     ******************       *
// *github:https://github.com/cryboyofyu              *   ************   *     *
// *博客:   http://blog.csdn.net/cry__boy                       *              *
// *技术支持QQ群:549943887(三月份之前免费)                       *******          *
// *别忘了github上给个star哦~                                     *            *
// *别忘了github上给个star哦~                                  *  *           *
// *别忘了github上给个star哦~                                     *          *
//                                                                       *
//***********************************************************************

#import "XYAdDetailVC.h"

@interface XYAdDetailVC ()

@end

@implementation XYAdDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self xyLoadNavView];
    [self xyLoadWebView];
}

- (void)xyLoadWebView{
    UIWebView * webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.xyWebUrl]]];
    [self.view addSubview:webView];
}

-(void)xyLoadNavView{
    
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    
    navView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:navView];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(5, 20, 60, 44)];
    
    [button setTitle:@"关闭" forState:UIControlStateNormal];
    
    [button setTintColor:[UIColor whiteColor]];
    
    button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    
    [button addTarget:self action:@selector(xyCloseAd) forControlEvents:UIControlEventTouchUpInside];
    
    [navView addSubview:button];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(65, 20, self.view.frame.size.width-130, 44)];
    
    if (self.xyWebTitle ==nil) {
        label.text = @"欣宇代言";
        
    }else{
        
        
        label.text = self.xyWebTitle;
    }
    
    label.textColor = [UIColor whiteColor];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    
    [navView addSubview:label];
    
    
}

- (void)xyCloseAd{
    self.view.window.rootViewController = self.xyRootVC;
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

//
//  ViewController.m
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
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    
    imageView.image = [UIImage imageNamed:@"XYHome"];
    
    [self.view addSubview:imageView];
    
    UILabel * showLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 150)];
    showLabel.numberOfLines = 0;
    showLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    showLabel.center = CGPointMake(self.view.bounds.size.width/2, 120);
    [imageView addSubview:showLabel];
    showLabel.text = @"欢迎来到欣宇的首页 \n *github:https://github.com/cryboyofyu \n 别忘了给个star哦~ ";
    showLabel.textAlignment = NSTextAlignmentCenter;
    showLabel.textColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
































//
//  AppDelegate.m
//  XYIntroductionAndLaunch
//
//  Created by XY Lv on 17/2/8.
//  Copyright © 2017年 吕欣宇. All rights reserved.

//*********************************************************************************
//                                                             *                 *
//                                                     ******************       *
//  github:https://github.com/cryboyofyu              *   ************   *     *
//  博客:   http://blog.csdn.net/cry__boy                       *              *
//  技术支持QQ群:549943887                      *******          *
//  别忘了github上给个star哦~                                     *            *
//  别忘了github上给个star哦~                                  *  *           *
//  别忘了github上给个star哦~                                     *          *
//                                                                       *
//***********************************************************************

#import "AppDelegate.h"
#import "ViewController.h"
#import "XYLaunchVC.h"
#import "XYAdDetailVC.h"
#import "XYIntroductionPage.h"
@interface AppDelegate ()<XYLaunchDelegate,XYIntroductionDelegate>
{
    XYIntroductionPage * _xyIntroductionPage;
    NSArray *            _xyCoverImgNameArr;
    NSArray *            _xyBgImgNameArr;
    NSArray *            _xyCoverTitleArr;
    NSURL   *            _xyVideoUrl;
    XYLaunchVC *         _xyLaunch;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    ViewController * xyVC = [[ViewController alloc]init];
    
#pragma mark-xy －启动页-------------------------------------------------
    
#pragma mark-xy -默认
//      _xyLaunch = [[XYLaunchVC alloc]initWithRootVC:xyVC withLaunchType:XYLaunchNormal];
//        _xyLaunch.xyNormalDuration = 2;
//    //本地
////      _xyLaunch.xyNormalImgName = @"LaunchImg";
//    //网络
//    _xyLaunch.xyIsCloseTimer = YES;//跟引导页(XYIntroductionPage)一起用的时候要打开/否则关闭
//        _xyLaunch.xyNormalImgUrl = @"http://img.zcool.cn/community/011c9655935c3c6ac7253264bee6ef.jpg";
    
#pragma mark-xy -广告
//        _xyLaunch = [[XYLaunchVC alloc]initWithRootVC:xyVC withLaunchType:XYLaunchAD];
//        _xyLaunch.xyAdDuration = 4;
//        _xyLaunch.xyDelegate = self;
//        _xyLaunch.xyAdActionUrl = @"https://github.com/cryboyofyu";
//        _xyLaunch.xyIsCloseTimer = YES;//跟引导页(XYIntroductionPage)一起用的时候要打开/否则关闭
        //网络
//        _xyLaunch.xyAdImgUrl = @"http://pic.qiantucdn.com/58pic/17/76/58/24K58PICsEp_1024.jpg";
       // 本地
        _xyLaunch.xyAdLocalImgName = @"XYAd.png";
    
#pragma mark-xy -新手向导
//        _xyLaunch = [[XYLaunchVC alloc]initWithRootVC:xyVC withLaunchType:XYLaunchGuide];
//        //本地
//        _xyLaunch.xyGuideImgNameArr = @[@"XYGuide1.jpeg",@"XYGuide2.jpeg"];
//        //网络
////        _xyLaunch.xyGuideImgUrlArr = @[@"http://pic107.nipic.com/file/20160821/6189380_063051282000_2.jpg",@"http://img.zcool.cn/community/010b6d55424e510000019ae915f419.jpg"];
    
#pragma mark-xy -gif动态图
//        _xyLaunch = [[XYLaunchVC alloc]initWithRootVC:xyVC withLaunchType:XYLaunchGif];
//    //本地
//        _xyLaunch.xyGifImgName = @"XY01";
//    //网络
////        _xyLaunch.xyGifImgUrl = @"http://image76.360doc.com/DownloadImg/2014/07/1510/43430258_28";
    
#pragma mark-xy -自动滚动
//        _xyLaunch = [[XYLaunchVC alloc]initWithRootVC:xyVC withLaunchType:XYLaunchAutoRoll];
//        //本地
//    //    xyLaunch.xyRollImgName = @"XYRoll4.jpeg";
//        //网络
//        _xyLaunch.xyRollImgUrl  = @"http://attachments.gfan.com/forum/attachments2/201305/06/161415293nymj1zby0j1uy.jpg";
//        _xyLaunch.xyFrontViewBgColor = [UIColor clearColor];
//     //自定义加浮层控件
//        UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 100,[UIScreen mainScreen].bounds.size.width , 60)];
//    
//        titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
//    
//        titleLable.textColor = [UIColor whiteColor];
//    
//        titleLable.textAlignment = NSTextAlignmentCenter;
//    
//        titleLable.text = @"别忘了给个star哦~";
//    
//        [_xyLaunch.xyRollFrontView addSubview:titleLable];

//        self.window.rootViewController = _xyLaunch;
    
#pragma mark-xy -引导页-----------------------------------------------------
    _xyCoverImgNameArr = @[@"Guide_pages_one.png", @"Guide_pages_two.png", @"Guide_pages_three.png"];
    _xyBgImgNameArr = @[@"Guide_pages_BGone.png", @"Guide_pages_BGtwo.png", @"Guide_pages_BGthree.png"];
    //可以更换样式,分别为:example1,example2,example3,example4,example5
    _xyIntroductionPage = [self example2];
    
    self.window.rootViewController = xyVC;//只用引导页的时候打开此项/跟启动页一起用的时候注释掉
    [self.window addSubview:_xyIntroductionPage.view];


    return YES;
}

//详情页代理
- (void)xyLaunchAdImgViewAction:(id)sender withObject:(id)object{
    XYLaunchVC * xyVC = object;
    
    XYAdDetailVC * detailVC = [[XYAdDetailVC alloc]init];
    detailVC.xyWebUrl = @"https://github.com/cryboyofyu";
    detailVC.xyRootVC = xyVC.xyRootVC;
    [xyVC presentViewController:detailVC animated:YES completion:nil];
}

//传统引导页
- (XYIntroductionPage *)example1{

    //可以添加gif动态图哦
    //    _xyBgImgNameArr = @[@"XY01.gif",@"XY03.gif",@"XY01.gif"];
    
    XYIntroductionPage * xyPage = [[XYIntroductionPage alloc]init];
    xyPage.xyCoverImgArr = _xyBgImgNameArr;//设置浮层滚动图片数组
    xyPage.xyDelegate = self;//进入按钮事件代理
    xyPage.xyAutoScrolling = NO;//是否自动滚动
    //可以自定义设置进入按钮样式
    [xyPage.xyEnterBtn setTitle:@"欣宇进入" forState:UIControlStateNormal];
    return xyPage;
}

//带浮层引导页
- (XYIntroductionPage *)example2{
    //可以添加gif动态图哦
    _xyBgImgNameArr = @[@"XY01.gif",@"XY03.gif",@"XY01.gif"];
    
    XYIntroductionPage * xyPage = [[XYIntroductionPage alloc]init];
    
    xyPage.xyBackgroundImgArr = _xyBgImgNameArr;
    xyPage.xyCoverImgArr = _xyCoverImgNameArr;
    
    xyPage.xyDelegate = self;
    
    return xyPage;
}

//浮层中自定义添加控件
- (XYIntroductionPage *)example3{
    
    XYIntroductionPage * xyPage = [[XYIntroductionPage alloc]init];
    xyPage.xyCoverImgArr = _xyCoverImgNameArr;
    xyPage.xyBackgroundImgArr = _xyBgImgNameArr;
    xyPage.xyDelegate = self;
    [xyPage.xyEnterBtn setTitle:@"欣宇进入" forState:UIControlStateNormal];
    
    //浮层中自定义添加空间
    [xyPage.xyPageArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView * imgView = obj;
        NSArray * textArr = @[@"希望大家能够喜欢~",@"git:https://github.com/cryboyofyu",@"进去给个star哦~"];
        UILabel * lable1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
        lable1.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,100);
        lable1.text = textArr[idx];
        lable1.textAlignment = NSTextAlignmentCenter;
        lable1.textColor = [UIColor blackColor];
        [imgView addSubview:lable1];
    }];
    return xyPage;
}

//视频
- (XYIntroductionPage *)example4{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"XYVideo" ofType:@"mp4"];
    NSLog(@"路径:%@",[NSBundle mainBundle]);
    
    _xyVideoUrl = [NSURL fileURLWithPath:filePath];
    XYIntroductionPage * xyPage = [[XYIntroductionPage alloc]init];
    xyPage.xyVideoUrl = _xyVideoUrl;
    xyPage.xyVolume = 0.7;
    xyPage.xyCoverImgArr = _xyCoverImgNameArr;
    xyPage.xyAutoScrolling = YES;
    xyPage.xyDelegate = self;
    return  xyPage;
}

//自定义浮层标题
- (XYIntroductionPage *)example5{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"XYVideo" ofType:@"mp4"];
    NSLog(@"路径:%@",[NSBundle mainBundle]);
    _xyCoverTitleArr = @[@"年轻的你", @"git:https://github.com/cryboyofyu",@"给个star吧~"];
    
    _xyVideoUrl = [NSURL fileURLWithPath:filePath];
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(3, self.window.frame.size.height - 60, self.window.frame.size.width - 6, 50)];
    loginButton.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    [loginButton setTitle:@"Login" forState:UIControlStateNormal];
    
    [loginButton addTarget:self action:@selector(xyLogin) forControlEvents:UIControlEventTouchUpInside];
    

    
    XYIntroductionPage * xyPage = [[XYIntroductionPage alloc]init];
//    xyPage.xyPageControl.hidden = YES;
    xyPage.xyLabelAttributesDic = @{ NSFontAttributeName : [UIFont fontWithName:@"Arial-BoldMT" size:18.0],
                                     NSForegroundColorAttributeName : [UIColor whiteColor] };
    xyPage.xyVideoUrl = _xyVideoUrl;
    xyPage.xyCoverTitlesArr = _xyCoverTitleArr;
    xyPage.xyAutoScrolling = YES;
    xyPage.xyPageControlOffSet = CGPointMake(0, -100);
    xyPage.xyDelegate = self;

    [xyPage.view addSubview:loginButton];
    return  xyPage;
}

//进入按钮事件
- (void)xyIntroductionViewEnterTap:(id)sender{
    _xyIntroductionPage = nil;
    //[_xyLaunch xy_startFire];//和引导页(XYIntroductionPage)一起用的时候加上这句
}

//自定义登录按钮
- (void)xyLogin{
    [_xyIntroductionPage  xyStopTimer];
    _xyIntroductionPage = nil;
}


@end




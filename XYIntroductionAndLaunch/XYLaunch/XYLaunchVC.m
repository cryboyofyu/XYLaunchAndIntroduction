//
//  XYLaunchVC.m
//  XYLaunchPage
//
//  Created by XY Lv on 17/2/7.
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


#import "XYLaunchVC.h"
#import "UIImageView+WebCache.h"
#import "UIImage+XYGif.h"
#define XYScreenBounds [UIScreen mainScreen].bounds
@interface XYLaunchVC ()<UIScrollViewDelegate>
{
    int _xyRollX;
    bool _xyIsReverse;
}
@end

@implementation XYLaunchVC

- (instancetype)initWithRootVC:(UIViewController *)rootVC withLaunchType:(XYLaunchType)launchType{
    self = [super init];
    if(self){
        self.xyRootVC = rootVC;
        self.xyAdDuration = 5;
        self.xyLaunchType = launchType;
        self.xyIsSkip = YES;
        self.xyGifFrontView  = [[UIView alloc]initWithFrame:XYScreenBounds];
        self.xyRollFrontView = [[UIView alloc]initWithFrame:XYScreenBounds];
        if(_xyLaunchType == XYLaunchAD){
            self.xyAdImgView = [[UIImageView alloc]initWithFrame:XYScreenBounds];

        }

    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    switch (self.xyLaunchType) {
        case XYLaunchNormal:{
            [self xyLayoutNormalLaunch];
        }
            break;
        case XYLaunchGuide:{
            [self xyLayoutPageControl];
            [self xyLayoutEnterBtn];
            [self xyLayoutGuide];
        }
            break;
        case XYLaunchAD:{
            [self xyLayoutADImgView];
            [self xyLayoutTimerLabel];

        }
         break;
        case XYLaunchGif:{
            [self xyLayoutEnterBtn];
            [self xyLayoutGifImg];

        }
            break;
        case XYLaunchAutoRoll:{
            [self xyLayoutEnterBtn];
            [self xyLayoutAutoRollImgView];
           

        }
            break;
            
        default:
            break;
    }
}

- (void)xyLayoutEnterBtn{
    self.xyEnterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.xyEnterBtn.frame = CGRectMake(XYScreenBounds.size.width/2 - 60, XYScreenBounds.size.height - 120, 120, 40);
    self.xyEnterBtn.tintColor = [UIColor lightGrayColor];
    [self.xyEnterBtn setImage:[UIImage imageNamed:@"XYEnter"] forState:UIControlStateNormal];
    [self.xyEnterBtn addTarget:self action:@selector(xySkipTap) forControlEvents:UIControlEventTouchUpInside];

}

- (void)xyLayoutNormalLaunch{

    UIImageView * launchImgView = [[UIImageView alloc]initWithFrame:XYScreenBounds];
    [self.view addSubview:launchImgView];
    if(self.xyNormalImgName.length >0){
        [launchImgView setImage:[UIImage imageNamed:self.xyNormalImgName]];
        self.xyAdTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(xyReleaseAll) userInfo:nil repeats:NO];
        if(self.xyIsCloseTimer == YES){
            [self.xyAdTimer setFireDate:[NSDate distantFuture]];
        }


    }else if(self.xyNormalImgUrl.length >0){
        __weak typeof (self)selfWeak = self;
        
        [launchImgView sd_setImageWithURL:[NSURL URLWithString:self.xyNormalImgUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            selfWeak.xyAdTimer = [NSTimer scheduledTimerWithTimeInterval:self.xyNormalDuration target:self selector:@selector(xyReleaseAll) userInfo:nil repeats:NO];
            if(selfWeak.xyIsCloseTimer == YES){
                [selfWeak.xyAdTimer setFireDate:[NSDate distantFuture]];
            }

        }];
    }
}

- (void)xy_startFire{
    if(self.xyLaunchType == XYLaunchAD){
        self.xyAdTimer = [NSTimer scheduledTimerWithTimeInterval:1.00 target:self selector:@selector(xyTimerAction) userInfo:nil repeats:YES];

    }else if(self.xyLaunchType == XYLaunchNormal){
        
        [self performSelector:@selector(xyReleaseAll) withObject:nil afterDelay:self.xyNormalDuration];

    }
}

//广告
- (void)xyLayoutADImgView{
    UITapGestureRecognizer * xyAdTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(xyAdTap:)];
    [self.xyAdImgView addGestureRecognizer:xyAdTap];
    self.xyAdImgView.userInteractionEnabled = YES;
    [self.view addSubview:self.xyAdImgView];
}

- (void)xyLayoutTimerLabel{
    self.xyTimerLabel  = [[UILabel alloc]initWithFrame:CGRectMake(XYScreenBounds.size.width - 90, 20, 80, 30)];
    self.xyTimerLabel.backgroundColor = [UIColor colorWithRed:125/256.0 green:125/256.0  blue:125/256.0  alpha:0.5];
    self.xyTimerLabel.textColor = [UIColor whiteColor];
    self.xyTimerLabel.textAlignment = NSTextAlignmentCenter;
    self.xyTimerLabel.layer.masksToBounds = YES;
    self.xyTimerLabel.layer.cornerRadius = 5;
    self.xyTimerLabel.userInteractionEnabled = YES;
    if(self.xyIsSkip){
        self.xyTimerLabel.text = [NSString stringWithFormat:@"跳过 %ld",(long)self.xyAdDuration];
        
    }else{
        self.xyTimerLabel.text = [NSString stringWithFormat:@"剩余 %ld",(long)self.xyAdDuration];
    }
    [self.view addSubview:self.xyTimerLabel];
    
    if(self.xyIsSkip){
        self.xySkipLabelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(xySkipTap)];
        [self.xyTimerLabel addGestureRecognizer:self.xySkipLabelTap];
    }
    if(self.xyIsCloseTimer == YES){

    }else{
        self.xyAdTimer = [NSTimer scheduledTimerWithTimeInterval:1.00 target:self selector:@selector(xyTimerAction) userInfo:nil repeats:YES];

    }
    
}

- (void)setXyAdImgUrl:(NSString *)xyAdImgUrl{
    _xyAdImgUrl = xyAdImgUrl;
    __weak typeof (self)selfWeak = self;
    [self.xyAdImgView sd_setImageWithURL:[NSURL URLWithString:xyAdImgUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if(selfWeak.xyAdTimer){
            [selfWeak.xyAdTimer fire];
        }

    }];
}

- (void)setXyAdLocalImgName:(NSString *)xyAdLocalImgName{
    _xyAdLocalImgName = xyAdLocalImgName;
    __weak typeof (self)selfWeak = self;
    [self.xyAdImgView setImage:[UIImage imageNamed:xyAdLocalImgName]];
    if(selfWeak.xyAdTimer){
        [selfWeak.xyAdTimer fire];
    }
}

//guide
- (void)xyLayoutGuide{
    UIScrollView * imgScrollView = [[UIScrollView alloc]initWithFrame:XYScreenBounds];
    imgScrollView.delegate = self;
    imgScrollView.pagingEnabled = YES;
    imgScrollView.showsHorizontalScrollIndicator = NO;
    imgScrollView.showsVerticalScrollIndicator = NO;
    imgScrollView.bounces = NO;
    [self.view addSubview:imgScrollView];
    [self.view addSubview:self.xyPageControl];

    //加载本地
    if(self.xyGuideImgNameArr.count >0){
        self.xyPageControl.numberOfPages = self.xyGuideImgNameArr.count;

        imgScrollView.contentSize = CGSizeMake(XYScreenBounds.size.width * self.xyGuideImgNameArr.count, XYScreenBounds.size.height);
       
        
        for(int i=0;i<self.xyGuideImgNameArr.count;i++){
            UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(XYScreenBounds.size.width *i, 0, XYScreenBounds.size.width, XYScreenBounds.size.height)];
            imgView.image = [UIImage imageNamed:self.xyGuideImgNameArr[i]];
            imgView.userInteractionEnabled = YES;
            [imgScrollView addSubview:imgView];
            
            if(i==self.xyGuideImgNameArr.count - 1){
                [imgView addSubview:self.xyEnterBtn];
            }
        }
    }else if(self.xyGuideImgUrlArr.count >0){
        self.xyPageControl.numberOfPages = self.xyGuideImgUrlArr.count;

        imgScrollView.contentSize = CGSizeMake(XYScreenBounds.size.width * self.xyGuideImgUrlArr.count, XYScreenBounds.size.height);
        for(int i=0;i<self.xyGuideImgUrlArr.count;i++){
            UIImageView * xyimgView = [[UIImageView alloc]initWithFrame:CGRectMake(XYScreenBounds.size.width * i, 0, XYScreenBounds.size.width, XYScreenBounds.size.height)];
            [xyimgView sd_setImageWithURL:self.xyGuideImgUrlArr[i] placeholderImage:nil];
            [imgScrollView addSubview:xyimgView];
            xyimgView.userInteractionEnabled = YES;
            if(i== self.xyGuideImgUrlArr.count - 1){
                [xyimgView addSubview:self.xyEnterBtn];
            }
            
        }
       
    }
    
    
}

- (void)xyLayoutPageControl{
    self.xyPageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, XYScreenBounds.size.height - 40, XYScreenBounds.size.width, 40)];
    self.xyPageControl.currentPage = 0;
    self.xyPageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    self.xyPageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
}

//gif
- (void)xyLayoutGifImg{
    UIImageView * gifImgView = [[UIImageView alloc]initWithFrame:XYScreenBounds];
    if(self.xyGifImgName.length >0){
        gifImgView.image = [UIImage xy_setAnimatedGIFWithGifName:self.xyGifImgName];
    }else if(self.xyGifImgUrl.length >0){
        [gifImgView sd_setImageWithURL:[NSURL URLWithString:self.xyGifImgUrl]];
    }
    [self.view addSubview:gifImgView];
    
    if(self.xyFrontViewBgColor){
        self.xyGifFrontView.backgroundColor = self.xyFrontViewBgColor;

    }else{
        self.xyGifFrontView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9  blue:0.9  alpha:0.5];
 
    }
    if(self.xyIsHideEnterBtn != YES){
        [self.xyGifFrontView addSubview:self.xyEnterBtn];
        self.xyEnterBtn.tintColor = [UIColor blueColor];
    }
    [self.view addSubview:self.xyGifFrontView];
}

//自动滚动
- (void)xyLayoutAutoRollImgView{
    _xyRollX = 0;
    _xyIsReverse = NO;
    if(self.xyFrontViewBgColor){
        self.xyRollFrontView.backgroundColor = self.xyFrontViewBgColor;

    }else{
        self.xyRollFrontView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9  blue:0.9  alpha:0.3];
 
    }

    if(self.xyRollImgName.length >0){
        self.xyRollImg = [UIImage imageNamed:self.xyRollImgName];
        [self xyAddRollImgAndRollTimer];
    }else if(self.xyRollImgUrl.length >0){
        [self xyCreateDownLoadImgWithImgUrl:self.xyRollImgUrl];
    }
}

- (void)xyAddRollImgAndRollTimer{
   
        self.xyRollImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, XYScreenBounds.size.height * self.xyRollImg.size.width/self.xyRollImg.size.height, XYScreenBounds.size.height)];
        self.xyRollImgView.image = self.xyRollImg;
        self.xyRollTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(xyRollImgAction) userInfo:nil repeats:YES];
        [self.view addSubview:self.xyRollImgView];
        if(self.xyIsHideEnterBtn != YES){
            [self.xyRollFrontView addSubview:self.xyEnterBtn];
            self.xyEnterBtn.tintColor = [UIColor blueColor];
        }
        [self.view addSubview:self.xyRollFrontView];
        [self.xyRollTimer fire];
    
}

- (void)xyCreateDownLoadImgWithImgUrl:(NSString *)imgUrlStr{
    
    NSURL * imgUrl = [NSURL URLWithString:imgUrlStr];
    NSURLSession * session = [NSURLSession sharedSession];
    __weak typeof (self)selfWeak = self;
    
    //创建任务
    NSURLSessionDownloadTask * xyTask = [session downloadTaskWithURL:imgUrl completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSData * xyData = [NSData dataWithContentsOfURL:location];
        UIImage * xyImg = [UIImage imageWithData:xyData];
        dispatch_async(dispatch_get_main_queue(), ^{
            selfWeak.xyRollImg = xyImg;
            [selfWeak xyAddRollImgAndRollTimer];
        });
    }];
    
    [xyTask resume];
    
}

#pragma mark-xy--------------------事件------------------------------------------
- (void)xyTimerAction{
    
    self.xyAdDuration --;
    if(self.xyAdDuration <0){
        [self.xyAdTimer invalidate];
        self.view.window.rootViewController = self.xyRootVC;
    }
    if(self.xyIsSkip){
        self.xyTimerLabel.text = [NSString stringWithFormat:@"跳过 %ld",self.xyAdDuration];
       
    }else{
        self.xyTimerLabel.text = [NSString stringWithFormat:@"剩余 %ld",self.xyAdDuration];
    }
}

- (void)xySkipTap{
    [self xyReleaseAll];
    
}

- (void)xyReleaseAll{
    if(self.xyAdTimer !=nil){
        [self.xyAdTimer invalidate];
        self.xyAdTimer = nil;
    }
    
    if(self.xyRollTimer != nil){
        [self.xyRollTimer invalidate];
        self.xyRollTimer = nil;
    }
    
    [self xyBackMainVC];
}

- (void)xyBackMainVC{
    self.view.window.rootViewController = self.xyRootVC;

}

- (void)xyAdTap:(id)sender{
    
    if(self.xyDelegate && [self.xyDelegate respondsToSelector:@selector(xyLaunchAdImgViewAction: withObject:)]){
        [self.xyDelegate xyLaunchAdImgViewAction:sender withObject:self];
    }
    
}

- (void)xyRollImgAction{
    
    if(_xyRollX - 1 > (XYScreenBounds.size.width - XYScreenBounds.size.height * self.xyRollImg.size.width/self.xyRollImg.size.height)&&_xyIsReverse==NO){
        _xyRollX = _xyRollX -1;
    }else{
        _xyIsReverse = YES;
    }
    
    if(_xyRollX + 1 <0 && _xyIsReverse){
        _xyRollX = _xyRollX + 1;
    }else{
        _xyIsReverse = NO;
    }
    self.xyRollImgView.frame = CGRectMake(_xyRollX, 0,self.xyRollImg.size.width, XYScreenBounds.size.height);

    
}

#pragma mark-xy --------------------代理--------------------------------------------
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger  currentPage = scrollView.contentOffset.x/XYScreenBounds.size.width;
    self.xyPageControl.currentPage = currentPage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    
    if (self.xyAdTimer !=nil) {
        
        [self.xyAdTimer invalidate];
        self.xyAdTimer = nil;
    }
    
    if (self.xyRollTimer != nil) {
        [self.xyRollTimer invalidate];
        self.xyRollTimer = nil;
    }
    
    
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













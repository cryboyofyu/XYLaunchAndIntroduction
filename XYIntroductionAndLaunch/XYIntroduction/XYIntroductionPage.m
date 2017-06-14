//
//  XYIntroductionPage.m
//  XYIntroductionPage
//
//  Created by XY Lv on 17/1/20.
//  Copyright © 2017年 吕欣宇. All rights reserved.
//

//*********************************************************************************
//                                                             *                 *
//                                                     ******************       *
// *github:https://github.com/cryboyofyu              *   ************   *     *
// *博客:   http://blog.csdn.net/cry__boy                       *              *
// *技术支持QQ群:549943887                      *******          *
// *别忘了github上给个star哦~                                     *            *
// *别忘了github上给个star哦~                                  *  *           *
// *别忘了github上给个star哦~                                     *          *
//                                                                       *
//***********************************************************************

#import "XYIntroductionPage.h"

@interface XYIntroductionPage ()<UIScrollViewDelegate>
{
    NSArray       * _xyBgViewArr;
    NSInteger       _xyCenterPageIndex;
    AVPlayer      * _xyPlayer;
    NSTimer       * _xyTimer;
    AVPlayerLayer * _xyPlayerLayer;
}
@end

@implementation XYIntroductionPage

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_xyPlayer pause];
    _xyPlayer  = nil;
    [self xyStopTimer];
    self.view = nil;
}

- (NSArray *)xyGetPageArr{
    if([self xyGetPagesNum] <1){
        return  nil;
    }
    if(_xyPageArr){
        return _xyPageArr;
    }
    NSMutableArray * tmpArr = [[NSMutableArray alloc]init];
     if(_xyCoverImgArr){
        [_xyCoverImgArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [tmpArr addObject:[self xyGetCoverImgViewWithImgName:obj]];
        }];
     }else if(_xyCoverTitlesArr){
         [_xyCoverTitlesArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
             [tmpArr addObject:[self xyGetPageWithTitle:obj]];
         }];
     }
    _xyPageArr = tmpArr;
    return  _xyPageArr;
}

- (void)xyReloadCoverTitles{
    for(UILabel * label in _xyPageArr){
       
        CGFloat height = 30;
        NSString * text = [label.attributedText string];
        if([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending){
            CGSize size = [text sizeWithAttributes:_xyLabelAttributesDic];
            height = size.height;
        }
        label.attributedText = [[NSAttributedString alloc]initWithString:text attributes:_xyLabelAttributesDic];
    }
}

- (instancetype)init{
    if(self = [super init]){
        [self xyInitSelf];

    }
    return self;
}

- (void)xyInitSelf{
    self.xyAutoScrolling = NO;
    self.xyAutoLoopPlayVideo = YES;
    [self xyLayoutEnterBtn];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(xyApplicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self xyStopTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self xyAddPageScroll];
    [self xyStartTimer];

}

- (void)xyBringSubViewToFront{
    [self.view bringSubviewToFront:self.xyPageScrollView];
    [self.view bringSubviewToFront:_xyPageControl];
    [self.view bringSubviewToFront:self.xyEnterBtn];
}

- (void)xyAddVideo{
    if(!_xyVideoUrl){
        return;
    }
    AVPlayerItem * xyPlayerItem = [AVPlayerItem playerItemWithURL:_xyVideoUrl];
    _xyPlayer = [AVPlayer playerWithPlayerItem:xyPlayerItem];
    _xyPlayer.volume = self.xyVolume;
    
    _xyPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:_xyPlayer];
    _xyPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _xyPlayerLayer.frame = self.view.layer.bounds;
    [self.view.layer addSublayer:_xyPlayerLayer];
    
    [_xyPlayer play];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movidePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:_xyPlayer.currentItem];
    
    [self xyBringSubViewToFront];
}

- (void)setXyVolume:(float)xyVolume{
    _xyVolume = xyVolume;
    _xyPlayer.volume = xyVolume;

}

- (void)xyEnter:(id)object{
    [self xyStopTimer];
    
    if(self.xyDelegate && [self.xyDelegate respondsToSelector:@selector(xyIntroductionViewEnterTap:)]){
        [self.xyDelegate xyIntroductionViewEnterTap:object];
    }
    
}

- (void)xyAddBackgroundViews{
    CGRect frame = self.view.bounds;
    NSMutableArray * tmpArr = [NSMutableArray new];
    [[[_xyBackgroundImgArr reverseObjectEnumerator] allObjects] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString * suffix;
        if([obj componentsSeparatedByString:@"."]){
            suffix = [obj componentsSeparatedByString:@"."][1];
            
        }
        UIImageView * imgView = [[UIImageView alloc]init];
        if([suffix isEqualToString:@"gif"]){
            NSString * gifImgName = [obj componentsSeparatedByString:@"."][0];
            imgView.image = [UIImage xy_setAnimatedGIFWithGifName:gifImgName];
        }else {
            imgView.image = [UIImage imageNamed:obj];
            
        }
        
        imgView.frame = frame;
        imgView.tag = idx + 1;
        [tmpArr addObject:imgView];
        [self.view addSubview:imgView];
        
    }];
    _xyBgViewArr = [[tmpArr reverseObjectEnumerator] allObjects];
    [self.view bringSubviewToFront:self.xyPageScrollView];
    [self.view bringSubviewToFront:_xyPageControl];
}

- (void)setXyBackgroundImgArr:(NSArray *)xyBackgroundImgArr{
    _xyBackgroundImgArr = xyBackgroundImgArr;
    [self xyAddBackgroundViews];
    
}

- (void)setXyCoverImgArr:(NSArray *)xyCoverImgArr{
    _xyCoverImgArr = xyCoverImgArr;
    [self xyReloadPage];

}

- (void)setXyCoverTitlesArr:(NSArray *)xyCoverTitlesArr{
    _xyCoverTitlesArr = xyCoverTitlesArr;

    [self xyReloadPage];

}

- (void)setXyLabelAttributesDic:(NSDictionary *)xyLabelAttributesDic{
    _xyLabelAttributesDic = xyLabelAttributesDic;
    [self xyReloadCoverTitles];
}

- (void)setXyVideoUrl:(NSURL *)xyVideoUrl{
    _xyVideoUrl = xyVideoUrl;
    [self xyAddVideo];

}

- (void)xyAddPageScroll{
    self.xyPageScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.xyPageScrollView.delegate = self;
    self.xyPageScrollView.pagingEnabled = YES;
    self.xyPageScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.xyPageScrollView];
    _xyPageControl = [[UIPageControl alloc]initWithFrame:[self xyLayoutPageControlFrame]];
    _xyPageControl.pageIndicatorTintColor = [UIColor grayColor];
    [self.view addSubview:_xyPageControl];
    
    
}

- (void)xyLayoutEnterBtn{
    if(!self.xyEnterBtn){
        self.xyEnterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.xyEnterBtn setTitle:@"Enter" forState:UIControlStateNormal];
        self.xyEnterBtn.layer.borderWidth = 0.5;
        self.xyEnterBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        self.xyEnterBtn.hidden = NO;
        self.xyEnterBtn.frame = [self xyLayoutEnterBtnFrame];
    }
    [self.xyEnterBtn addTarget:self action:@selector(xyEnter:) forControlEvents:UIControlEventTouchUpInside];
    self.xyEnterBtn.alpha = 0;
}

- (CGRect)xyLayoutPageControlFrame{
    CGRect xyFrame = CGRectMake(0, self.view.bounds.size.height - 50, self.view.bounds.size.width, 30);
    return CGRectOffset(xyFrame,self.xyPageControlOffSet.x, self.xyPageControlOffSet.y);
}

- (CGRect)xyLayoutEnterBtnFrame{
    CGSize size = self.xyEnterBtn.bounds.size;
    if(CGSizeEqualToSize(size, CGSizeZero)){
        size = CGSizeMake(self.view.frame.size.width * 0.6, 40);
    }
    return CGRectMake(self.view.frame.size.width/2 -size.width/2,_xyPageControl.frame.origin.y - size.height/2, size.width, size.height);
}

- (void)xyStartTimer{
    if(_xyAutoScrolling){
        _xyTimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(xyOnTimer) userInfo:nil repeats:YES];
    }
}

- (void)xyOnTimer{
    CGRect frame = self.xyPageScrollView.frame;
    frame.origin.x = frame.size.width * (_xyPageControl.currentPage + 1);
    frame.origin.y = 0;
    if(frame.origin.x >= self.xyPageScrollView.contentSize.width){
        frame.origin.x = 0;
    }
    [self.xyPageScrollView scrollRectToVisible:frame animated:YES];
}

- (void)xyStopTimer{
    [_xyTimer invalidate];
    _xyTimer = nil;
} 

- (void)xyReloadPage{
    _xyPageControl.numberOfPages = [self xyGetPagesNum];
    _xyPageScrollView.contentSize = [self xyGetScrollContentSize];
    __block CGFloat x = 0;
    NSArray * xyPageArr = [self xyGetPageArr];
    [xyPageArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView * view = (UIView *)obj;
        view.frame = CGRectOffset(view.frame, x, 0);
        [self.xyPageScrollView addSubview:view];
        x += view.frame.size.width;
        if(idx == xyPageArr.count - 1){
            [view addSubview:self.xyEnterBtn];
        }
        
    }];
    
    if(_xyPageControl.numberOfPages == 1){
        _xyEnterBtn.alpha = 1;
        _xyPageControl.alpha = 0;
    }
    if(self.xyPageScrollView.contentSize.width == self.xyPageScrollView.frame.size.width){
        self.xyPageScrollView.contentSize = CGSizeMake(self.xyPageScrollView.contentSize.width + 1, self.xyPageScrollView.contentSize.height);
    }
    
}

- (void)setXyAutoScrolling:(BOOL)xyAutoScrolling{
    _xyAutoScrolling = xyAutoScrolling;
    if(!_xyTimer&&_xyAutoScrolling){
        [self xyStartTimer];
    }
}

- (NSInteger)xyGetPagesNum{
    if(_xyCoverImgArr){
        return _xyCoverImgArr.count;

    }else if(_xyCoverTitlesArr){
        return _xyCoverTitlesArr.count;

    }
    return 0;
}

- (NSInteger)xyGetCurrentPage{
    return self.xyPageScrollView.contentOffset.x/self.view.bounds.size.width;
}

- (CGSize)xyGetScrollContentSize{
    UIView * view = [[self xyGetPageArr] firstObject];
    return CGSizeMake(view.frame.size.width* _xyPageArr.count, view.frame.size.height);
}

- (void)xyApplicationWillEnterForeground:(id)sender{
    [_xyPlayer play];
}

- (void)xyPageControlChangePage:(UIScrollView *)pageScrollView{
    
    if([self xyIsLastPage:_xyPageControl]){
        if(!self.xyIsAutoEnterOn){
            self.xyPageScrollView.bounces = NO;
        }
        if(_xyPageControl.alpha == 1){
            [UIView animateWithDuration:1 animations:^{
                _xyEnterBtn.alpha = 1;
                _xyPageControl.alpha = 0;
            }];
        }
    }else{
        if(_xyPageControl.alpha == 0){
            [UIView animateWithDuration:1 animations:^{
                _xyEnterBtn.alpha = 0;
                _xyPageControl.alpha = 1;
            }];
        }
    }
}

- (BOOL)xyIsLastPage:(UIPageControl *)pageControl{
    return pageControl.numberOfPages == pageControl.currentPage + 1;
}

- (BOOL)xyIsGoOnNext:(UIPageControl *)pageControl{
    return pageControl.numberOfPages>pageControl.currentPage + 1;
}

- (UIView *)xyGetPageWithTitle:(NSString *)title{
    CGSize size = self.view.frame.size;
    CGRect rect;
    CGFloat height = 30;
    if([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending){
        CGSize size = [title sizeWithAttributes:_xyLabelAttributesDic];
        height = size.height;
    }
    rect = CGRectMake(0, size.height - height - 100, size.width, height);
    UILabel * label = [[UILabel alloc]initWithFrame:rect];
    label.textAlignment = NSTextAlignmentCenter;
    label.attributedText = [[NSAttributedString alloc]initWithString:title attributes:_xyLabelAttributesDic];
    return  label;
}

- (UIView *)xyGetCoverImgViewWithImgName:(NSString *)imgName{
    
    UIImageView * imgView = [[UIImageView alloc]init];
    if([imgName componentsSeparatedByString:@"."].count>1&&[[imgName componentsSeparatedByString:@"."][1] isEqualToString:@"gif"]){
        
        NSString * gifImgName = [imgName componentsSeparatedByString:@"."][0];
        imgView.image = [UIImage xy_setAnimatedGIFWithGifName:gifImgName];
               }else{
                   imgView.image = [UIImage imageNamed:imgName];
    }
    
    imgView.userInteractionEnabled = YES;
    CGSize size = self.view.bounds.size;
    
    imgView.frame = CGRectMake(0,0, size.width, size.height);
    return imgView;
}

- (void)xyApplicationWillEnterForground:(id)sender{
    [_xyPlayer play];
}

#pragma mark-xy ---------------------通知事件位置---------------------------------
- (void)movidePlayDidEnd:(NSNotification *)notification{
    if(_xyAutoLoopPlayVideo){
        AVPlayerItem * item = [notification object];
        [item seekToTime:kCMTimeZero];
        [_xyPlayer play];
    }else{
        [self xyEnter:nil];
    }
}

#pragma mark-xy -------------------代理位置-------------------------------------------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/self.view.frame.size.width;
    CGFloat xyAlpha =  1-(scrollView.contentOffset.x - index*self.view.bounds.size.width)/self.view.bounds.size.width;
    if([_xyBgViewArr count] >index){
        UIView * view = [_xyBgViewArr objectAtIndex:index];
        if(view){
            view.alpha = xyAlpha;
        }
    }
    
    [_xyPageControl setCurrentPage:[self xyGetCurrentPage]];
    [self xyPageControlChangePage:scrollView];
    if(scrollView.isTracking){
        [self xyStopTimer];
    }else{
          if(!_xyTimer){
              [self xyStartTimer];
          }
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if([scrollView.panGestureRecognizer translationInView:scrollView.superview].x<0){
        if(![self xyIsGoOnNext:_xyPageControl]&&self.xyIsAutoEnterOn){
            [self xyEnter:nil];
        }
    }
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































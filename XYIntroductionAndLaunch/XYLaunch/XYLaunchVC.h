//
//  XYLaunchVC.h
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

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    XYLaunchNormal,//默认启动图
    XYLaunchGuide,//向导启动图
    XYLaunchAD,//广告启动图
    XYLaunchGif,//gif启动图
    XYLaunchAutoRoll//自动滚动图片
} XYLaunchType;
//协议
@protocol XYLaunchDelegate <NSObject>

- (void)xyLaunchAdImgViewAction:(id)sender withObject:(id)object;

@end

@interface XYLaunchVC : UIViewController

@property (nonatomic,strong)UIViewController * xyRootVC;//根视图控制器
@property (nonatomic,assign)XYLaunchType       xyLaunchType;//启动图类型
@property (nonatomic,weak)id<XYLaunchDelegate> xyDelegate;
@property (nonatomic,strong)UIButton * xyEnterBtn;//进入按钮
@property (nonatomic,strong)UIPageControl * xyPageControl;//pageControl
@property (nonatomic,strong)UIColor       * xyFrontViewBgColor;//最上面浮层试图

//默认系统样式启动图
@property (nonatomic,strong)NSString * xyNormalImgName;//本地图片名称
@property (nonatomic,strong)NSString * xyNormalImgUrl;//网络
@property (nonatomic,assign)NSInteger  xyNormalDuration;//延长时间

//广告
@property (nonatomic,strong)NSTimer * xyAdTimer;//广告定时器
@property (nonatomic,strong)UILabel * xyTimerLabel;//倒数时间label
@property (nonatomic,assign)BOOL      xyIsCloseTimer;//是否关不启动定时器
@property (nonatomic,strong)UIImageView * xyAdImgView;//广告图
@property (nonatomic,strong)UITapGestureRecognizer * xySkipLabelTap;//跳过手势
@property (nonatomic,strong)NSString * xyAdImgUrl;//广告网络图片
@property (nonatomic,strong)NSString * xyAdLocalImgName;//广告本地图片
@property (nonatomic,strong)NSString * xyAdPlaceholderImgName;//默认图
@property (nonatomic,assign)NSInteger  xyAdDuration;//显示时间
@property (nonatomic,strong)NSString * xyAdActionUrl;//详情页weburl
@property (nonatomic,strong)NSString * xyAdTitle;//详情页广告标题
@property (nonatomic,assign)BOOL       xyIsSkip;//是否显示跳过按钮

//新手向导
@property (nonatomic,strong)NSArray * xyGuideImgNameArr;//本地图片数组
@property (nonatomic,strong)NSArray * xyGuideImgUrlArr;//网络图片url数组

//gif
@property (nonatomic,strong)NSString * xyGifImgName;//gif本地名称
@property (nonatomic,strong)NSString * xyGifImgUrl;//gif网络url
@property (nonatomic,strong)UIView   * xyGifFrontView;//浮层
@property (nonatomic,assign)BOOL       xyIsHideEnterBtn;//是否显示进入按钮

//自动滚动
@property (nonatomic,strong)NSString * xyRollImgName;//本地图片名称
@property (nonatomic,strong)NSString * xyRollImgUrl;//网络图片url
@property (nonatomic,strong)UIView   * xyRollFrontView;//浮层
@property (nonatomic,strong)UIImage  * xyRollImg;//滚动img
@property (nonatomic,strong)UIImageView * xyRollImgView;//滚动imgview
@property (nonatomic,strong)NSTimer  * xyRollTimer;//定时

//init
- (instancetype)initWithRootVC:(UIViewController *)rootVC withLaunchType:(XYLaunchType)launchType;

//重置开启定时器
- (void)xy_startFire;

@end































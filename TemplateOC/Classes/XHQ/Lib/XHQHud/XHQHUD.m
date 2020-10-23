//
//  HUD.m
//  Cafu
//
//  Created by 帝云科技 on 2018/6/29.
//  Copyright © 2018年 diyunkeji. All rights reserved.
//

#import "XHQHUD.h"
#import "MBProgressHUD.h"

#define kHUDBackgroundColor               [UIColor whiteColor]
#define kHUDBezelViewBackgroundColor   [UIColor blackColor]
#define kHUDContentColor                   [UIColor whiteColor]
#define kHUDTextAfterDelayTime           1.0f
#define kHUDImageBundleSuccessName   @"imageBundle.bundle/HUD_success"
#define kHUDImageBundleErrorName      @"imageBundle.bundle/HUD_error"

@interface XHQHUD ()

@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation XHQHUD

+ (instancetype)sharedHUD
{
    static XHQHUD *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XHQHUD alloc] init];
    });
    return instance;
}


+ (void)showText:(NSString *)aText
{
    [self showText:aText inView:nil];
}

+ (void)showSuccessText:(NSString *)aText
{
    NSString *imageName = kHUDImageBundleSuccessName;
    [self showText:aText imageName:imageName];
}

+ (void)showErrorText:(NSString *)aText
{
    NSString *imageName = kHUDImageBundleErrorName;
    [self showText:aText imageName:imageName];
}

+ (void)showText:(NSString *)aText imageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    [self showText:aText inView:nil image:image afterDelay:0 offset:CGPointZero];
}

+ (void)showText:(NSString *)aText inView:(UIView *)view
{
    [self showText:aText inView:view image:nil afterDelay:0 offset:CGPointZero];
}

+ (void)showText:(NSString *)aText inView:(UIView *)view image:(UIImage *)image afterDelay:(NSTimeInterval)delay offset:(CGPoint)offset
{
    //无文字不显示
    if (!aText || aText.length == 0) {
        return;
    }
    
    UIImageView *imageView = nil; MBProgressHUDMode mode;
    if (image) {
        mode = MBProgressHUDModeCustomView;
        imageView = [[UIImageView alloc]initWithImage:image];
    }
    else {
        mode = MBProgressHUDModeText;
    }
    
    [self showView:view text:aText opaque:NO offset:offset imageView:imageView mode:mode];
    
    //隐藏
    if (delay <= 0) {
        delay = kHUDTextAfterDelayTime;
    }
    
    [[XHQHUD sharedHUD].hud hideAnimated:YES afterDelay:delay];
    [XHQHUD sharedHUD].hud = nil;
}



+ (void)showView:(UIView *)view
{
    [self showView:view opaque:NO];
}

+ (void)showView:(UIView *)view opaque:(BOOL)opaque
{
    [self showView:view text:nil opaque:opaque];
}

+ (void)showView:(UIView *)view text:(NSString *)aText opaque:(BOOL)opaque
{
    [self showView:view text:aText opaque:opaque offset:CGPointZero];
}

+ (void)showView:(UIView *)view text:(NSString *)aText opaque:(BOOL)opaque offset:(CGPoint)offset
{
    [self showView:view text:aText opaque:opaque offset:offset imageView:nil mode:MBProgressHUDModeIndeterminate];
}


/**
 弹出框

 @param view 显示视图
 @param aText 文字
 @param opaque 是否显示不透明图层
 @param offset 偏移量
 @param imageView 自定义视图
 @param mode 显示类型
 */
+ (void)showView:(UIView *)view text:(NSString *)aText opaque:(BOOL)opaque offset:(CGPoint)offset imageView:(UIImageView *)imageView mode:(MBProgressHUDMode)mode
{
    //为设置显示view 则默认为最上层
    if (!view) {
        view = (UIView *)[UIApplication sharedApplication].delegate.window;
    }
    
    if (![XHQHUD sharedHUD].hud) {
        [XHQHUD sharedHUD].hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    MBProgressHUD *hud = [XHQHUD sharedHUD].hud;
    hud.offset = offset;
    hud.label.text = aText;
    hud.mode = mode;
    hud.customView = imageView;
    if (opaque) {
        hud.backgroundColor = kHUDBackgroundColor;
    }
    
    //自行配置一些设置
    hud.margin = 13; //边距
    hud.bezelView.backgroundColor = kHUDBezelViewBackgroundColor; //框颜色
    if (@available(iOS 13.0, *)) {
        hud.bezelView.color = kHUDBezelViewBackgroundColor;
    }
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.contentColor = kHUDContentColor; //字颜色
    hud.label.font = [UIFont systemFontOfSize:14]; //字体大小
    hud.animationType = MBProgressHUDAnimationZoomOut; //动画样式
    hud.removeFromSuperViewOnHide = YES; //跟随父视图一起消失
    hud.bezelView.transform = CGAffineTransformMakeScale(0.9, 0.9);
}

+ (void)progress:(float)progress text:(NSString *)text
{
    if (![XHQHUD sharedHUD].hud) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [XHQHUD sharedHUD].hud.label.text = text;
        [XHQHUD sharedHUD].hud.mode = MBProgressHUDModeAnnularDeterminate;
        [XHQHUD sharedHUD].hud.progress = progress;
    });
}

+ (void)hide
{
    if ([XHQHUD sharedHUD].hud) {
        [[XHQHUD sharedHUD].hud hideAnimated:YES];
        [XHQHUD sharedHUD].hud = nil;
    }
}

@end



//
//  HUD.h
//  Cafu
//
//  Created by 帝云科技 on 2018/6/29.
//  Copyright © 2018年 diyunkeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface XHQHUD : NSObject


#pragma mark - 文字提示

/**
 文本提示框
 
 @param aText 文字
 */
+ (void)showText:(NSString *)aText;

/**
 成功文本提示框
 
 @param aText 文字
 */
+ (void)showSuccessText:(NSString *)aText;

/**
 错误文本提示框
 
 @param aText 文字
 */
+ (void)showErrorText:(NSString *)aText;

/**
 文本提示框

 @param aText 文字
 @param imageName 图片名
 */
+ (void)showText:(NSString *)aText imageName:(NSString *)imageName;

/**
 文本提示框
 
 @param aText 文字
 @param view 显示视图 不传默认为最上层
 */
+ (void)showText:(NSString *)aText inView:(UIView *)view;

/**
 文本提示框

 @param aText 文字
 @param view 显示视图    默认为最上层
 @param image 显示图片 
 @param delay 隐藏时间  默认为 1s
 @param offset 偏移量    默认为视图中心
 */
+ (void)showText:(NSString *)aText inView:(UIView *)view image:(UIImage *)image afterDelay:(NSTimeInterval)delay offset:(CGPoint)offset;



#pragma mark - 加载框

+ (void)showView:(UIView *)view;

+ (void)showView:(UIView *)view opaque:(BOOL)opaque;

+ (void)showView:(UIView *)view text:(NSString *)aText opaque:(BOOL)opaque;

+ (void)showView:(UIView *)view text:(NSString *)aText opaque:(BOOL)opaque offset:(CGPoint)offset;

+ (void)progress:(float)progress text:(NSString *)text;

+ (void)hide;

@end


/** 文本提示框 */
static inline void XHQHUDText(NSString *text) {
    [XHQHUD showText:text];
}

/** 正确提示框 */
static inline void XHQHUDSuccessText(NSString *text) {
    [XHQHUD showSuccessText:text];
}

/** 错误提示框 */
static inline void XHQHUDErrorText(NSString *text) {
    [XHQHUD showErrorText:text];
}

/** 加载框 */
static inline void XHQHUDInView(UIView *view) {
    [XHQHUD showView:view];
}

/** 不透明背景加载框 */
static inline void XHQHUDInOpaqueView(UIView *view) {
    [XHQHUD showView:view opaque:YES];
}

/** 文字加载框 */
static inline void XHQHUDInTextView(UIView *view, NSString *text) {
    [XHQHUD showView:view text:text opaque:NO];
}

/** 隐藏提示框 */
static inline void XHQHUDHide() {
    [XHQHUD hide];
}


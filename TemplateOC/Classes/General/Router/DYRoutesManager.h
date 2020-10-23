//
//  DYRoutesManager.h
//  SmartPig
//
//  Created by 帝云科技 on 2019/7/5.
//  Copyright © 2019 帝云科技. All rights reserved.
//

/**
 路由跳转
 由于App里m模块太多，跳转模式太过于复杂。
 故通过路由方式进行跳转 且路由跳转目前仅用在不相干的功能跳转
 目前仅写了单纯的跳转传参，后续根据需求再继续增加
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DYRoutesManager : NSObject

/**
 初始化路由 AppDelegate调用
 */
+ (void)configureRoutes;

/**
 注册路由 AppDelegate调用
 */
+ (BOOL)routeURL:(NSURL *)url;

/**
 导航栏跳转

 @param path 跳转路径 eg: @"DYViewController"  or @"DYViewController?title=标题&key=123..."
 @return 是否成功
 */
+ (BOOL)routePushPath:(NSString *)path;

/**
 模态跳转
 
 @param path 跳转路径 eg: @"DYViewController"  or @"DYViewController?title=标题&key=123..."
 @return 是否成功
 */
+ (BOOL)routePresentPath:(NSString *)path;

@end

NS_ASSUME_NONNULL_END

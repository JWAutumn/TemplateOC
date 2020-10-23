//
//  DYRoutesManager.m
//  SmartPig
//
//  Created by 帝云科技 on 2019/7/5.
//  Copyright © 2019 帝云科技. All rights reserved.
//

#import "DYRoutesManager.h"
#import "JLRoutes.h"

#import "DYNavigationController.h"

#import <objc/message.h>

@implementation DYRoutesManager

+ (void)configureRoutes {
    [[DYRoutesManager sharedDYRoutesManager] configureRoutes];
}

+ (BOOL)routeURL:(NSURL *)url {
    return [JLRoutes routeURL:url];
}

+ (BOOL)routePushPath:(NSString *)path {
    return [JLRoutes routeURL:[NSURL URLWithRoutePushPath:path]];
}

+ (BOOL)routePresentPath:(NSString *)path {
    return [JLRoutes routeURL:[NSURL URLWithRoutePresentPath:path]];
}

XHQ_SHARED_M(DYRoutesManager);

- (void)configureRoutes {
    JLRoutes *routes = [JLRoutes routesForScheme:routesScheme()];
    
    //添加push路由
    [routes addRoute:@"/push/:controller" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        NSString *className = parameters[@"controller"];
        UIViewController *vc = [self viewControllerWithClassName:className parameters:parameters];
        if (!vc) {
            return NO;
        }
        UIViewController *controller = [UIViewController xhq_currentController];
        [controller.navigationController pushViewController:vc animated:YES];
        return YES;
    }];
    
    //添加present路由
    [routes addRoute:@"/present/:controller" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        NSString *className = parameters[@"controller"];
        UIViewController *vc = [self viewControllerWithClassName:className parameters:parameters];
        if (!vc) {
            return NO;
        }
        UIViewController *controller = [UIViewController xhq_currentController];
        DYNavigationController *navController = [[DYNavigationController alloc] initWithRootViewController:controller];
        [controller presentViewController:navController animated:YES completion:nil];
        return YES;
    }];
}

#pragma mark - 获取跳转控制器并使用KVC赋值
- (UIViewController *)viewControllerWithClassName:(NSString *)className parameters:(NSDictionary *)parameters {
    UIViewController *controller = [[NSClassFromString(className) alloc] init];
    NSString *title = [parameters objectForKey:@"title"];
    if (title) {
        controller.title = title;
    }
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList(controller.class, &count);
    for (int idx = 0; idx < count; idx ++) {
        objc_property_t proprety = properties[idx];
        NSString *key = [NSString stringWithUTF8String:property_getName(proprety)];
        NSString *value = parameters[key];
        if (value) {
            [controller setValue:value forKey:key];
        }
    }
    return controller;
}

@end

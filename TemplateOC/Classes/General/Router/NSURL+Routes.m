//
//  NSURL+Routes.m
//  SmartPig
//
//  Created by 帝云科技 on 2019/7/5.
//  Copyright © 2019 帝云科技. All rights reserved.
//

#import "NSURL+Routes.h"

@implementation NSURL (Routes)

+ (instancetype)URLWithRoutePushPath:(NSString *)routePath {
    NSString *string = [NSString stringWithFormat:@"%@://push/%@", routesScheme(), routePath];
    return [NSURL URLWithString:string];
}

+ (instancetype)URLWithRoutePresentPath:(NSString *)routePath {
    NSString *string = [NSString stringWithFormat:@"%@://present/%@", routesScheme(), routePath];
    return [NSURL URLWithString:string];
}

@end

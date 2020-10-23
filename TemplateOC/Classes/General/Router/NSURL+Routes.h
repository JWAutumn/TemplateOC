//
//  NSURL+Routes.h
//  SmartPig
//
//  Created by 帝云科技 on 2019/7/5.
//  Copyright © 2019 帝云科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (Routes)

+ (instancetype)URLWithRoutePushPath:(NSString *)routePath;

+ (instancetype)URLWithRoutePresentPath:(NSString *)routePath;

@end

NS_ASSUME_NONNULL_END

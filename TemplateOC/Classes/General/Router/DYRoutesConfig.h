//
//  DYRoutesConfig.h
//  SmartPig
//
//  Created by 帝云科技 on 2019/7/5.
//  Copyright © 2019 帝云科技. All rights reserved.
//

#ifndef DYRoutesConfig_h
#define DYRoutesConfig_h

#import "DYRoutesManager.h"
#import "NSURL+Routes.h"


static inline NSString *routesScheme() {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *scheme = infoDictionary[@"CFBundleIdentifier"];
    if ([scheme containsString:@"."]) {
        scheme = [[scheme componentsSeparatedByString:@"."] lastObject];
    }
    return scheme;
}


#endif /* DYRoutesConfig_h */

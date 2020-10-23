//
//  AppDelegate+Config.m
//  TemplateOC
//
//  Created by 帝云科技 on 2020/10/23.
//

#import "AppDelegate+Config.h"
#import <Bugly/Bugly.h>

static NSString *const kBuglyId = @"";

@implementation AppDelegate (Config)


- (void)config {
    
#if DEBUG
    [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"] load];
#endif
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [Bugly startWithAppId:kBuglyId];
    });
    
    [self rootController];
}


- (void)rootController {
    
}

@end

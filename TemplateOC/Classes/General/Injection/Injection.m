//
//  Injection.m
//  ControlPressure
//
//  Created by 帝云科技 on 2020/3/27.
//  Copyright © 2020 帝云科技. All rights reserved.
//

#import "Injection.h"

#if DEBUG

@implementation DYViewController (Injection)

- (void)injected {
    [self dy_initUI];
}

@end


@implementation DYView (Injection)

- (void)injected {
    [self dy_initUI];
}

@end


@implementation DYTableViewCell (Injection)

- (void)injected {
    [self dy_initUI];
}

@end


@implementation DYCollectionViewCell (Injection)

- (void)injected {
    [self dy_initUI];
}

@end


#endif

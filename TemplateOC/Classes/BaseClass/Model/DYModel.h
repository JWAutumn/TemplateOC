//
//  DYModel.h
//  ZhangqiuForum
//
//  Created by 帝云科技 on 2018/1/17.
//  Copyright © 2018年 diyunkeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYModel : NSObject<NSCoding>

@property (nonatomic, strong) NSString *ids;

+ (instancetype)model;

@end

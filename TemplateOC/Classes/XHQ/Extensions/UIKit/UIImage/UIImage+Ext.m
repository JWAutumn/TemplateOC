//
//  UIImage+Ext.m
//  FirePlatformCompany
//
//  Created by 帝云科技 on 2020/2/27.
//  Copyright © 2020 帝云科技. All rights reserved.
//

#import "UIImage+Ext.h"


@implementation UIImage (Ext)

+ (UIImage *)xhq_imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


@end

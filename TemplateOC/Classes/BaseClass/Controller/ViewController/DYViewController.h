//
//  DYViewController.h
//  ShanghaiCard
//
//  Created by 帝云科技 on 2018/10/31.
//  Copyright © 2018 帝云科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DYViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *dataArray;

/**
 HUD显示判断
 不同的页面要根据情况加载HUD 根据修改次状态来判断
 eg: 第一次进入要显示 之后刷新都不显示
 */
@property (nonatomic, assign, getter=isFirstLoadHUD) BOOL firstLoadHUD;

/** 初始化数据 */
- (void)dy_initData;

/** 初始化控件 */
- (void)dy_initUI;

/** 数据请求 */
- (void)dy_request;

/** viewwillappear调用 */
- (void)dy_reloadData;

@end

NS_ASSUME_NONNULL_END

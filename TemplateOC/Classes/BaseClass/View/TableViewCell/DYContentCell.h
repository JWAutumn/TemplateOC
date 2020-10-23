//
//  DYContentCell.h
//  ShanghaiCard
//
//  Created by 帝云科技 on 2018/11/7.
//  Copyright © 2018 帝云科技. All rights reserved.
//

//左右文字cell

#import "DYTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DYContentCellMode) {
    DYContentCellModeText = 0,
    DYContentCellModeImage,
};

@interface DYContentCellItem : DYTableViewCellItem

@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) UIColor *contentColor;
@property (nonatomic, strong) UIFont *contentFont;


/** used in DYContentCellModeImage */
@property (nonatomic, copy) NSString *imageUrlString;

@property (nonatomic, assign) DYContentCellMode mode;

/** 标识符 判断识别使用 */
@property (nonatomic, assign) NSUInteger type;

@end

@interface DYContentCell : DYTableViewCell

@end

NS_ASSUME_NONNULL_END

//
//  DYInputCell.h
//  ShanghaiCard
//
//  Created by 帝云科技 on 2018/11/5.
//  Copyright © 2018 帝云科技. All rights reserved.
//

//输入框cell

#import "DYTableViewCell.h"


typedef NS_ENUM(NSUInteger, DYInputMode) {
    DYInputModeDefalut = 0, /**<默认*/
    DYInputModeSelect, /**<选择项*/
    DYInputModeCode, /**<验证码*/
    DYInputModePhoto,  /**<图片识别*/
    DYInputModeSecure,  /**<安全输入*/
};

@interface DYInputCellItem : DYTableViewCellItem


/** 类型 */
@property (nonatomic, assign) DYInputMode mode;

/** 占位内容 */
@property (nonatomic, copy) NSString *placeholder;
/** 内容 */
@property (nonatomic, copy) NSString *text;
/** 键盘类型 */
@property (nonatomic, assign) UIKeyboardType keyboardType;

/** 右侧按钮图片 DYInputModeSelect、DYInputModePhoto模式下使用 */
@property (nonatomic, strong) UIImage *image;

/** 标题宽度 */
@property (nonatomic, assign) CGFloat titleWidth;


/** 最大字数限制 */
@property (nonatomic, assign) NSInteger maxInputNum;
/** 输入字符限制 */
@property (nonatomic, copy) NSString *importableChar;

/** 输入的是金额 */
@property (nonatomic, assign, getter=isAmountOfMoney) BOOL amountOfMoney;
/** 无法编辑 */
@property (nonatomic, assign, getter=isUnableToEdit) BOOL unableToEdit;
/** 开始倒计时 */
@property (nonatomic, assign, getter=isStartCountDown) BOOL startCountDown;
/** 重置倒计时 */
@property (nonatomic, assign, getter=isResetCountDown) BOOL resetCountDown;

@end


@interface DYInputCell : DYTableViewCell

@property (nonatomic, copy) dispatch_block_t codeBlock;
@property (nonatomic, copy) dispatch_block_t photoBlock;
@property (nonatomic, copy) dispatch_block_t selectBlock;
@property (nonatomic, copy) dispatch_block_t endEditBlock;

@end


//@interface NSMutableArray (DYInputCellItem)
//
//- (DYInputCellItem *)dy_itemForTitle:(NSString *)title;
//
//@end



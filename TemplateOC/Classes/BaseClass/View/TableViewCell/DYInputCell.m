//
//  DYInputCell.m
//  ShanghaiCard
//
//  Created by 帝云科技 on 2018/11/5.
//  Copyright © 2018 帝云科技. All rights reserved.
//

#import "DYInputCell.h"

@implementation DYInputCellItem

- (CGFloat)cellHeight {
    return 50.f;
}

@end


@interface DYInputCell ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *codeButton;
@property (nonatomic, strong) UIButton *imageButton;

@property (nonatomic, strong) DYInputCellItem *cellItem;

@property (nonatomic, assign) NSInteger time; /**<倒计时时间*/
@property (nonatomic, assign, getter=isBeingCountdown) BOOL beingCountdown; /**<倒计时中*/

@end

static NSString *const image_photo = @"icon_camera";
static NSString *const image_select = @"icon_select";
static NSString *const image_close = @"icon_eyesclose";
static NSString *const image_open = @"icon_eyesopen";

static const CGFloat titleWidth = 75.f;
static const NSInteger totalTime = 60;

@implementation DYInputCell

- (void)dy_initUI {
    [super dy_initUI];
    
    [self dy_noneSelectionStyle];
    
    self.time = totalTime;
    self.sideMargin = 0;
    [self addSubview:self.titleLabel];
    [self addSubview:self.codeButton];
    [self addSubview:self.imageButton];
    [self addSubview:self.textField];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat marge = DYCellSideMarge;
    CGFloat btnWidth = kIsIPhone5SE() ? 63 : 73;
    
    [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.leading.equalTo(marge);
        if (self.cellItem.titleWidth > 0) {
            make.width.equalTo(kIsIPhone5SE() ? kAdapt(self.cellItem.titleWidth) : self.cellItem.titleWidth);
        }else {
            make.width.equalTo(kIsIPhone5SE() ? kAdapt(titleWidth) : titleWidth);
        }
    }];
    [_codeButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.trailing.equalTo(-marge);
        make.size.equalTo(CGSizeMake(btnWidth, 24));
    }];
    [_imageButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.size.equalTo(CGSizeMake(40, 40));
        make.trailing.equalTo(-marge);
    }];
    [_textField makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_titleLabel.trailing).offset(marge);
        make.centerY.equalTo(0);
        make.height.equalTo(40);
        if (self.cellItem.mode == DYInputModeCode) {
            make.trailing.equalTo(_codeButton.leading).offset(-marge);
        }else if (self.cellItem.mode == DYInputModeDefalut||self.cellItem.mode == DYInputModeSecure) {
            make.trailing.equalTo(-marge);
        }else {
            make.trailing.equalTo(_imageButton.leading).offset(-marge);
        }
    }];
}

#pragma mark -
- (void)codeButtonClicked {
    !self.codeBlock ? : self.codeBlock();
    !self.responseBlock ? : self.responseBlock();
}

- (void)imageButtonClicked:(UIButton *)sender {
    if (self.cellItem.mode == DYInputModeSecure) {
        sender.selected = !sender.selected;
        _textField.secureTextEntry = !sender.selected;
    }else if (self.cellItem.mode == DYInputModeSelect) {
        !self.selectBlock ? : self.selectBlock();
        !self.responseBlock ? : self.responseBlock();
    }else if (self.cellItem.mode == DYInputModePhoto) {
        !self.photoBlock ? : self.photoBlock();
        !self.responseBlock ? : self.responseBlock();
    }
}

#pragma mark - 倒计时
/**
 开始倒计时
 */
- (void)startCountdown {
    if (self.cellItem.mode != DYInputModeCode) {
        return;
    }
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (self.time <= 1) {
            _beingCountdown = NO;
            dispatch_source_cancel(timer);
            _codeButton.enabled = YES;
            [_codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
            [_codeButton setTitleColor:[UIColor xhq_base] forState:UIControlStateNormal];
            _time = totalTime;
        }else {
            self.time -- ;
            _beingCountdown = YES;
            _codeButton.enabled = NO;
            NSString * str = [NSString stringWithFormat:@"剩余%ldS",_time];
            [_codeButton setTitle:str forState:UIControlStateNormal];
            [_codeButton setTitleColor:[UIColor xhq_content] forState:UIControlStateNormal];
        }
    });
    dispatch_resume(timer);
}

/**
 重置倒计时  (部分需求)
 */
- (void)resetCountdown {
    if (!self.isBeingCountdown) {
        return;
    }
    self.time = 0;
}

#pragma mark - UITextFeildDelegate & Target
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //金额
    if (self.cellItem.isAmountOfMoney && [textField.text containsString:@"."]) {
        if ([string isEqualToString:@"."]) {
            return NO;
        }
    }
    //限制输入字数
    if (range.length == 1 && string.length == 0) {
        return YES;
    }else if (self.cellItem.maxInputNum > 0 && textField.text.length >= self.cellItem.maxInputNum) {
        textField.text = [textField.text substringToIndex:self.cellItem.maxInputNum];
        return NO;
    }
    //限制输入字符类型
    if (self.cellItem.importableChar && self.cellItem.importableChar.length > 0) {
        return [textField input:string limit:self.cellItem.importableChar];
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.cellItem.mode == DYInputModeSelect) {
        !self.selectBlock ? : self.selectBlock();
        !self.responseBlock ? : self.responseBlock();
        return NO;
    }
    if (self.cellItem.isUnableToEdit) {
        return NO;
    }
    return YES;
}

- (void)textFieldDidChanged:(UITextField *)textField {
    //金额
    if (self.cellItem.isAmountOfMoney && [textField.text containsString:@"."]) {
        NSArray <NSString *>*texts = [textField.text componentsSeparatedByString:@"."];
        NSString *firstString = [texts firstObject];
        NSString *lastString = [texts lastObject];
        if (lastString.length > 2) {
            [textField substringToIndex:firstString.length + 3];
        }
    }
    self.cellItem.text = textField.text;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.cellItem.mode == DYInputModeDefalut) {
        !self.endEditBlock ? : self.endEditBlock();
        !self.responseBlock ? : self.responseBlock();
    }
}

#pragma mark - setter
- (void)setItem:(DYTableViewCellItem *)item {
    [super setItem:item];
    
    DYInputCellItem *mm = (DYInputCellItem *)item;
    self.cellItem = mm;
    
    if (mm.isAmountOfMoney) {
        mm.keyboardType = UIKeyboardTypeDecimalPad;
        mm.importableChar = @"1234567890.";
    }
    _titleLabel.text = mm.title;
    _textField.text = mm.text;
    _textField.placeholder = mm.placeholder;
    _textField.keyboardType = mm.keyboardType;
    _textField.secureTextEntry = NO;
    
    switch (mm.mode) {
        case DYInputModeDefalut:
        {
            _codeButton.hidden = _imageButton.hidden = YES;
        }
            break;
        case DYInputModeSelect:
        {
            _codeButton.hidden = YES;
            _imageButton.hidden = NO;
            UIImage *image = mm.image ? : [UIImage imageNamed:image_select];
            [_imageButton setImage:image forState:UIControlStateNormal];
        }
            break;
        case DYInputModePhoto:
        {
            _codeButton.hidden = YES;
            _imageButton.hidden = NO;
            UIImage *image = mm.image ? : [UIImage imageNamed:image_photo];
            [_imageButton setImage:image forState:UIControlStateNormal];
        }
            break;
        case DYInputModeCode:
        {
            _codeButton.hidden = NO;
            _imageButton.hidden = YES;
        }
            break;
        case DYInputModeSecure:
        {
            _codeButton.hidden = YES;
            _imageButton.hidden = YES;
//            [_imageButton setImage:[UIImage imageNamed:image_close] forState:UIControlStateNormal];
//            [_imageButton setImage:[UIImage imageNamed:image_open] forState:UIControlStateSelected];
            _textField.secureTextEntry = YES;
        }
            break;
    }
    
    if (mm.isStartCountDown) {
        [self startCountdown];
        [_textField becomeFirstResponder];
        mm.startCountDown = NO;
    }
    
    if (mm.isResetCountDown) {
        [self resetCountdown];
        mm.resetCountDown = NO;
    }
    
    [self layoutIfNeeded];
}


#pragma mark - getter
- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField.delegate = self;
        _textField.font = XHQ5SEFont(14);
        _textField.textColor = [UIColor xhq_aTitle];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_textField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel xhq_layoutColor:[UIColor xhq_aTitle]
                                          font:XHQ5SEFont(14)
                                          text:@""];
        _titleLabel.textAlignment = 0;
    }
    return _titleLabel;
}

- (UIButton *)codeButton {
    if (!_codeButton) {
        _codeButton = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor xhq_base] forState:UIControlStateNormal];
            btn.titleLabel.font = XHQ5SEFont(14);
            [btn xhq_addTarget:self action:@selector(codeButtonClicked)];
            btn;
        });
    }
    return _codeButton;
}

- (UIButton *)imageButton {
    if (!_imageButton) {
        _imageButton = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn xhq_addTarget:self action:@selector(imageButtonClicked:)];
            btn;
        });
    }
    return _imageButton;
}

@end


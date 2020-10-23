//
//  DYContentCell.m
//  ShanghaiCard
//
//  Created by 帝云科技 on 2018/11/7.
//  Copyright © 2018 帝云科技. All rights reserved.
//

#import "DYContentCell.h"

@implementation DYContentCellItem

- (CGFloat)cellHeight {
    return 45.f;
}

@end

@interface DYContentCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *userImageView;

@property (nonatomic, weak) DYContentCellItem *cellItem;

@end

static NSString *const image_placeholder = @"icon_haed_default";

@implementation DYContentCell

- (void)dy_initUI {
    [super dy_initUI];
    
    _titleLabel = ({
        UILabel *label = [UILabel xhq_layoutColor:[UIColor xhq_aTitle]
                                             font:[UIFont xhq_font14]
                                             text:@"标题"];
        label;
    });
    _contentLabel = ({
        UILabel *label = [UILabel xhq_layoutColor:[UIColor xhq_aTitle]
                                             font:[UIFont xhq_font14]
                                             text:@"内容"];
        label.textAlignment = 2;
        label.numberOfLines = 2;
        label;
    });
    _userImageView = ({
        UIImageView *iv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:image_placeholder]];
        [iv xhq_cornerRadius:12];
        iv;
    });
    
    [self addSubview:_titleLabel];
    [self addSubview:_contentLabel];
    [self addSubview:_userImageView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat marge = DYCellSideMarge;
    [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(marge);
        make.centerY.equalTo(0);
    }];
    [_userImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.size.equalTo(CGSizeMake(24, 24));
        if (self.cellItem.isShowIndicator) {
            make.trailing.equalTo(-30);
        }else {
            make.trailing.equalTo(-marge);
        }
    }];
    [_contentLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.leading.equalTo(_titleLabel.trailing).offset(marge);
        if (self.cellItem.isShowIndicator) {
            make.trailing.equalTo(-30);
        }else {
            make.trailing.equalTo(-marge);
        }
    }];
}

- (void)setItem:(DYTableViewCellItem *)item {
    [super setItem:item];
    
    DYContentCellItem *mm = (DYContentCellItem *)item;
    self.cellItem = mm;
    
    _titleLabel.text = mm.title;
    _titleLabel.textColor = mm.titleColor ? : [UIColor xhq_aTitle];
    _titleLabel.font = mm.titleFont ? : UIFont.xhq_font15;
    
    self.selectionStyle = mm.isShowIndicator ? UITableViewCellSelectionStyleDefault : UITableViewCellSelectionStyleNone;
    
    switch (mm.mode) {
        case DYContentCellModeText:
        {
            _contentLabel.hidden = NO;
            _userImageView.hidden = YES;
            
            _contentLabel.text = mm.content;
            _contentLabel.textColor = mm.contentColor ? : [UIColor xhq_aTitle];
            _contentLabel.font = mm.contentFont ? : UIFont.xhq_font15;
        }
            break;
        case DYContentCellModeImage:
        {
            _contentLabel.hidden = YES;
            _userImageView.hidden = NO;
            
            [_userImageView sd_setImageWithURL:[NSURL URLWithString:mm.imageUrlString] placeholderImage:[UIImage imageNamed:image_placeholder]];
        }
            break;
    }
    
    [self layoutIfNeeded];
    [self setNeedsLayout];
}


@end

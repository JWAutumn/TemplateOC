//
//  DYCollectionViewCell.m
//  FireControl
//
//  Created by 帝云科技 on 2019/5/28.
//  Copyright © 2019 帝云科技. All rights reserved.
//

#import "DYCollectionViewCell.h"

@interface DYCollectionViewCellItem ()

@property (nonatomic, strong) NSString *cellIdentifier;

@end

@implementation DYCollectionViewCellItem

- (NSString *)cellIdentifier {
    NSString *className = NSStringFromClass([self class]);
    if ([className hasSuffix:@"Item"]) {
        _cellIdentifier = [className substringToIndex:className.length - 4];
    }
    return _cellIdentifier;
}

- (Class)cellClass {
    return NSClassFromString(self.cellIdentifier);
}

+ (instancetype)item {
    return [[[self class]alloc] init];
}

@end


@interface DYCollectionViewCell ()

@property (nonatomic, strong) UILabel *separatorLabel;

@end

@implementation DYCollectionViewCell

#pragma mark - setter
- (void)setItem:(DYCollectionViewCellItem *)item {
    _item = item;
}

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self dy_initUI];
    }
    return self;
}

- (void)dy_initUI {
    self.backgroundColor = UIColor.whiteColor;
    [self addSubview:self.separatorLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_separatorLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(0);
        make.height.equalTo(0.5f);
        make.leading.equalTo(_sideMargin);
        make.trailing.equalTo(-_sideMargin);
    }];
    
    [self bringSubviewToFront:_separatorLabel];
}

- (void)setHideSeparatorLabel:(BOOL)hideSeparatorLabel {
    _hideSeparatorLabel = hideSeparatorLabel;
    _separatorLabel.hidden = hideSeparatorLabel;
}

- (void)setSideMargin:(CGFloat)sideMargin {
    _sideMargin = sideMargin;
    [self layoutIfNeeded];
}

#pragma mark - getter
- (UILabel *)separatorLabel {
    if (!_separatorLabel) {
        _separatorLabel = [UILabel xhq_lineLabel];
        _separatorLabel.hidden = YES;
    }
    return _separatorLabel;
}

@end


@implementation NSMutableArray (DYCollectionCellItem)

- (__kindof DYCollectionViewCellItem *)dy_cItemForTitle:(NSString *)title {
    for (id obj in self) {
        if ([obj isKindOfClass:[NSMutableArray class]]) {
            NSMutableArray *items = (NSMutableArray *)obj;
            DYCollectionViewCellItem *item = [items dy_cItemForTitle:title];
            if (item) {
                return item;
            }
        } else if ([obj isKindOfClass:[DYCollectionViewCellItem class]]) {
            DYCollectionViewCellItem *item = (DYCollectionViewCellItem *)obj;
            if ([item.title isEqualToString:title]) {
                return item;
            }
        }
    }
    return nil;
}

@end

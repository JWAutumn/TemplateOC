//
//  DYViewController.m
//  ShanghaiCard
//
//  Created by 帝云科技 on 2018/10/31.
//  Copyright © 2018 帝云科技. All rights reserved.
//

#import "DYViewController.h"
#import "DYViewController+BarButtonItem.h"

@interface DYViewController ()

@end

@implementation DYViewController

- (void)dealloc {
    XHQLog(@"dealloc: %@", NSStringFromClass(self.class));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self dy_initData];
    [self dy_initUI];
    [self dy_request];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self dy_reloadData];
    
    self.dy_barStyle = UIStatusBarStyleDefault;
}

- (void)dy_initData {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.firstLoadHUD = YES;
}

- (void)dy_initUI {
    self.view.backgroundColor = [UIColor xhq_section];
}

- (void)dy_request {
    
}

- (void)dy_reloadData {
    
}

#pragma mark - getter
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

@end

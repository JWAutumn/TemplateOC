//
//  DYTabBarController.m
//  ShanghaiCard
//
//  Created by 帝云科技 on 2018/10/31.
//  Copyright © 2018 帝云科技. All rights reserved.
//

#import "DYTabBarController.h"
//#import "DYNavigationController.h"
//#import "DYLoginVC.h"

@interface DYTabBarController ()<UITabBarControllerDelegate>

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) NSMutableArray<UIView *> *imageViews;

@end

static NSString *const image_highlighted = @"_highlighted";

static NSString *const tabbar_image_1 = @"";
static NSString *const tabbar_image_2 = @"";
static NSString *const tabbar_image_3 = @"";
static NSString *const tabbar_image_4 = @"";

static NSString *const tabbar_vc_1 = @"";
static NSString *const tabbar_vc_2 = @"";
static NSString *const tabbar_vc_3 = @"";
static NSString *const tabbar_vc_4 = @"";

static NSString *const tabbar_title_1 = @"";
static NSString *const tabbar_title_2 = @"";
static NSString *const tabbar_title_3 = @"";
static NSString *const tabbar_title_4 = @"";

static NSString *const navigation_vc = @"DYNavigationController";

@implementation DYTabBarController

+ (void)initialize {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = UIColor.xhq_assist;
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor xhq_base];
    
    UITabBarItem *items = [UITabBarItem appearance];
    [items setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [items setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    UITabBar *tabbar = [UITabBar appearance];
    tabbar.translucent = NO;
    [tabbar setBarTintColor:[UIColor whiteColor]];
}

- (NSMutableArray<UIView *> *)imageViews {
    if (!_imageViews) {
        _imageViews = [[NSMutableArray alloc] init];
        [self.tabBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                UIControl *tabbarButton = (UIControl *)obj;
                [tabbarButton.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull sub, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([sub isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
                        [_imageViews addObject:sub];
                    }
                }];
            }
        }];
    }
    return _imageViews;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    [self addChildViewControllerClassName:tabbar_vc_1 title:tabbar_title_1 imageName:tabbar_image_1];
    [self addChildViewControllerClassName:tabbar_vc_2 title:tabbar_title_2 imageName:tabbar_image_2];
    [self addChildViewControllerClassName:tabbar_vc_3 title:tabbar_title_3 imageName:tabbar_image_3];
    [self addChildViewControllerClassName:tabbar_vc_4 title:tabbar_title_4 imageName:tabbar_image_4];
}

- (void)addChildViewControllerClassName:(NSString *)className title:(NSString *)title imageName:(NSString *)imageName {
    UIViewController *viewController = [[NSClassFromString(className) alloc]init];
    Class navClass = NSClassFromString(navigation_vc);
    UINavigationController *nav = [[navClass alloc]initWithRootViewController:viewController];
    viewController.title = title;
    viewController.tabBarItem.image = [[UIImage imageNamed:imageName]
                                       imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:[imageName stringByAppendingString:image_highlighted]]
                                               imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
//    NSInteger selectedIndex = [tabBarController.viewControllers indexOfObject:viewController];
    return YES;
}


/**
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSInteger index = [self.tabBar.items indexOfObject:item];
    if (self.currentIndex != index) {
        [self animatedWithIndex:index];
    }
}

- (void)animatedWithIndex:(NSInteger)index {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
    animation.duration = 0.5;
    animation.calculationMode = kCAAnimationCubic;
    [[self.imageViews[index] layer] addAnimation:animation forKey:nil];
    self.currentIndex = index;
}
 
 */

@end

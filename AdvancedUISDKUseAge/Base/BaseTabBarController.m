//
//  BaseTabBarController.m
//  AdvancedUISDKUseAge
//
//  Created by konglee on 2017/11/16.
//  Copyright © 2017年 konglee. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavViewController.h"
#import "Item0ViewController.h"
#import "Item1ViewController.h"
#import "Item2ViewController.h"
#import "Item3ViewController.h"


@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initItemVC];
}

- (void)initItemVC
{
    for (NSInteger i = 0; i < 3; i ++)
    {
        Class CLS = NSClassFromString([NSString stringWithFormat:@"Item%ldViewController",i]);
        id vc = [CLS new];
        if ([vc isKindOfClass:[UIViewController class]])
        {
            UIViewController *itemVC = (UIViewController *)vc;
            itemVC.tabBarItem.title = [NSString stringWithFormat:@"item%ld",i];
            [itemVC.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
            [itemVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
            [itemVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
//            [itemVC.tabBarItem setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tab%ld",i]]];
//            [itemVC.tabBarItem setSelectedImage:[UIImage imageNamed:[NSString stringWithFormat:@"tabred%ld",i]]];
            itemVC.tabBarItem.image = [[UIImage imageNamed:[NSString stringWithFormat:@"tab%ld",i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            itemVC.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"tabred%ld",i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            BaseNavViewController *nav = [[BaseNavViewController alloc]initWithRootViewController:itemVC];
            [self addChildViewController:nav];
        }
    }
}



@end

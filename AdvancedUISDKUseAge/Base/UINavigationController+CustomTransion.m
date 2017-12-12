//
//  UINavigationController+CustomTransion.m
//  AdvancedUISDKUseAge
//
//  Created by kong on 2017/12/12.
//  Copyright © 2017年 konglee. All rights reserved.
//

#import "UINavigationController+CustomTransion.h"
#import <objc/runtime.h>

@implementation UINavigationController (CustomTransion)

+ (void)load
{
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = [self class];
        SEL selOrigin = @selector(pushViewController:animated:);
        SEL selReplace = @selector(c_pushViewController:animated:);
        Method mOrigin = class_getInstanceMethod(cls, selOrigin);
        Method mReplace = class_getInstanceMethod(cls, selReplace);
        BOOL isSuccess = class_addMethod(cls, selReplace, class_getMethodImplementation(cls, selReplace), method_getTypeEncoding(mReplace));
        if (isSuccess)
        {
            //添加成功
            class_replaceMethod(cls, selReplace, class_getMethodImplementation(cls, selOrigin), method_getTypeEncoding(mOrigin));
        }
        else
        {
            //添加失败
            method_exchangeImplementations(mOrigin, mReplace);
        }
    });
}

- (void)c_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"push here");
    //此时调用 c_pushViewController 实际上调用的是系统的 pushViewController的实现。
    [self c_pushViewController:viewController animated:animated];
}

@end

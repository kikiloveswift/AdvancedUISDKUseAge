//
//  UINavigationController+CustomTransion.m
//  AdvancedUISDKUseAge
//
//  Created by kong on 2017/12/12.
//  Copyright © 2017年 konglee. All rights reserved.
//

#import "UINavigationController+CustomTransion.h"
#import <objc/runtime.h>
#import "NSObject+PrintAllProperty.h"


@implementation UINavigationController (CustomTransion)



- (UIPanGestureRecognizer *)CT_POPGesture
{
    NSLog(@"sel is %@",NSStringFromSelector(_cmd));

    UIPanGestureRecognizer *panges = objc_getAssociatedObject(self, _cmd);
    
    if (!panges)
    {
        panges = [UIPanGestureRecognizer new];
        objc_setAssociatedObject(self, _cmd, panges, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    }
    return panges;
}

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
    //遍历这个类的所有属性
//    [self.interactivePopGestureRecognizer printsIvars];
//    [self.interactivePopGestureRecognizer printsProperties];
    //获取 类型:@"NSMutableArray",名称:_targets
    // handleNavigationTransition:
//    if (![self.interactivePopGestureRecognizer.view.gestureRecognizers containsObject:self.CT_POPGesture])
//    {
//        NSArray *internalTargets = (NSArray *)[self.interactivePopGestureRecognizer valueForKey:@"targets"];
//        id internalTarget = [internalTargets firstObject];
//        SEL orignSEL = NSSelectorFromString(@"handleNavigationTransition:");
//        Class innerCLS = NSClassFromString(@"UIScreenEdgePanGestureRecognizer");
//        Method originM = class_getInstanceMethod([innerCLS class], orignSEL);
//        BOOL addSuccess = class_addMethod([self.CT_POPGesture class], orignSEL, class_getMethodImplementation([self.interactivePopGestureRecognizer class], orignSEL), method_getTypeEncoding(originM));
//
//        if (addSuccess)
//        {
//            NSLog(@"添加成功");
//        }
//        [self.CT_POPGesture addTarget:internalTarget action:orignSEL];
//        [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.CT_POPGesture];
//        self.interactivePopGestureRecognizer.enabled = NO;
//    }
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return nil;
}
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    return nil;
}

@end

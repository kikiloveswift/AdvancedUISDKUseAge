//
//  NavTransitionDelegate.m
//  AdvancedUISDKUseAge
//
//  Created by kong on 2017/12/25.
//  Copyright © 2017年 konglee. All rights reserved.
//

#import "NavTransitionDelegate.h"
#import "Animator.h"

@interface NavTransitionDelegate()

@property (strong, nonatomic) Animator* animator;
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition* interactionController;
@property(nonatomic, strong)UINavigationController *nav;


@end

@implementation NavTransitionDelegate

- (instancetype)initWithNav:(UINavigationController *)nav
{
    if (self = [super init])
    {
        _nav = nav;
        nav.delegate = self;
        [self initSetting];
    }
    return self;
}


- (void)initSetting
{
    UIPanGestureRecognizer* panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.nav.view addGestureRecognizer:panRecognizer];
    self.animator = [Animator new];
}

- (void)pan:(UIPanGestureRecognizer*)recognizer
{
    UIView* view = self.nav.view;
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint location = [recognizer locationInView:view];
        if (location.x <  CGRectGetMidX(view.bounds) && self.nav.viewControllers.count > 1) { // left half
            self.interactionController = [UIPercentDrivenInteractiveTransition new];
            [self.nav popViewControllerAnimated:YES];
        }
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:view];
        CGFloat d = fabs(translation.x / CGRectGetWidth(view.bounds));
        [self.interactionController updateInteractiveTransition:d];
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        if ([recognizer velocityInView:view].x > 0) {
            [self.interactionController finishInteractiveTransition];
        } else {
            [self.interactionController cancelInteractiveTransition];
        }
        self.interactionController = nil;
    }
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPop) {
        return self.animator;
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return self.interactionController;
}

@end

//
//  PresentAnimator.m
//  AdvancedUISDKUseAge
//
//  Created by kong on 2018/1/10.
//  Copyright © 2018年 konglee. All rights reserved.
//

#import "PresentAnimator.h"
#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

@interface PresentAnimator()

@property (nonatomic, strong) EAGLContext *glContext;

@property (nonatomic, strong) GLKView *glView;

@end

@implementation PresentAnimator

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 2.0f;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = transitionContext.containerView;
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [containerView addSubview:toView];
    [containerView insertSubview:toView atIndex:0];
    self.glContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:self.glContext];
    
    self.glView = [[GLKView alloc] initWithFrame:fromView.frame context:self.glContext];
    _glView.enableSetNeedsDisplay = true;
//    _glView.delegate = self;
//    _glView.isOpaque = false;
    [containerView addSubview:_glView];
    
    
    
}

- (float)generateRandomFloatWith:(float)smallNum BigNum:(float)bigNum
{
    float diff = bigNum - smallNum;
    return fmod(arc4random() / 100.0, diff) + smallNum;
}

@end

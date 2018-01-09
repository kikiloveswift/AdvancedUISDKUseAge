//
//  FragmentPresentViewController.m
//  AdvancedUISDKUseAge
//
//  Created by kong on 2018/1/9.
//  Copyright © 2018年 konglee. All rights reserved.
//

#import "FragmentPresentViewController.h"

@interface FragmentPresentViewController ()

@end

@implementation FragmentPresentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUILayer];
}

- (void)initUILayer
{
    UIControl *control = [UIControl new];
    control.frame = CGRectMake(KWidth - 70, 64, 50, 50);
    [control addTarget: self action:@selector(breakAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:control];
    
    CGFloat gap = 15;
    UIBezierPath *bPath = [UIBezierPath bezierPath];
    [bPath moveToPoint:CGPointMake(gap, gap)];
    [bPath addLineToPoint:CGPointMake(50 - gap, 50 - gap)];
    
    UIBezierPath *cPath = [UIBezierPath bezierPath];
    [cPath moveToPoint:CGPointMake(50 - gap, gap)];
    [cPath addLineToPoint:CGPointMake(gap, 50 - gap)];

    CAShapeLayer *slayer = [CAShapeLayer layer];
    slayer.path = bPath.CGPath;
    slayer.lineWidth = 2.0f;
    slayer.lineCap = kCALineCapRound;
    slayer.strokeColor = [UIColor colorWithHex:0x555555 alpha:1].CGColor;
    [control.layer addSublayer:slayer];

    CAShapeLayer *s2layer = [CAShapeLayer layer];
    s2layer.path = cPath.CGPath;
    s2layer.lineWidth = 2.0f;
    s2layer.lineCap = kCALineCapRound;
    s2layer.strokeColor = [UIColor colorWithHex:0x555555 alpha:1].CGColor;
    [control.layer addSublayer:s2layer];
    
    
    CAShapeLayer *bgLayer = [CAShapeLayer layer];
    bgLayer.frame = self.view.bounds;
    bgLayer.contents = (__bridge id _Nullable)[UIImage imageNamed:@"zlc.jpg"].CGImage;
//    bgLayer.contentsGravity = kCAGravityResizeAspectFill;
    [self.view.layer addSublayer:bgLayer];
    [self.view.layer insertSublayer:bgLayer below:control.layer];
}

- (void)breakAnimation:(UIControl *)contrl
{
    
}




@end

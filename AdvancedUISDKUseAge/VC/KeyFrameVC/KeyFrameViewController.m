//
//  KeyFrameViewController.m
//  AdvancedUISDKUseAge
//
//  Created by kong on 2017/11/24.
//  Copyright © 2017年 konglee. All rights reserved.
//

#import "KeyFrameViewController.h"


@interface KeyFrameViewController ()<CAAnimationDelegate>

@property (nonatomic, strong) CAShapeLayer *layer;

@property (nonatomic, strong) UIBezierPath *bpath;

@property (nonatomic, strong) CAShapeLayer *slayer;
@end

@implementation KeyFrameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"KeyFrame";
    [self initUI];
}

- (void)initUI
{
    _layer = [CAShapeLayer layer];
    _layer.frame = CGRectMake(20, 200, 300, 400);
    _bpath = [UIBezierPath bezierPath];
    CGPoint p1 = CGPointMake(20, 400);
    [_bpath moveToPoint:p1];

    CGPoint p2 = CGPointMake(220, 400);
    [_bpath addLineToPoint:p2];

    _layer.lineWidth = 5.0f;
    _layer.fillColor = [UIColor clearColor].CGColor;
    _layer.strokeColor = [UIColor redColor].CGColor;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(220, 300) radius:100 startAngle:-M_PI endAngle:M_PI/2 clockwise:YES];
    [_bpath appendPath:path];
    _layer.path = _bpath.CGPath;
    [self.view.layer addSublayer:_layer];
    
    _slayer = [CAShapeLayer layer];
    _slayer.frame = CGRectMake(20, 400, 10, 10);
    UIBezierPath *b1path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0) radius:10 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    _slayer.path = b1path.CGPath;
    _slayer.fillColor = [UIColor orangeColor].CGColor;
    _slayer.strokeColor = [UIColor orangeColor].CGColor;
    [self.view.layer addSublayer:_slayer];

}

- (IBAction)beginLoading:(UIButton *)sender
{
    
    
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
//    animation.delegate = self;
    animation.path = _bpath.CGPath;
    animation.duration = 5;
    animation.autoreverses = YES;
    
    
    
    [_slayer addAnimation:animation forKey:@"position"];

}

#pragma Mark- CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"动画开始");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"动画结束");
}



@end

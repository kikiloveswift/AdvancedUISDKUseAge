//
//  KeyFrameViewController.m
//  AdvancedUISDKUseAge
//
//  Created by kong on 2017/11/24.
//  Copyright © 2017年 konglee. All rights reserved.
//

#import "KeyFrameViewController.h"


@interface KeyFrameViewController ()<CAAnimationDelegate>

@property (nonatomic, strong) CAShapeLayer *trackLayer;

@property (nonatomic, strong) CAShapeLayer *ballLayer;

@end

@implementation KeyFrameViewController
{
    UIBezierPath *bPathLine;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"KeyFrame";
    [self initCALayer];
}

- (void)initCALayer
{
    //画布
    _trackLayer = [CAShapeLayer layer];
    _trackLayer.frame = CGRectZero;
    
    //path1
    bPathLine = [UIBezierPath bezierPath];
    [bPathLine moveToPoint:CGPointMake(20, 400)];
    [bPathLine addLineToPoint:CGPointMake(270, 400)];
    
    UIBezierPath *bPathOval = [UIBezierPath bezierPathWithArcCenter:CGPointMake(270, 300) radius:100 startAngle:-M_PI endAngle:M_PI/2 clockwise:YES];
    [bPathLine appendPath:[bPathOval bezierPathByReversingPath]];
    _trackLayer.path = bPathLine.CGPath;
    _trackLayer.strokeColor = [UIColor greenColor].CGColor;
    _trackLayer.fillColor = [UIColor clearColor].CGColor;
    _trackLayer.lineWidth = 5.0f;
//    _trackLayer
    [self.view.layer addSublayer:_trackLayer];
    
    _ballLayer = [CAShapeLayer layer];
//    _ballLayer.frame = CGRectZero;
    _ballLayer.frame = CGRectMake(20, 400, 0, 0);
    
    UIBezierPath *bPathBall = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0) radius:10 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    _ballLayer.fillColor = [UIColor orangeColor].CGColor;
    _ballLayer.strokeColor = [UIColor clearColor].CGColor;
    _ballLayer.path = bPathBall.CGPath;
    
    [self.view.layer addSublayer:_ballLayer];
    
    
}


- (IBAction)beginLoading:(UIButton *)sender
{
    CABasicAnimation *animationStrokeEnd = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animationStrokeEnd.toValue = @1;
    animationStrokeEnd.fromValue = @0.001;
    animationStrokeEnd.duration = 2.0f;
    animationStrokeEnd.autoreverses = YES;
    animationStrokeEnd.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_trackLayer addAnimation:animationStrokeEnd forKey:@"animationStrokeEnd"];
    
    CABasicAnimation *animationStrokeColor = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
    animationStrokeColor.duration = 2.0f;
    animationStrokeColor.autoreverses = YES;
    animationStrokeColor.fromValue = (id)[UIColor clearColor].CGColor;
    animationStrokeColor.toValue = (id)[UIColor redColor].CGColor;
    animationStrokeColor.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [_trackLayer addAnimation:animationStrokeColor forKey:@"animationStrokeColor"];
    
//    CAKeyframeAnimation * path2StrokeColorAnim = [CAKeyframeAnimation animationWithKeyPath:@"strokeColor"];
//    path2StrokeColorAnim.values   = @[(id)[UIColor colorWithRed:1 green: 0.205 blue:0.226 alpha:1].CGColor,(id)[UIColor colorWithRed:0.132 green: 0.745 blue:0.155 alpha:1].CGColor];
//    path2StrokeColorAnim.keyTimes = @[@0, @1];
//    path2StrokeColorAnim.duration = 1;
    
    CAKeyframeAnimation *animationPosition = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animationPosition.path = bPathLine.CGPath;
    animationPosition.duration = 2.0f;
    animationPosition.autoreverses = YES;
    animationPosition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animationPosition.calculationMode = kCAAnimationPaced;
    [_ballLayer addAnimation:animationPosition forKey:@"animationPosition"];
    
    if (@available(iOS 9.0, *)) {
        CASpringAnimation *springAnmation = [CASpringAnimation animationWithKeyPath:@"position.x"];
        springAnmation.damping = 5;
        //mass 是质量
        springAnmation.mass = 4;
        //stiffness 是刚度系数 刚度系数越大 产生的力越大 速度越快
        springAnmation.stiffness = 50;
        //初速度
        springAnmation.initialVelocity = 10;
        springAnmation.fromValue = @(sender.layer.position.x);
        springAnmation.toValue = @(sender.layer.position.x +50);
        //settlingDuration 是动画结算时间，只读属性 一般把动画duration设为该值
        springAnmation.duration = springAnmation.settlingDuration;
        [sender.layer addAnimation:springAnmation forKey:springAnmation.keyPath];
    }

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

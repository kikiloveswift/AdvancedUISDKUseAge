//
//  FragmentViewController.m
//  AdvancedUISDKUseAge
//
//  Created by konglee on 2018/1/5.
//  Copyright © 2018年 konglee. All rights reserved.
//

#import "FragmentViewController.h"
typedef void (^FinishAnimationBlock)(BOOL isFinished);

@interface FragmentViewController ()<CAAnimationDelegate>
{
    CAShapeLayer *dlayer;
}

@property (nonatomic, copy) FinishAnimationBlock finishBlock;
@end

@implementation FragmentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI
{
    self.view.backgroundColor = [UIColor blackColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((KWidth - 200)/2, KHeight - 300, 200, 50);
    btn.layer.cornerRadius = 25;
    btn.layer.borderColor = [UIColor colorWithHexString:@"#FFE81F"].CGColor;
    btn.layer.borderWidth = 1.0f;
    [btn setTitle:@"Animation" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    dlayer = [CAShapeLayer layer];
    dlayer.frame = CGRectMake((KWidth - 200)/2, 200, 200, 50);
    dlayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.view.layer addSublayer:dlayer];
    
//    CALayer *maskLayer = [CALayer layer];
//    maskLayer.frame = CGRectMake(0, 0, 260, 10);
//    maskLayer.backgroundColor = [UIColor greenColor].CGColor;
//    maskLayer.opacity = 0.5;
//    dlayer.mask = maskLayer;
//    dlayer.masksToBounds = NO;
}

- (void)btnClick:(UIButton *)btn
{
    btn.layer.masksToBounds = YES;
    CALayer *fillLayer = [CALayer layer];
    fillLayer.backgroundColor = btn.layer.borderColor;
    fillLayer.frame = btn.bounds;
    [btn.layer addSublayer:fillLayer];
    [btn.layer insertSublayer:fillLayer atIndex:0];
    
    CGPoint center = btn.center;
    CGFloat radius = MAX(btn.bounds.size.width/2, btn.bounds.size.height/2);
    CGRect rect = {.origin= {center.x, center.y}, .size = {0.1,0.1} };
    CGRect begininsetRect = CGRectInset(rect, 100, 25);
    CGRect endinsetRect =CGRectMake(0, 0, 100, 100);

//    CGRect endinsetRect = btn.frame;
//    CGPathRef startPath = CGPathCreateWithEllipseInRect(begininsetRect, nil);
//    CGPathRef endPath = CGPathCreateWithEllipseInRect(endinsetRect, nil);
    UIBezierPath *beginPath = [UIBezierPath bezierPathWithArcCenter:btn.center radius:1 startAngle:0 endAngle:M_PI *2 clockwise:YES];
    UIBezierPath *terminalPath = [UIBezierPath bezierPathWithArcCenter:btn.center radius:100 startAngle:0 endAngle:M_PI *2 clockwise:YES];
    
    dlayer.path = terminalPath.CGPath;

    CGPathRef startPath = beginPath.CGPath;
    CGPathRef endPath = terminalPath.CGPath;
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = startPath;
    maskLayer.fillMode = kCAFillRuleEvenOdd;
    fillLayer.mask = maskLayer;
    maskLayer.frame = btn.bounds;
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.duration = 0.2f;
    pathAnimation.delegate = self;
    pathAnimation.fromValue = (__bridge id _Nullable)(startPath);
    pathAnimation.toValue = (__bridge id _Nullable)(endPath);
    [maskLayer addAnimation:pathAnimation forKey:@"path"];
    
    self.finishBlock = ^(BOOL isFinished) {
        fillLayer.opacity = 0;
        CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.fromValue = @1;
        opacityAnimation.toValue = @0;
        opacityAnimation.duration = 0.2;
        [fillLayer addAnimation:opacityAnimation forKey:@"opacity"];
    };
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag)
    {
        if (self.finishBlock)
        {
            self.finishBlock(YES);
        }
    }
}


@end

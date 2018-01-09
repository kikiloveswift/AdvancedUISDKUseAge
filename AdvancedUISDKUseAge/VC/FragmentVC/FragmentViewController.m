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
    NSTimer *timer;
    CAEmitterLayer *elayer;
    CAEmitterCell *emitterCell;
}

@property (nonatomic, copy) FinishAnimationBlock finishBlock;

@property (nonatomic, strong) UIBezierPath *btnPath;
@end

@implementation FragmentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initCAEmitter];
    [self initUI];
    [self addTimer];
}

- (void)didMoveToParentViewController:(UIViewController *)parent
{
    [super didMoveToParentViewController:parent];
    
}
- (void)dealloc
{
    [timer invalidate];
    timer = nil;
}

- (void)addTimer
{
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(randomEmitterPosition) userInfo:nil repeats:YES];
    [timer fire];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)randomEmitterPosition
{
    CGFloat width = MAX(KWidth, KHeight);
//    CGFloat x = arc4random()/width;
    CGFloat radius = fmod(arc4random(), width);
    elayer.emitterSize = CGSizeMake(radius, radius);
    emitterCell.birthRate = 10 + sqrt(radius);
}
- (void)initCAEmitter
{
    elayer = [CAEmitterLayer layer];
    elayer.backgroundColor = [UIColor blackColor].CGColor;
    elayer.frame = self.view.bounds;
    [self.view.layer addSublayer:elayer];
    elayer.emitterPosition = CGPointMake(KWidth/2, 0);
    elayer.emitterSize = CGSizeMake(KWidth, KHeight);
    elayer.emitterMode = kCAEmitterLayerOutline;
    elayer.emitterShape = kCAEmitterLayerCircle;
    elayer.renderMode = kCAEmitterLayerOldestFirst;
    elayer.preservesDepth = true;
    emitterCell = [CAEmitterCell emitterCell];
    emitterCell.contents = (id)[UIImage imageNamed:@"spark"].CGImage;
    emitterCell.birthRate = 10;
    emitterCell.lifetime = 50;
    emitterCell.lifetimeRange = 5;
    
    emitterCell.velocity = 20;
    emitterCell.velocityRange = 10;
    
    emitterCell.scale = 0.02;
    emitterCell.scaleRange = 0.1;
    emitterCell.scaleSpeed = 0.02;
    elayer.emitterCells = @[emitterCell];
    
//    // 制造一个y轴的加速度
//    emitterCell.yAcceleration = 10.0;
//    // 制造一个x轴的加速度
//    emitterCell.xAcceleration = 10.0;
//
//    emitterCell.velocity = 20.0;
//    // 给微粒设置一个发射角度
//    emitterCell.emissionLongitude = -M_PI;
//    emitterCell.scale = 0.8;
//
//    //    emitterCell.spin = M_PI * 2;
//    //    emitterCell.spinRange = M_PI;
//
//
//    // 添加随机的速度,如果有velocity,那么范围为 -180 ~ 220
//    emitterCell.velocityRange = 200.0;
//    emitterCell.emissionRange = M_PI_2;
//
//    emitterCell.lifetimeRange = 18;
//
//    emitterCell.color = [UIColor colorWithRed:0.9 green:1.0 blue:1.0 alpha:1.0].CGColor;
//    // 值为0.3 的范围为 0.7~1.3,但由于高于1算1,所以值得范围为 0.7~1
//    emitterCell.redRange = 0.3;
//    emitterCell.greenRange = 0.3;
//    emitterCell.blueRange = 0.3;
//    // 随机大小
//    emitterCell.scale = 0.3;
//    emitterCell.scaleRange = 0.9;
//    // 每秒缩小15%
//    emitterCell.scaleSpeed = -0.05;
//
//    //    emitterCell.alphaRange = 0.75;
//    emitterCell.alphaSpeed = 0.1;
}


- (void)initLayer
{
    self.view.backgroundColor = [UIColor blackColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tap];
}

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    CALayer *slayer = [CALayer layer];
    slayer.frame = CGRectMake(0, 64, KWidth, 400);
    slayer.backgroundColor = [UIColor colorWithHexString:@"#FFE81F"].CGColor;
    [self.view.layer addSublayer:slayer];
    
    UIBezierPath *bPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(KWidth/2, 100) radius:100 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = bPath.CGPath;
    slayer.mask = maskLayer;
    
    UIBezierPath *beginPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(KWidth/2, 100) radius:0.1 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    UIBezierPath *endPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(KWidth/2, 100) radius:100 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    maskLayer.path = beginPath.CGPath;
    [beginPath setUsesEvenOddFillRule:YES];
    maskLayer.fillMode = kCAFillRuleEvenOdd;
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    keyAnimation.values = @[(__bridge id)beginPath.CGPath, (__bridge id)endPath.CGPath];
    keyAnimation.duration = 0.2f;
    keyAnimation.beginTime = CACurrentMediaTime();
    keyAnimation.delegate = self;
    [maskLayer addAnimation:keyAnimation forKey:@"pathAnimation"];
    self.finishBlock = ^(BOOL isFinished) {
        CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        basicAnimation.fromValue = @1;
        basicAnimation.toValue = @0;
        basicAnimation.duration = 0.2;
        [slayer addAnimation:basicAnimation forKey:@"opacityL"];
    };
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
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)btnAction:(UIButton *)btn
{
    btn.layer.masksToBounds = YES;
    CALayer *fillLayer = [CALayer layer];
    fillLayer.backgroundColor = btn.layer.borderColor;
    fillLayer.frame = btn.bounds;
    [btn.layer insertSublayer:fillLayer atIndex:0];
    
    
    UIBezierPath *beginPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 25) radius:1 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 25) radius:100 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath;
    maskLayer.fillMode = kCAFillRuleEvenOdd;
    fillLayer.mask = maskLayer;
    
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    keyAnimation.values = @[(__bridge id)beginPath.CGPath,(__bridge id)endPath.CGPath];
    keyAnimation.duration = 0.2f;
    keyAnimation.delegate = self;
    keyAnimation.beginTime = CACurrentMediaTime();
    keyAnimation.removedOnCompletion = true;
    [maskLayer addAnimation:keyAnimation forKey:@"MaskPathAnimation"];
    self.finishBlock = ^(BOOL isFinished) {
        if (isFinished)
        {
            CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
            basicAnimation.fromValue = @1;
            basicAnimation.toValue = @0;
            basicAnimation.duration = 0.2f;
            basicAnimation.beginTime = CACurrentMediaTime();
            basicAnimation.removedOnCompletion = true;
            fillLayer.opacity = 0;
            [fillLayer addAnimation:basicAnimation forKey:@"opacityAnimation"];
        }
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

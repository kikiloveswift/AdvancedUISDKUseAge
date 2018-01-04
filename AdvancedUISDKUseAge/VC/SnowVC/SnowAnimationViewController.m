//
//  SnowAnimationViewController.m
//  AdvancedUISDKUseAge
//
//  Created by kong on 2018/1/4.
//  Copyright © 2018年 konglee. All rights reserved.
//

#import "SnowAnimationViewController.h"

@interface SnowAnimationViewController ()
{
    UIBezierPath *bPath;
    CALayer *snowLayer;
}

@property(nonatomic, strong) UIDynamicAnimator *animator;

@property (nonatomic, strong) UIPushBehavior *pushBehavior;

@end

@implementation SnowAnimationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addSnow];
}

- (void)initAnimator
{
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
}

- (void)panGesAction:(UIPanGestureRecognizer *)panGes
{
    if (panGes.state == UIGestureRecognizerStateBegan)
    {
        UIPushBehavior *pBehavior = [[UIPushBehavior alloc] initWithItems:@[] mode:UIPushBehaviorModeInstantaneous];
        
    }
    else if (panGes.state == UIGestureRecognizerStateChanged)
    {
        
    }
    else if (panGes.state == UIGestureRecognizerStateEnded)
    {
        
    }
}
- (void)initUI
{
//    snowLayer = [CALayer layer];
//    snowLayer.frame = CGRectMake(0, 100, 50, 50);
//    snowLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"snowflake"].CGImage);
//    [self.view.layer addSublayer:snowLayer];
//    CGFloat originX = 50;
//
//    CAShapeLayer *slayer = [CAShapeLayer layer];
//    bPath = [UIBezierPath bezierPath];
//    [bPath moveToPoint:CGPointMake(originX, 0)];
//    [bPath addCurveToPoint:CGPointMake(originX, KHeight/2) controlPoint1:CGPointMake(KWidth/2, 0) controlPoint2:CGPointMake(KWidth/2, KHeight/2)];
//
//    [bPath addCurveToPoint:CGPointMake(KWidth/2, KHeight) controlPoint1:CGPointMake(KWidth/2, 0) controlPoint2:CGPointMake(KWidth/2, KHeight)];
//
//    slayer.path = bPath.CGPath;
//    slayer.fillColor = [UIColor clearColor].CGColor;
//    slayer.lineWidth = 3.0;
//    slayer.strokeColor = [UIColor blueColor].CGColor;
//    [self.view.layer addSublayer:slayer];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tap];
}

- (void)tapAction:(UITapGestureRecognizer *)tap
{
//    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    keyAnimation.path = bPath.CGPath;
//    keyAnimation.duration = 5.0f;
//    keyAnimation.autoreverses = YES;
//    keyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    keyAnimation.calculationMode = kCAAnimationPaced;
//    [snowLayer addAnimation:keyAnimation forKey:@"animationPosition"];
//
//    CAKeyframeAnimation *rotationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
//    rotationAnimation.values   = @[@(0),@(-360 * M_PI/180)];
//    rotationAnimation.duration = 5.0f;
//    rotationAnimation.autoreverses = YES;
//    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    rotationAnimation.calculationMode = kCAAnimationPaced;
//    [snowLayer addAnimation:rotationAnimation forKey:@"animationTransform"];
//    [self addSnow];
}

- (void)addSnow
{
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.backgroundColor = [UIColor blackColor].CGColor;
    CGRect rect = CGRectMake(0, 0, KWidth, KHeight);
    emitter.frame = rect;
    [self.view.layer addSublayer:emitter];
    
//    emitter.emitterShape = kCAEmitterLayerPoint;
    emitter.emitterPosition = CGPointMake(KWidth/2, 0);
    emitter.emitterSize = CGSizeMake(KWidth, KHeight);
    emitter.emitterMode = kCAEmitterLayerOutline;
    emitter.emitterShape = kCAEmitterLayerCircle;
    emitter.renderMode = kCAEmitterLayerOldestFirst;
    emitter.preservesDepth = true;
    NSMutableArray *mArr = [NSMutableArray array];
    for (int i = 1; i <= 5; i ++)
    {
        CAEmitterCell *emitterCell = [CAEmitterCell emitterCell];
        emitterCell.contents = (__bridge id _Nullable)([UIImage imageNamed:[NSString stringWithFormat:@"%d",i]].CGImage);
        // 每秒创建的cell
        emitterCell.birthRate = 30;
        // cell的生命周期为1.5秒
        emitterCell.lifetime = 3;
        // emitter可以添加很多不同类型的cell
        
        // 制造一个y轴的加速度
        emitterCell.yAcceleration = 10.0;
        // 制造一个x轴的加速度
        emitterCell.xAcceleration = 10.0;
        
        emitterCell.velocity = 20.0;
        // 给微粒设置一个发射角度
        emitterCell.emissionLongitude = -M_PI;
        emitterCell.scale = 0.8;
        
        //    emitterCell.spin = M_PI * 2;
        //    emitterCell.spinRange = M_PI;
        
        
        // 添加随机的速度,如果有velocity,那么范围为 -180 ~ 220
        emitterCell.velocityRange = 200.0;
        emitterCell.emissionRange = M_PI_2;
        
        emitterCell.lifetimeRange = 18;
        
        emitterCell.color = [UIColor colorWithRed:0.9 green:1.0 blue:1.0 alpha:1.0].CGColor;
        // 值为0.3 的范围为 0.7~1.3,但由于高于1算1,所以值得范围为 0.7~1
        emitterCell.redRange = 0.3;
        emitterCell.greenRange = 0.3;
        emitterCell.blueRange = 0.3;
        // 随机大小
        emitterCell.scale = 0.3;
        emitterCell.scaleRange = 0.9;
        // 每秒缩小15%
        emitterCell.scaleSpeed = -0.05;
        
        //    emitterCell.alphaRange = 0.75;
        emitterCell.alphaSpeed = 0.1;
        [mArr addObject:emitterCell];
    }
    
    emitter.emitterCells = [mArr copy];
    [self.view snapshotViewAfterScreenUpdates:YES];
    
}

@end

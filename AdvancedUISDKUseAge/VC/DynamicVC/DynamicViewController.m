//
//  DynamicViewController.m
//  AdvancedUISDKUseAge
//
//  Created by konglee on 2017/11/17.
//  Copyright © 2017年 konglee. All rights reserved.
//

typedef void(^ComPletedBlock)(void);
#import "DynamicViewController.h"

@interface DynamicViewController ()<UICollisionBehaviorDelegate>
{
    UIDynamicAnimator *_animator;
    UIDynamicAnimator *_animatorNew;
    UIImageView *_imgViewRuiWen;
    UIImageView *_imgViewzlc;
}


@end

@implementation DynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initUI];
    [self initAnimatior];
//    [self initLayer]; 失败
    [self initUIView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)initUIView
{
    UIView *greenView = [[UIView alloc] initWithFrame:CGRectMake((KWidth -100)/2, 80, 100, 100)];
    greenView.backgroundColor = [UIColor greenColor];
    greenView.layer.cornerRadius = 10;
    [self.view addSubview:greenView];
    
    UIView *cirView = [UIView new];
    cirView.backgroundColor = [UIColor redColor];
    cirView.frame = CGRectMake((KWidth -100)/2, 80, 100, 100);
    CAShapeLayer *slayer = [CAShapeLayer layer];
    slayer.path = [self bezierPath].CGPath;
    cirView.layer.mask = slayer;
    [self.view addSubview:cirView];
    [self addAnimation:greenView View:cirView];
}



- (void)initLayer
{
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake((KWidth -100)/2, 80, 100, 100);
    layer.cornerRadius = 10;
    layer.backgroundColor = [UIColor greenColor].CGColor;
    [self.view.layer addSublayer:layer];
    
    CAShapeLayer *slayer = [CAShapeLayer layer];
    slayer.path = [self bezierPath].CGPath;
    slayer.fillColor = [UIColor redColor].CGColor;
    slayer.strokeColor = [UIColor brownColor].CGColor;
    [self.view.layer addSublayer:slayer];
    
}

- (UIBezierPath *)bezierPath
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(50, 0)];
    [path addLineToPoint:CGPointMake(0, 100)];
    [path addLineToPoint:CGPointMake(100, 100)];
    [path closePath];
    return path;
}

- (void)initAnimatior
{
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    _animatorNew = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
}

- (void)addAnimation:(UIView *)v1 View:(UIView *)v2
{
    //重力
    UIGravityBehavior *gravity1 = [[UIGravityBehavior alloc] initWithItems:@[v1]];
    //修改重力参数 Vector就是向量 二维坐标系的向量  angle 倾斜角 magnitude = Vy
    gravity1.gravityDirection = CGVectorMake(0.1, 0.1);
    
    UIGravityBehavior *gravity2 = [[UIGravityBehavior alloc] initWithItems:@[v2]];
    gravity2.gravityDirection = CGVectorMake(-0.1, 0.1);
    
    [_animator addBehavior:gravity1];
    [_animatorNew addBehavior:gravity2];
    
    //添加边界反弹
    UICollisionBehavior *collisionBehavior1 = [[UICollisionBehavior alloc] initWithItems:@[v1]];
    collisionBehavior1.translatesReferenceBoundsIntoBoundary = YES;
    [collisionBehavior1 setCollisionMode:UICollisionBehaviorModeBoundaries];
    [_animator addBehavior:collisionBehavior1];
    
    UICollisionBehavior *collisionBehavior2 = [[UICollisionBehavior alloc] initWithItems:@[v2]];
    collisionBehavior2.translatesReferenceBoundsIntoBoundary = YES;
    [collisionBehavior2 setCollisionMode:UICollisionBehaviorModeBoundaries];
    [_animatorNew addBehavior:collisionBehavior2];
    
    //为V1添加动态效果
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[v1]];
    //弹性碰撞
    itemBehavior.elasticity = 1;
    //摩擦力
    itemBehavior.friction = 6;
    //密度
    itemBehavior.density = 0.8;
    //减震
    itemBehavior.resistance = 0.9;
    //角速度
    itemBehavior.angularResistance = 0;
    
    if (@available(iOS 9.0, *)) {
        itemBehavior.charge = 0;
    }
    itemBehavior.allowsRotation = YES;
    [_animator addBehavior:itemBehavior];
    
}



- (void)initUI
{
    UISwitch *s = [[UISwitch alloc] initWithFrame:CGRectMake(0, 80, 80, 40)];
    [s addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:s];
    
    _imgViewRuiWen = [[UIImageView alloc] initWithFrame:CGRectMake((KWidth - 100)/2, (KHeight - 100)/2 - 200, 100, 100)];
    _imgViewRuiWen.contentMode = UIViewContentModeScaleAspectFill;
    _imgViewRuiWen.image = [UIImage imageNamed:@"ruiwen.jpg"];
    [self.view addSubview:_imgViewRuiWen];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:pan];
    
    _imgViewzlc = [[UIImageView alloc] initWithFrame:CGRectMake(100, KHeight - 200, 100, 100)];
    _imgViewzlc.image = [UIImage imageNamed:@"zlc.jpeg"];
    _imgViewzlc.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_imgViewzlc];
}

- (void)panAction:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan locationInView:self.view];
    
    _imgViewRuiWen.center = point;
}
- (void)addAdmation:(void(^)(BOOL isFinish))finishBlock
{
    [self addAttachAnimation];
    
    if (finishBlock) {
        finishBlock(YES);
    }
}

- (void)switchAction:(UISwitch *)s
{
    if (s.on)
    {
        NSLock *lock = [NSLock new];
        [lock lock];
        [self addAdmation:^(BOOL isFinish) {
            [lock unlock];
        }];
    }
    else
    {
        _imgViewRuiWen.frame = CGRectMake((KWidth - 100)/2, (KHeight - 100)/2 - 200, 100, 100);
    }
}

- (void)addGravityAnimation
{
    UIGravityBehavior *gBehavior = [[UIGravityBehavior alloc] initWithItems:@[_imgViewRuiWen]];
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    NSLog(@" value = %.3f",sqrt(3));
    //    gBehavior.gravityDirection = CGVectorMake(sqrt(3), 1); // 以1/√3 = tan(a) a = 30°
    
    [gBehavior setAngle:90*3.14/180.0];// Angel是弧度，度数 * π/180° = 弧度
    [gBehavior setMagnitude:7]; //大小，与运动速度有关
    NSLog(@"dx = %.1f,dy = %.1f",gBehavior.gravityDirection.dx,gBehavior.gravityDirection.dy);
    /*
     总结关系:
     Vector结构体 有两个成员，dx和dy，dy/dx = Magnitude, arctan(dy/dx) = angel弧度制
     */
    //添加碰撞
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[_imgViewRuiWen]];
    [collisionBehavior setCollisionMode:UICollisionBehaviorModeBoundaries];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [_animator addBehavior: collisionBehavior];
    [_animator addBehavior:gBehavior];
}

- (void)addAttachAnimation
{
    [self addGravityAnimation];
    UIAttachmentBehavior *attachBehavior = [[UIAttachmentBehavior alloc] initWithItem:_imgViewRuiWen attachedToAnchor:_imgViewRuiWen.center];
    attachBehavior.damping = 0.5;
    attachBehavior.length = 50;
    attachBehavior.frequency = 1;
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[_imgViewRuiWen]];
    itemBehavior.elasticity = 0.5;
    itemBehavior.allowsRotation = YES;
    [itemBehavior addAngularVelocity:0.4 forItem:_imgViewRuiWen];
    
    [_animator addBehavior:itemBehavior];
//    [_animator addBehavior:attachBehavior];
}




@end

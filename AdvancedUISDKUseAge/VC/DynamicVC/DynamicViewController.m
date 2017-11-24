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
    UIImageView *_imgViewRuiWen;
    UIImageView *_imgViewzlc;
}


@end

@implementation DynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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

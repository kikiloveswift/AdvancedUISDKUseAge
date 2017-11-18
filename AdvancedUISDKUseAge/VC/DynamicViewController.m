//
//  DynamicViewController.m
//  AdvancedUISDKUseAge
//
//  Created by konglee on 2017/11/17.
//  Copyright © 2017年 konglee. All rights reserved.
//

typedef void(^ComPletedBlock)(void);
#import "DynamicViewController.h"
#import <UIKit/UIKit.h>

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

- (void)initUI
{
    UISwitch *s = [[UISwitch alloc] initWithFrame:CGRectMake(0, 80, 80, 40)];
    [s addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:s];
    
    _imgViewRuiWen = [[UIImageView alloc] initWithFrame:CGRectMake(100, 64, 300, 200)];
    _imgViewRuiWen.image = [UIImage imageNamed:@"ruiwen.jpg"];
    [self.view addSubview:_imgViewRuiWen];
    
    _imgViewzlc = [[UIImageView alloc] initWithFrame:CGRectMake(100, KHeight - 200, 80, 120)];
    _imgViewzlc.image = [UIImage imageNamed:@"zlc.jpeg"];
    [self.view addSubview:_imgViewzlc];
}

- (void)addAdmation:(void(^)(BOOL isFinish))finishBlock
{
    
    UIGravityBehavior *gBehavior = [[UIGravityBehavior alloc] initWithItems:@[_imgViewRuiWen,_imgViewzlc]];
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];

    //添加碰撞
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[_imgViewRuiWen,_imgViewzlc]];
    [collisionBehavior setCollisionMode:UICollisionBehaviorModeBoundaries];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [_animator addBehavior: collisionBehavior];
    [_animator addBehavior:gBehavior];
    
    UIDynamicItemBehavior
    
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
        _imgViewRuiWen.frame = CGRectMake(100, 64, 300, 200);
    }
}




@end

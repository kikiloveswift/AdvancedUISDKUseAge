//
//  DynamicViewController.m
//  AdvancedUISDKUseAge
//
//  Created by konglee on 2017/11/17.
//  Copyright © 2017年 konglee. All rights reserved.
//

typedef void(^ComPletedBlock)(void);
#import "DynamicViewController.h"

@interface DynamicViewController ()
{
    UIDynamicAnimator *_animator;
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
}

- (void)addAdmation:(void(^)(BOOL isFinish))finishBlock
{
    UIImageView *imgViewRuiWen = [[UIImageView alloc] initWithFrame:CGRectMake(100, 64, 300, 200)];
    imgViewRuiWen.image = [UIImage imageNamed:@"ruiwen.jpg"];
    [self.view addSubview:imgViewRuiWen];
    UIGravityBehavior *gBehavior = [[UIGravityBehavior alloc] initWithItems:@[imgViewRuiWen]];
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];

    
    [_animator addBehavior:gBehavior];
    
    if (finishBlock) {
        finishBlock(YES);
    }
}
- (void)switchAction:(UISwitch *)s
{
    if (s.on)
    {
        NSLock *lock = [NSLock new];
//        [lock lock];
        [self addAdmation:^(BOOL isFinish) {
//            [lock unlock];
        }];
    }
}




@end

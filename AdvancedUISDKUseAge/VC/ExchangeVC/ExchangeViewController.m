//
//  ExchangeViewController.m
//  AdvancedUISDKUseAge
//
//  Created by kong on 2017/12/20.
//  Copyright © 2017年 konglee. All rights reserved.
//

#import "ExchangeViewController.h"
#import <objc/runtime.h>
#import "NSObject+PrintAllProperty.h"

@interface ExchangeViewController ()

//有钱Btn
@property (weak, nonatomic) IBOutlet UIButton *weathyBtn;

//穷光蛋Btn
@property (weak, nonatomic) IBOutlet UIButton *poorBtn;

@end

@implementation ExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)weathyBtnAction:(UIButton *)sender
{
    NSLog(@"btn click");
}

- (IBAction)exchangePoorAndWealthy:(UIButton *)sender
{
//    SEL wealthSEL = NSSelectorFromString(@"weathyBtnAction:");
//    NSSet *allTargets = _weathyBtn.allTargets;
//    id target = [allTargets.allObjects firstObject];
//    [self.poorBtn addTarget:target action:wealthSEL forControlEvents:UIControlEventTouchUpInside];
    SEL internalSEL = NSSelectorFromString(@"handleNavigationTransition:");
    NSArray *internalTargets = (NSArray *)[self.navigationController.interactivePopGestureRecognizer valueForKey:@"targets"];
    id target = [internalTargets firstObject];
//    [target printsIvars];
    Class cls = [target class];
    const char *name = [@"_target" cStringUsingEncoding:NSUTF8StringEncoding];
    Ivar tarVar =  class_getInstanceVariable(cls, name);
    id value = object_getIvar(target, tarVar);
//    property

//    id selTarget = [target objectForKey:@"target"];
    
    UIPanGestureRecognizer *panges = [UIPanGestureRecognizer new];
    [self.view addGestureRecognizer:panges];
    [panges addTarget:value action:internalSEL];
//    [self.poorBtn addTarget:target action:internalSEL forControlEvents:UIControlEventTouchUpInside];
    
}

@end

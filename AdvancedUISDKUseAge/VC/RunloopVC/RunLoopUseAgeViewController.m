//
//  RunLoopUseAgeViewController.m
//  AdvancedUISDKUseAge
//
//  Created by kong on 2018/1/11.
//  Copyright © 2018年 konglee. All rights reserved.
//

#import "RunLoopUseAgeViewController.h"

void foo2(void *arg3)
{
    printf("调用");
}

typedef struct
{
    int a;
    void *(*foo)(void *arg1); //函数指针 返回值 是一个 void *的指针
    void (*foo1)(void *arg2); //指针函数 一个指针 指向一个函数
}CFContext;


@interface RunLoopUseAgeViewController ()

@end

@implementation RunLoopUseAgeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configSetting];
}

- (void)configSetting
{
    CFContext c1;
    int b = 8;
    int *c = &b;
    c1.foo1 = &foo2;
    c1.foo1(c);
    c1.foo(c);
    
}



@end

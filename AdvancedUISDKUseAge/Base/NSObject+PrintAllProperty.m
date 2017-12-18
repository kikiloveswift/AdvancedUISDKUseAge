//
//  NSObject+PrintAllProperty.m
//  AdvancedUISDKUseAge
//
//  Created by kong on 2017/12/18.
//  Copyright © 2017年 konglee. All rights reserved.
//

#import "NSObject+PrintAllProperty.h"
#import <objc/runtime.h>

@implementation NSObject (PrintAllProperty)

- (void)printsIvars
{
    NSLog(@"Current Class is %s",class_getName([self class]));
    unsigned int count = 0;
    Ivar *vars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++)
    {
        Ivar _var = *(vars +i);
        NSLog(@"类型:%s,名称:%s",ivar_getTypeEncoding(_var),ivar_getName(_var));
    }
    Class supperCls = [self superclass];
    do
    {
        supperCls = [supperCls superclass];
        NSLog(@"SuperClass is %s",class_getName(supperCls));
        unsigned int count1 = 0;
        Ivar *vars = class_copyIvarList(supperCls, &count1);
        for (int i = 0; i < count1; i++)
        {
            Ivar _var = *(vars +i);
            NSLog(@"类型:%s,名称:%s",ivar_getTypeEncoding(_var),ivar_getName(_var));
        }
    } while (![supperCls isKindOfClass:[NSObject class]]);
    
    
}

@end

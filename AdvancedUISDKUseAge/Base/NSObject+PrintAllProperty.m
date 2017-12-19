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
    Class cls = [self class];
    
    while (![[NSObject class] isKindOfClass:cls]){
        NSLog(@"CurrentCLS is %s",class_getName(cls));
        unsigned int count = 0;
        Ivar *vars = class_copyIvarList(cls, &count);
        for (int i = 0; i < count; i++)
        {
            Ivar _var = *(vars +i);
            NSLog(@"类型:%s,名称:%s",ivar_getTypeEncoding(_var),ivar_getName(_var));
        }
        cls = [cls superclass];
    }
}

- (void)printsProperties
{
    Class cls = [self class];
    while (![[NSObject class] isKindOfClass:cls])
    {
        NSLog(@"CurrentCLS is %s",class_getName(cls));
        unsigned int count = 0;
        objc_property_t *properties = class_copyPropertyList(cls, &count);
        for (int i = 0; i < count; i ++)
        {
            objc_property_t property = properties[i];
            NSLog(@"类型:%sn,属性名称:%s",property_getAttributes(property),property_getName(property));
        }
        cls = [cls superclass];
    }
}

@end

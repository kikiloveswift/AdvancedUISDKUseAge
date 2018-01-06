//
//  UIColor+Hex.h
//  AdvancedUISDKUseAge
//
//  Created by konglee on 2018/1/5.
//  Copyright © 2018年 konglee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)


+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;

+ (UIColor *) colorWithHexString: (NSString *)color;

@end

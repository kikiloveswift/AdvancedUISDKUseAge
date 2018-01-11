//
//  ViewTexture.h
//  AdvancedUISDKUseAge
//
//  Created by kong on 2018/1/10.
//  Copyright © 2018年 konglee. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ViewTexture : NSObject

@property (nonatomic, assign) GLuint name;

@property (nonatomic, assign) GLsizei width;

@property (nonatomic, assign) GLsizei height;

- (void)setUPOpenGL;

- (void)renderView:(UIView *)view;


@end

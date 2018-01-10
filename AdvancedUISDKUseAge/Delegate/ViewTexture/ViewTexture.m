//
//  ViewTexture.m
//  AdvancedUISDKUseAge
//
//  Created by kong on 2018/1/10.
//  Copyright © 2018年 konglee. All rights reserved.
//

#import "ViewTexture.h"
#import <GLKit/GLKit.h>


@interface ViewTexture()
{
    GLuint name;
    GLsizei width;
    GLsizei height;
}

@end

@implementation ViewTexture

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        name = width = height = 0;
    }
    return self;
}

- (void)dealloc
{
    if (name != 0)
    {
        glDeleteTextures(1, &name);
    }
}
- (void)setUPOpenGL
{
    glGenTextures(1, &name);
    glBindTexture((GLenum)GL_TEXTURE_2D, name);
    glTexParameteri((GLenum)GL_TEXTURE_2D, (GLint)GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri((GLenum)GL_TEXTURE_2D, (GLenum)GL_TEXTURE_MAG_FILTER, (GLint)GL_LINEAR);
    glTexParameteri((GLenum)GL_TEXTURE_2D, (GLenum)GL_TEXTURE_WRAP_S, (GLint)GL_CLAMP_TO_EDGE);
    glTexParameteri((GLenum)GL_TEXTURE_2D, (GLenum)GL_TEXTURE_WRAP_T, (GLint)GL_CLAMP_TO_EDGE);
    glBindTexture((GLenum)GL_TEXTURE_2D, 0);
}

- (void)renderView:(UIView *)view
{
    CGFloat scale = [UIScreen mainScreen].scale;
    width = (GLsizei)(view.layer.bounds.size.width * scale);
    height = (GLsizei)(view.layer.bounds.size.height * scale);
    NSMutableArray *textureMarrs = [[NSMutableArray alloc] initWithCapacity:(width * height *4)];
    for (int i = 0; i < textureMarrs.count; i ++)
    {
        textureMarrs[i] = @((GLubyte)0);
    }
    CGColorSpaceRef colorSpace =  CGColorSpaceCreateDeviceRGB();
    void *data = (__bridge void*)textureMarrs;
    
    CGContextRef context = CGBitmapContextCreate(data, (int)width, (int)height, 8, (int)width *4, colorSpace, (uint)kCGImageAlphaPremultipliedLast|(uint)kCGBitmapByteOrder32Big);
    CGContextScaleCTM(context, scale, scale);
    UIGraphicsPushContext(context);
    [view drawViewHierarchyInRect:view.layer.bounds afterScreenUpdates:false];
    UIGraphicsPopContext();
    
    glBindTexture((GLenum)GL_TEXTURE_2D, name);
    glTexImage2D((GLenum)GL_TEXTURE_2D, 0, (GLint)GL_RGBA, width, height, 0, (GLenum)GL_RGBA, (GLenum)GL_UNSIGNED_BYTE, data);
    glBindTexture((GLenum)GL_TEXTURE_2D, 0);
}

@end

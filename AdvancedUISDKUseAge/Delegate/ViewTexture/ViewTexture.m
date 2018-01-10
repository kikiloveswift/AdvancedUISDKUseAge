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

- (void)setUPOpenGL
{
    glGenTextures(1, &name);
    glBindTexture(GL_TEXTURE_2D, name);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    glBindTexture(GL_TEXTURE_2D, 0);
}
@end

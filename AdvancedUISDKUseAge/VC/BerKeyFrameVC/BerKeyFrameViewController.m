//
//  BerKeyFrameViewController.m
//  AdvancedUISDKUseAge
//
//  Created by kong on 2017/12/2.
//  Copyright © 2017年 konglee. All rights reserved.
//

#import "BerKeyFrameViewController.h"

@interface BerKeyFrameViewController ()

@property (nonatomic, strong) CAShapeLayer *shape_IMGLayer;

@end

@implementation BerKeyFrameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUILayer];
}

- (void)initUILayer
{
    UIImage *img = [UIImage imageNamed:@"zlc.jpg"];
    _shape_IMGLayer = [CAShapeLayer layer];
    _shape_IMGLayer.frame = CGRectMake(20, 150, 200, 0);
    _shape_IMGLayer.contents = (__bridge id _Nullable)(img.CGImage);
    [self.view.layer addSublayer:_shape_IMGLayer];
    
}
- (IBAction)beginAnimation:(UIButton *)sender
{
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"height"];
    basicAnimation.toValue = @300;
    basicAnimation.fromValue = @0;
    basicAnimation.duration = 3.0f;
    [_shape_IMGLayer addAnimation:basicAnimation forKey:@"animation"];
    
    
}

- (IBAction)failureAnimation:(id)sender
{
    
}

- (IBAction)stopAnimation:(UIButton *)sender
{
    
}




@end

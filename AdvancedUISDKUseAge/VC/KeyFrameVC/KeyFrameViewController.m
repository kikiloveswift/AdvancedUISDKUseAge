//
//  KeyFrameViewController.m
//  AdvancedUISDKUseAge
//
//  Created by kong on 2017/11/24.
//  Copyright © 2017年 konglee. All rights reserved.
//

#import "KeyFrameViewController.h"

@interface KeyFrameViewController ()

@property (nonatomic, strong) CAShapeLayer *layer;

@property (nonatomic, strong) UIBezierPath *bpath;
@end

@implementation KeyFrameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"KeyFrame";
    [self initUI];
}

- (void)initUI
{
    _layer = [CAShapeLayer layer];
    _bpath = [UIBezierPath bezierPath];
    CGPoint p1 = CGPointMake(20, 400);
    [_bpath moveToPoint:p1];

    CGPoint p2 = CGPointMake(220, 400);
    [_bpath addLineToPoint:p2];

    _layer.lineWidth = 5.0f;
    _layer.fillColor = [UIColor clearColor].CGColor;
    _layer.strokeColor = [UIColor redColor].CGColor;

    _layer.path = _bpath.CGPath;
    [self.view.layer addSublayer:_layer];

}

- (IBAction)beginLoading:(UIButton *)sender
{
    [_bpath addArcWithCenter:CGPointMake(220, 300) radius:100 startAngle:0 endAngle:359 clockwise:YES];
    
    _layer.path = _bpath.CGPath;
    
}



@end

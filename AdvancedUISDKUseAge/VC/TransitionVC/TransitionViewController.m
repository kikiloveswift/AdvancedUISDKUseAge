//
//  TransitionViewController.m
//  AdvancedUISDKUseAge
//
//  Created by kong on 2017/12/25.
//  Copyright © 2017年 konglee. All rights reserved.
//

#import "TransitionViewController.h"

@interface TransitionViewController ()

@end

@implementation TransitionViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.userInteractionEnabled = YES;
    [self initUI];
}


- (void)initUI
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((KWidth - 200)/2, 100, 200, 50)];
    label.text = @"HELLO WORLD";
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:25];
    [self.view addSubview:label];
}


@end

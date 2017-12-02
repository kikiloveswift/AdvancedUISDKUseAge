//
//  Item0ViewController.m
//  AdvancedUISDKUseAge
//
//  Created by konglee on 2017/11/16.
//  Copyright © 2017年 konglee. All rights reserved.
//

#import "Item0ViewController.h"

@interface Item0ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mTableView;

@property (nonatomic, copy) NSArray *dataArr;

@end

static NSString *identifyItm0 = @"identifyItm0";

@implementation Item0ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initData];
    [self initUI];
}

- (void)initData
{
    _dataArr = @[@"DynamicViewController",@"KeyFrameViewController",@"BerKeyFrameViewController"];
}
- (void)initUI
{
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight -49) style:UITableViewStylePlain];
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.rowHeight = 50.0f;
    _mTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_mTableView];
}

#pragma Mark -UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [UIView new];
    v.frame = CGRectZero;
    return v;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *v = [UIView new];
    v.frame = CGRectZero;
    return v;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifyItm0];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifyItm0];
    }
    cell.textLabel.text = _dataArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *clsStr = _dataArr[indexPath.row];
    Class CLS = NSClassFromString(clsStr);
    id vc = [CLS new];
    if ([vc isKindOfClass:[UIViewController class]])
    {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end

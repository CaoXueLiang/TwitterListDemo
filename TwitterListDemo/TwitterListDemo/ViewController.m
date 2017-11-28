//
//  ViewController.m
//  TwitterListDemo
//
//  Created by 曹学亮 on 2017/11/27.
//  Copyright © 2017年 Cao Xueliang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) UITableView *myTable;
@end

@implementation ViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationItem.title = @"首页";
}


@end

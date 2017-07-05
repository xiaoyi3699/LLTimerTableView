//
//  ViewController.m
//  LLTimerTableView
//
//  Created by WangZhaomeng on 2017/7/5.
//  Copyright © 2017年 MaoChao Network Co. Ltd. All rights reserved.
//

#import "ViewController.h"
#import "LLTimerViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 60, 30);
    btn.backgroundColor = [UIColor blackColor];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5;
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.center = self.view.center;
}

- (void)btnClick:(UIButton *)btn {
    LLTimerViewController *timerVC = [[LLTimerViewController alloc] init];
    [self presentViewController:timerVC animated:YES completion:nil];
}

@end

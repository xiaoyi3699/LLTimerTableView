//
//  LLTimerViewController.m
//  LLTimerTableView
//
//  Created by WangZhaomeng on 2017/7/5.
//  Copyright © 2017年 MaoChao Network Co. Ltd. All rights reserved.
//

#import "LLTimerViewController.h"
#import "LLTimerTableViewCell.h"

@interface LLTimerViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray *times; //存放原始数据
@property (nonatomic, assign) CFAbsoluteTime start;  //刷新数据时的时间

@end

@implementation LLTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _times = [NSMutableArray arrayWithCapacity:20];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:view];
    
    CGFloat spacing = ([UIScreen mainScreen].bounds.size.width-200);
    NSArray *titles = @[@"返回",@"刷新"];
    for (NSInteger i = 0; i < 2; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.frame = CGRectMake(40+i%2*(spacing+60), 28, 60, 30);
        btn.backgroundColor = [UIColor blackColor];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 5;
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
    }
    
    CGRect rect = self.view.bounds;
    rect.origin.y = 64;
    rect.size.height -= 64;
    _tableView = [[UITableView alloc] initWithFrame:rect];
    _tableView.tag = 99;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    
    [self ll_reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _times.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LLTimerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLTimerTableViewCell"];
    if (cell == nil) {
        cell = [[LLTimerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LLTimerTableViewCell"];
    }
    
    NSInteger second = [_times[indexPath.row] integerValue] - round(CFAbsoluteTimeGetCurrent()-_start);
    [cell setConfigWithSecond:second];
    return cell;
}

- (void)btnClick:(UIButton *)btn {
    if (btn.tag == 0) {//返回
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else {//刷新
        [self ll_reloadData];
    }
}

- (void)ll_reloadData {
    
    //每一次刷新数据时，重置初始时间
    _start = CFAbsoluteTimeGetCurrent();
    [_times removeAllObjects];
    for (NSInteger i = 0; i < 20; i ++) {
        NSInteger time = arc4random()%3600;
        [_times addObject:@(time)];
    }
    [_tableView reloadData];
}

- (void)dealloc {
    NSLog(@"释放");
}

@end

//
//  LLTimerTableViewCell.m
//  LLTimerTableView
//
//  Created by WangZhaomeng on 2017/7/5.
//  Copyright © 2017年 MaoChao Network Co. Ltd. All rights reserved.
//

#import "LLTimerTableViewCell.h"

@implementation LLTimerTableViewCell{
    NSTimer   *_timer;
    NSInteger _second;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerRun:) userInfo:nil repeats:YES];
        //将定时器加入NSRunLoop，保证滑动表时，UI依然刷新
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return self;
}

- (void)setConfigWithSecond:(NSInteger)second {
    _second = second;
    if (_second > 0) {
        self.textLabel.text = [self ll_timeWithSecond:_second];
    }
    else {
        self.textLabel.text = @"00:00:00";
    }
}

- (void)timerRun:(NSTimer *)timer {
    if (_second > 0) {
        self.textLabel.text = [self ll_timeWithSecond:_second];
        _second -= 1;
    }
    else {
        self.textLabel.text = @"00:00:00";
    }
}

//重写父类方法，保证定时器被销毁
- (void)removeFromSuperview {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    [super removeFromSuperview];
}

//将秒数转换为字符串格式
- (NSString *)ll_timeWithSecond:(NSInteger)second
{
    NSString *time;
    if (second < 60) {
        time = [NSString stringWithFormat:@"00:00:%02ld",(long)second];
    }
    else {
        if (second < 3600) {
            time = [NSString stringWithFormat:@"00:%02ld:%02ld",second/60,second%60];
        }
        else {
            time = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",second/3600,(second-second/3600*3600)/60,second%60];
        }
    }
    return time;
}

- (void)dealloc {
    NSLog(@"cell释放");
}

@end

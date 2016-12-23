//
//  HSCalendarHeadView.m
//  签到日历
//
//  Created by 石冬冬 on 16/12/21.
//  Copyright © 2016年 sdd. All rights reserved.
//

#import "HSCalendarHeadView.h"
#import "HSCalendarManager.h"
@implementation HSCalendarHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void) setupUI {
    // 显示年月
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
    topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:topView];
    
    UILabel *yearAndMonthLab = [[UILabel alloc] init];
    NSInteger year = [[HSCalendarManager shareManager] year:[NSDate date]];
    NSInteger month = [[HSCalendarManager shareManager] month:[NSDate date]];
    yearAndMonthLab.text = [NSString stringWithFormat:@"%ld年%ld月",year,month];
    yearAndMonthLab.frame = CGRectMake(10, 10, 100, 30);
    yearAndMonthLab.textColor = [UIColor grayColor];
    yearAndMonthLab.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:yearAndMonthLab];
    
    
    UILabel *remindLab = [[UILabel alloc] init];
    remindLab.text = @"签到提醒";
    remindLab.textColor = [UIColor darkGrayColor];
    remindLab.frame = CGRectMake(self.frame.size.width - 155, 10, 80, 30);
    [topView addSubview:remindLab];
    UISwitch *customSwitch = [[UISwitch alloc] init];
    customSwitch.on = YES;
    customSwitch.frame = CGRectMake(self.frame.size.width - 65, 7.5, 60, 25);
    [topView addSubview:customSwitch];
    
    UIView *bootomView = [[UIView alloc] initWithFrame:CGRectMake(-1, CGRectGetMaxY(topView.frame), self.frame.size.width + 1, 40)];
    bootomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bootomView];
    NSArray *array = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    CGFloat labH = 30;
    CGFloat labW = self.frame.size.width/7;
    CGFloat labY = 5;
    for (int i = 0; i < array.count; i ++ ) {
        UILabel *label = [[UILabel alloc] init];
        CGFloat labX = i * labW;
        label.frame = CGRectMake(labX, labY, labW, labH);
        label.text = array[i];
        label.textColor = [UIColor darkGrayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor whiteColor];
        [bootomView addSubview:label];
    }
    
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(10, 50, self.frame.size.width - 20, 1)];
    topLine.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
    [self addSubview:topLine];
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(10, 90, self.frame.size.width - 20, 1)];
    bottomLine.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
    [self addSubview:bottomLine];
}

@end

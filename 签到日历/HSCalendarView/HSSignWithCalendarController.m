//
//  HSSignWithCalendarController.m
//  签到日历
//
//  Created by 石冬冬 on 16/12/22.
//  Copyright © 2016年 sdd. All rights reserved.
//

#import "HSSignWithCalendarController.h"
#import "HSCalendarView.h"
#import "HSSignAlertView.h"
@interface HSSignWithCalendarController ()
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIButton *signButton;
@property (nonatomic, strong) HSSignAlertView *signAlertView;
@end

@implementation HSSignWithCalendarController
- (HSSignAlertView *)signAlertView {
    if (_signAlertView == nil) {
        _signAlertView = [[HSSignAlertView alloc] init];
        _signAlertView.frame = self.view.bounds;
    }
    return  _signAlertView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.signButton.layer.cornerRadius = 17.5;
    self.signButton.layer.masksToBounds = YES;
    
    self.detailLabel.text = @"签到成功，今日已领取5积分\n已获得积分：80积分";
    
    CGFloat height = 110+(self.view.frame.size.width/7*5);
    HSCalendarView *calendarView = [[HSCalendarView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - height, [UIScreen mainScreen].bounds.size.width, height)];
    [self.view addSubview:calendarView];
    
}


- (IBAction)signButtonClick:(UIButton *)sender {
    [self.signAlertView showSignAlertView];
}

@end

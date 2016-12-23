//
//  HSCalendarCell.m
//  签到日历
//
//  Created by 石冬冬 on 16/12/21.
//  Copyright © 2016年 sdd. All rights reserved.
//

#import "HSCalendarCell.h"
#import "HSCalendarModel.h"
@implementation HSCalendarCell
- (UIButton *)contentBtn {
    if (_contentBtn == nil) {
        _contentBtn = [[UIButton alloc] init];
        _contentBtn.frame = CGRectMake(8, 8, self.frame.size.width - 16, self.frame.size.height - 16);
        _contentBtn.layer.cornerRadius = (self.frame.size.width-16)/2;
        [_contentBtn setBackgroundColor:[UIColor whiteColor]];
        [_contentBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    return _contentBtn;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return  self;
}
- (void) setupUI {
    [self.contentView addSubview:self.contentBtn];
}
- (void)setCalendarModel:(HSCalendarModel *)calendarModel {
    _calendarModel = calendarModel;
    [self.contentBtn setTitle:calendarModel.day forState:UIControlStateNormal];
    if (calendarModel.isSigned) {
        [self.contentBtn setBackgroundImage:[UIImage imageNamed:@"coin1"] forState:UIControlStateNormal];
        [self.contentBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    if (calendarModel.istoday) {
        [self.contentBtn setBackgroundColor:[UIColor redColor]];
        [self.contentBtn setBackgroundImage:nil forState:UIControlStateNormal];
        [self.contentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}
@end

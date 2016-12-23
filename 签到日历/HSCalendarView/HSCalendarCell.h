//
//  HSCalendarCell.h
//  签到日历
//
//  Created by 石冬冬 on 16/12/21.
//  Copyright © 2016年 sdd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HSCalendarModel;
@interface HSCalendarCell : UICollectionViewCell
@property (nonatomic, strong) UIButton *contentBtn;
@property (nonatomic, strong) HSCalendarModel *calendarModel;
@end

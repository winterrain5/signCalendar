//
//  HSCalendarContentView.m
//  签到日历
//
//  Created by 石冬冬 on 16/12/21.
//  Copyright © 2016年 sdd. All rights reserved.
//

#import "HSCalendarView.h"
#import "HSCalendarViewFlowLayout.h"
#import "HSCalendarCell.h"
#import "HSCalendarHeadView.h"
#import "HSCalendarManager.h"
#import "HSCalendarModel.h"
@interface HSCalendarView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong,nonatomic) UICollectionView *collectionView;
@property (nonatomic, strong) HSCalendarHeadView *headView;
//日历控件天数
@property (nonatomic,strong)NSMutableArray * daysArray;

//时间
@property (nonatomic,strong)NSMutableString * date ;
@end
@implementation HSCalendarView
#pragma mark ----- 懒加载

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        HSCalendarViewFlowLayout *flowLayout = [[HSCalendarViewFlowLayout alloc] init];
        CGRect frame = CGRectMake(0, 90, self.frame.size.width, self.frame.size.width/7 * (self.daysArray.count/7));
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        [_collectionView registerClass:[HSCalendarCell class] forCellWithReuseIdentifier:@"calendarCell"];
    }
    return _collectionView;
}
- (HSCalendarHeadView *)headView {
    if (_headView == nil) {
        _headView = [[HSCalendarHeadView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 90)];
        
    }
    return _headView;
}
#pragma mark ----- 初始化
- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void) setupUI {
    [self setupDate];
    [self setupMonthDays];
    [self addSubview:self.collectionView];
    [self addSubview:self.headView];
    
}
/**
 *  初始化当前时间
 */
- (void) setupDate {
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSString * date = [formatter stringFromDate:[NSDate date]];
    
    self.date = [NSMutableString stringWithString:date];
}
/**
 *   计算选定月份天数
 */
- (void) setupMonthDays {
    _daysArray = [NSMutableArray array];

    NSInteger days = [[HSCalendarManager shareManager] totaldaysInThisMonth:[NSDate date] with:self.date];
    NSInteger week  = [[HSCalendarManager shareManager] firstWeekdayInThisMonth:[NSDate date] with:self.date];
    NSInteger today = [[HSCalendarManager shareManager] day:[NSDate date]];
    NSInteger weeks;
    if ((days + week) % 7 > 0)
    {
        weeks = (days + week)/7 + 1 ;
    }
    else
    {
        weeks = (days + week)/7 ;
    }
    
    for (int i  = 0; i < (days + week); i ++)
    {
        HSCalendarModel *calendarModel = [[HSCalendarModel alloc] init];
        if ( i - week < 0)
        {
            calendarModel.day = @"";
            [_daysArray addObject:calendarModel];
        }
        else
        {
            calendarModel.day = [NSString stringWithFormat:@"%ld",i+1-week];
            if (i-week+1 == today) {
                calendarModel.istoday = YES;
                
            }
            if (i-week+1 < today) {
                calendarModel.isSigned = YES;
            } else {
                calendarModel.isSigned = NO;
            }
            [_daysArray addObject:calendarModel];
        }
        
    }
    
    [self.collectionView reloadData];
    
    
    NSLog(@"这个月有%ld天 , 第一天是%ld\ndayArray=%@",days,week,_daysArray);

}
#pragma mark -----UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.daysArray.count;
}
- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *rid=@"calendarCell";
    HSCalendarCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:rid forIndexPath:indexPath];
    if(cell==nil){
        cell= [[HSCalendarCell alloc] init];
    }
    HSCalendarModel *model = self.daysArray[indexPath.item];
    cell.calendarModel = model;
    return cell;
}


@end

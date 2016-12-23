//
//  HSCalendarManager.h
//  签到日历
//
//  Created by 石冬冬 on 16/12/22.
//  Copyright © 2016年 sdd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSCalendarManager : NSObject

+ (instancetype) shareManager;

/**
 *  获取当前日
 */
- (NSInteger)day:(NSDate *)date;
/**
 *  获取当前月份
 */
- (NSInteger)month:(NSDate *)date;
/**
 *  获取当前年份
 */
- (NSInteger)year:(NSDate *)date;


//比较时间前后
-(int)compareOneDay:(NSString *)oneDay withAnotherDay:(NSString *)anotherDay;

//计算日期提前或延后
-(NSString*)dateWithDays:(NSInteger)days;


-(NSString*)dateWithDays:(NSInteger)days frome:(NSString*)date;

//计算给定月份天数

- (NSInteger)totaldaysInThisMonth:(NSDate *)date with:(NSString*)datestr;


//计算给定月份第一天周几
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date with:(NSString*)datestr;

@end

//
//  HSCalendarModel.h
//  签到日历
//
//  Created by 石冬冬 on 16/12/22.
//  Copyright © 2016年 sdd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSCalendarModel : NSObject
@property (nonatomic, copy) NSString *day;
@property (nonatomic, assign) BOOL istoday;
@property (nonatomic, assign) BOOL isSigned;

@end

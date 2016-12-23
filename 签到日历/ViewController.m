//
//  ViewController.m
//  签到日历
//
//  Created by 石冬冬 on 16/12/21.
//  Copyright © 2016年 sdd. All rights reserved.
//

#import "ViewController.h"
#import "HSCalendarView.h"
#import "HSSignWithCalendarController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    HSCalendarView *calendarView = [[HSCalendarView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 400)];
//    calendarView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:calendarView];
    
    HSSignWithCalendarController *controller = [[HSSignWithCalendarController alloc] init];
    [self addChildViewController:controller];
    
    controller.view.frame = self.view.bounds;
    [self.view addSubview:controller.view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

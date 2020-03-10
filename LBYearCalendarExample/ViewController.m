//
//  ViewController.m
//  LBYearCalendarExample
//
//  Created by 刘彬 on 2019/11/29.
//  Copyright © 2019 刘彬. All rights reserved.
//

#import "ViewController.h"
#import "LBYearCalendarView.h"

@interface ViewController ()<LBYearCalendarDelegate>

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [LBCalenderConfig shareInstanse].selectionFillColor = [UIColor magentaColor];
    [LBCalenderConfig shareInstanse].eventIndicatorColor = [UIColor magentaColor];
    [LBCalenderConfig shareInstanse].selectionDates = @[[NSDate date]];
    [LBCalenderConfig shareInstanse].eventsDates = @[[[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitDay value:-1 toDate:[NSDate date] options:0],[[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitDay value:1 toDate:[NSDate date] options:0]];
    
    LBYearCalendarView *yearCalendarView = [[LBYearCalendarView alloc] initWithFrame:CGRectMake(0, 80, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-80)];
    yearCalendarView.lb_delegate = self;
    yearCalendarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:yearCalendarView];
    
}

#pragma mark LBYearCalendarDelegate
-(void)calendarView:(LBYearCalendarView *)yearCalendarView didSelectDate:(NSDate *)date{
    NSLog(@"%@",date);
    NSMutableArray<NSDate *> *selectionDates = [LBCalenderConfig shareInstanse].selectionDates.mutableCopy;
    [selectionDates addObject:date];
    [LBCalenderConfig shareInstanse].selectionDates = selectionDates;
}

@end

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
@property (nonatomic,strong)NSDateFormatter *yearDateFormatter;

@end

@implementation ViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        _yearDateFormatter = [[NSDateFormatter alloc] init];
        _yearDateFormatter.dateFormat = @"yyyy";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [LBCalenderConfig shareInstanse].selectionColor = [UIColor magentaColor];
    [LBCalenderConfig shareInstanse].eventIndicatorColor = [UIColor magentaColor];
    [LBCalenderConfig shareInstanse].selectionDates = @[[NSDate date]];
    [LBCalenderConfig shareInstanse].eventsDates = @[[[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitDay value:-1 toDate:[NSDate date] options:0],[[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitDay value:1 toDate:[NSDate date] options:0]];
    
    LBYearCalendarView *yearCalendarView = [[LBYearCalendarView alloc] initWithFrame:self.view.bounds delegate:self];
    [self.view addSubview:yearCalendarView];
    
    
    yearCalendarView.calenderYearCollectionView.contentOffset = CGPointMake(([_yearDateFormatter stringFromDate:[NSDate date]].intValue-[_yearDateFormatter stringFromDate:yearCalendarView.startYear].intValue)*CGRectGetWidth(yearCalendarView.calenderYearCollectionView.frame), 0);

}

#pragma mark LBYearCalendarDelegate
-(void)calendarView:(LBYearCalendarView *)yearCalendarView didSelectDate:(NSDate *)date{
    NSLog(@"%@",date);
    NSMutableArray<NSDate *> *selectionDates = [LBCalenderConfig shareInstanse].selectionDates.mutableCopy;
    [selectionDates addObject:date];
    [LBCalenderConfig shareInstanse].selectionDates = selectionDates;
}
@end

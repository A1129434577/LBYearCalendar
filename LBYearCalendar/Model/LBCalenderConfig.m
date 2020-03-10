//
//  LBCalenderShareData.m
//  test
//
//  Created by 刘彬 on 2019/11/23.
//  Copyright © 2019 刘彬. All rights reserved.
//

#import "LBCalenderConfig.h"
@interface LBCalenderConfig ()
@property (nonatomic,strong)NSCalendar *calendar;
@end
@implementation LBCalenderConfig
+(LBCalenderConfig *)shareInstanse{
    static LBCalenderConfig *shareData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareData = [[LBCalenderConfig alloc] init];
        shareData.calendar = [NSCalendar currentCalendar];
        
        shareData.selectionDates = @[[NSDate date]];
        
        shareData.monthFont = [UIFont systemFontOfSize:20];
        shareData.dayFont = [UIFont systemFontOfSize:10];
        
        shareData.monthColor = [UIColor blackColor];
        shareData.selectionMonthColor = [UIColor magentaColor];
        shareData.dayColor = [UIColor blackColor];
        shareData.daySelectionColor = [UIColor whiteColor];
        shareData.selectionFillColor = [UIColor magentaColor];
        shareData.eventIndicatorColor = [UIColor magentaColor];
    });
    return shareData;
}

-(void)setSelectionDates:(NSArray<NSDate *> *)selectionDates{
    NSMutableArray<NSDate *> *newSelectionDates = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    [selectionDates enumerateObjectsUsingBlock:^(NSDate * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj = [weakSelf.calendar dateBySettingHour:0 minute:0 second:0 ofDate:obj options:0];
        [newSelectionDates addObject:obj];
    }];
    _selectionDates = newSelectionDates;
}

-(void)setEventsDates:(NSArray<NSDate *> *)eventsDates{
    NSMutableArray<NSDate *> *newEventsDates = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    [eventsDates enumerateObjectsUsingBlock:^(NSDate * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj = [weakSelf.calendar dateBySettingHour:0 minute:0 second:0 ofDate:obj options:0];
        [newEventsDates addObject:obj];
    }];
    _eventsDates = newEventsDates;
}

@end

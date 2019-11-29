//
//  LBCalenderShareData.m
//  test
//
//  Created by 刘彬 on 2019/11/23.
//  Copyright © 2019 刘彬. All rights reserved.
//

#import "LBCalenderConfig.h"

@implementation LBCalenderConfig
+(LBCalenderConfig *)shareInstanse{
    static LBCalenderConfig *shareData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareData = [[LBCalenderConfig alloc] init];
        shareData.calendar = [NSCalendar currentCalendar];
        shareData.calendar.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
        shareData.selectionDates = @[[NSDate date]];
        
        shareData.monthFont = [UIFont systemFontOfSize:20];
        shareData.dayFont = [UIFont systemFontOfSize:10];
        
        shareData.monthColor = [UIColor blackColor];
        shareData.dayColor = [UIColor blackColor];
        shareData.daySelectionColor = [UIColor whiteColor];
        shareData.selectionColor = [UIColor magentaColor];
        shareData.eventIndicatorColor = [UIColor magentaColor];
    });
    return shareData;
}



@end

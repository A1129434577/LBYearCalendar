//
//  LBYearCalendarView.h
//  test
//
//  Created by 刘彬 on 2019/11/22.
//  Copyright © 2019 刘彬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBCalenderConfig.h"


NS_ASSUME_NONNULL_BEGIN

@class LBYearCalendarView;
@protocol LBYearCalendarDelegate <UIScrollViewDelegate>
@optional
-(void)calendarView:(LBYearCalendarView *)yearCalendarView didSelectDate:(NSDate *)date;
@end

@interface LBYearCalendarView : UICollectionView

@property (nonatomic,weak)id<LBYearCalendarDelegate> lb_delegate;

@property (nonatomic,strong)NSDate *startYear;
@property (nonatomic,strong)NSDate *endYear;

@property (nonatomic,strong)NSDate *currentPage;
@end

NS_ASSUME_NONNULL_END

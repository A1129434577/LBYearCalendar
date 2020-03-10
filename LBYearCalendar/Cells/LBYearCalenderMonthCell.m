//
//  FCCalenderMonthCell.m
//  fachan
//
//  Created by 刘彬 on 2019/11/22.
//  Copyright © 2019 Swartz. All rights reserved.
//

#import "LBYearCalenderMonthCell.h"
#import "LBCalenderConfig.h"
#import "LBYearCalendarDayCell.h"
#import "LBYearCalendarView.h"
#import "LBCalendarTextLayer.h"

#define ONE_WEEK_DAYS 7
#define WEEK_LINES 6

@interface LBYearCalenderMonthCell ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong)NSCalendar *calendar;
@property (nonatomic,assign)NSUInteger monthFirstDayWeekIndex;
@property (nonatomic,strong)LBCalendarTextLayer *monthTitleLayer;
@property (nonatomic,strong)UICollectionView *oneMonthCollectionView;
@property (nonatomic,strong)NSDateFormatter *monthFormatter;
@end
@implementation LBYearCalenderMonthCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _calendar = [NSCalendar currentCalendar];
        
        _monthFormatter = [[NSDateFormatter alloc] init];
        _monthFormatter.dateFormat = @"M月";
        _monthTitleLayer = [[LBCalendarTextLayer alloc] init];
        _monthTitleLayer.frame = CGRectMake(10, 0, CGRectGetWidth(frame)-10*2, 30);
        _monthTitleLayer.textColor = [LBCalenderConfig shareInstanse].monthColor;
        _monthTitleLayer.font = [LBCalenderConfig shareInstanse].monthFont;
        [self.layer addSublayer:_monthTitleLayer];
        [_monthTitleLayer setNeedsDisplay];
        
        CGRect monthCollectionViewFrame = CGRectMake(CGRectGetMinX(_monthTitleLayer.frame), CGRectGetMaxY(_monthTitleLayer.frame), CGRectGetWidth(_monthTitleLayer.frame), CGRectGetHeight(frame)- CGRectGetMaxY(_monthTitleLayer.frame));
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(CGRectGetWidth(monthCollectionViewFrame)/ONE_WEEK_DAYS, CGRectGetHeight(monthCollectionViewFrame)/WEEK_LINES);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;

        UICollectionView *oneMonthCollectionView = [[UICollectionView alloc] initWithFrame:monthCollectionViewFrame collectionViewLayout:layout];
        oneMonthCollectionView.backgroundColor = [UIColor clearColor];
        oneMonthCollectionView.showsHorizontalScrollIndicator = NO;
        oneMonthCollectionView.scrollEnabled = NO;
        oneMonthCollectionView.dataSource = self;
        oneMonthCollectionView.delegate = self;
        [oneMonthCollectionView registerClass:[LBYearCalendarDayCell class] forCellWithReuseIdentifier:NSStringFromClass(LBYearCalendarDayCell.self)];
        [self addSubview:oneMonthCollectionView];
        _oneMonthCollectionView = oneMonthCollectionView;
    }
    return self;
}
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return WEEK_LINES*ONE_WEEK_DAYS;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifir = NSStringFromClass(LBYearCalendarDayCell.self);
    LBYearCalendarDayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifir forIndexPath:indexPath];
    
    NSUInteger startIndex = _monthFirstDayWeekIndex-1;
    if (indexPath.row >= startIndex) {
        
        NSDate *date = [_calendar dateByAddingUnit:NSCalendarUnitDay value:indexPath.row-startIndex toDate:_month options:0];
        if ([[_monthFormatter stringFromDate:date] isEqualToString:[_monthFormatter stringFromDate:_month]]) {
            cell.date = date;
        }else{//下个月的不显示
            cell.date = nil;
        }
    }else{//上个月的不显示
        cell.date = nil;
    }
    return cell;
}

-(void)setMonth:(NSDate *)month{
    _month = month;
    _monthFirstDayWeekIndex = [_calendar component:NSCalendarUnitWeekday fromDate:month];
    
    _monthTitleLayer.text = [_monthFormatter stringFromDate:month];
    
    NSDateFormatter *yearMonthFormatter = [[NSDateFormatter alloc] init];
    yearMonthFormatter.dateFormat = @"yyyyMM";
    
    if ([[yearMonthFormatter stringFromDate:month] isEqualToString:[yearMonthFormatter stringFromDate:[NSDate date]]]) {
        _monthTitleLayer.textColor = [LBCalenderConfig shareInstanse].selectionMonthColor;
    }else{
        _monthTitleLayer.textColor = [LBCalenderConfig shareInstanse].monthColor;
    }
    [_oneMonthCollectionView reloadData];
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LBYearCalendarDayCell *cell = (LBYearCalendarDayCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (cell.date) {
        LBYearCalendarView *yearCalendarView = (LBYearCalendarView *)cell.nextResponder;
        while (![yearCalendarView isKindOfClass:LBYearCalendarView.self]) {
            yearCalendarView = (LBYearCalendarView *)yearCalendarView.nextResponder;
        }
        if ([yearCalendarView.lb_delegate respondsToSelector:@selector(calendarView: didSelectDate:)]) {
            [yearCalendarView.lb_delegate calendarView:yearCalendarView didSelectDate:cell.date];
        }
    }
    
    
}
@end

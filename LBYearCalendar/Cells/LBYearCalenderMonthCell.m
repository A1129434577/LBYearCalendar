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

#define ONE_WEEK_DAYS 7
#define WEEK_LINES 6

@interface LBYearCalenderMonthCell ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong)UILabel *monthTitleLabel;
@property (nonatomic,strong)UICollectionView *oneMonthCollectionView;
@property (nonatomic,strong)NSDateFormatter *monthFormatter;
@end
@implementation LBYearCalenderMonthCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _monthFormatter = [[NSDateFormatter alloc] init];
        _monthFormatter.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
        _monthFormatter.dateFormat = @"MM月";
        
        _monthTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, CGRectGetWidth(frame)-10*2, 30)];
        _monthTitleLabel.textColor = [UIColor blackColor];
        _monthTitleLabel.font = [LBCalenderConfig shareInstanse].monthFont;
        [self addSubview:_monthTitleLabel];
        
        CGRect monthCollectionViewFrame = CGRectMake(CGRectGetMinX(_monthTitleLabel.frame), CGRectGetMaxY(_monthTitleLabel.frame), CGRectGetWidth(_monthTitleLabel.frame), CGRectGetHeight(frame)- CGRectGetMaxY(_monthTitleLabel.frame));
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(CGRectGetWidth(monthCollectionViewFrame)/ONE_WEEK_DAYS, CGRectGetHeight(monthCollectionViewFrame)/WEEK_LINES);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;

        UICollectionView *oneMonthCollectionView = [[UICollectionView alloc] initWithFrame:monthCollectionViewFrame collectionViewLayout:layout];
        oneMonthCollectionView.backgroundColor = [UIColor clearColor];
        oneMonthCollectionView.showsHorizontalScrollIndicator = NO;
        oneMonthCollectionView.pagingEnabled = YES;
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
    cell.date = nil;
    
    NSUInteger weekDay = [[LBCalenderConfig shareInstanse].calendar component:NSCalendarUnitWeekday fromDate:_month];
    NSUInteger startIndex = weekDay-1;
    if (indexPath.row >= startIndex) {
        NSDate *date = [[LBCalenderConfig shareInstanse].calendar dateByAddingUnit:NSCalendarUnitDay value:indexPath.row-startIndex toDate:_month options:0];
        if ([[_monthFormatter stringFromDate:date] isEqualToString:[_monthFormatter stringFromDate:_month]]) {
            cell.date = date;
        }
    }
    return cell;
}

-(void)setMonth:(NSDate *)month{
    _month = month;
    _monthTitleLabel.text = [_monthFormatter stringFromDate:month];
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

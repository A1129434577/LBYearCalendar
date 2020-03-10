//
//  LBYearCalendarDayCell.m
//  test
//
//  Created by 刘彬 on 2019/11/22.
//  Copyright © 2019 刘彬. All rights reserved.
//

#import "LBYearCalendarDayCell.h"
#import "LBCalendarTextLayer.h"
#import "LBDaySelectionLayer.h"
#import "LBEventIndicatorLayer.h"
#import "LBCalenderConfig.h"

@interface LBYearCalendarDayCell ()
@property (nonatomic,strong)NSCalendar *calendar;
@property (nonatomic,strong)LBCalendarTextLayer *dayTitleLayer;
@property (nonatomic,strong)LBDaySelectionLayer *selectionLayer;
@property (nonatomic,strong)LBEventIndicatorLayer *eventIndicator;
@property (nonatomic,strong)NSDateFormatter *dayFromatter;
@end

@implementation LBYearCalendarDayCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _dayFromatter = [[NSDateFormatter alloc] init];
        _dayFromatter.dateFormat = @"d";
        
        UILabel *fontLabel = [[UILabel alloc] init];
        fontLabel.font = [LBCalenderConfig shareInstanse].dayFont;
        fontLabel.text = @"00";
        [fontLabel sizeToFit];
        
        CGFloat side = MAX(CGRectGetHeight(fontLabel.bounds), CGRectGetWidth(fontLabel.bounds));
        
        _selectionLayer = [[LBDaySelectionLayer alloc] init];
        _selectionLayer.frame = CGRectMake((CGRectGetWidth(frame)-side)/2, (CGRectGetHeight(frame)-side)/2, side, side);
        _selectionLayer.fillColor = [LBCalenderConfig shareInstanse].selectionFillColor;
        [self.layer addSublayer:_selectionLayer];
        
        _dayTitleLayer = [[LBCalendarTextLayer alloc] init];
        _dayTitleLayer.frame = self.bounds;
        _dayTitleLayer.alignment = NSTextAlignmentCenter;
        _dayTitleLayer.textColor = [LBCalenderConfig shareInstanse].dayColor;
        _dayTitleLayer.font = [LBCalenderConfig shareInstanse].dayFont;
        [self.layer addSublayer:_dayTitleLayer];
        
        _eventIndicator = [[LBEventIndicatorLayer alloc] init];
        _eventIndicator.frame = CGRectMake((CGRectGetWidth(frame)-CGRectGetWidth(_selectionLayer.frame)/2)/2, CGRectGetMaxY(_selectionLayer.frame)+2.5, 6, 1);
        _eventIndicator.fillColor = [LBCalenderConfig shareInstanse].eventIndicatorColor;
        [self.layer addSublayer:_eventIndicator];
        
        [[LBCalenderConfig shareInstanse] addObserver:self forKeyPath:NSStringFromSelector(@selector(selectionDates)) options:NSKeyValueObservingOptionNew context:nil];
        [[LBCalenderConfig shareInstanse] addObserver:self forKeyPath:NSStringFromSelector(@selector(eventsDates)) options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}
-(void)setDate:(NSDate *)date{
    if (![_date isEqualToDate:date]) {
        _date = date;
        if (date) {
            _dayTitleLayer.hidden = NO;
            _dayTitleLayer.text = [_dayFromatter stringFromDate:date];
            
            [self observeValueForKeyPath:NSStringFromSelector(@selector(selectionDates)) ofObject:[LBCalenderConfig shareInstanse] change:nil context:nil];
            [self observeValueForKeyPath:NSStringFromSelector(@selector(eventsDates)) ofObject:[LBCalenderConfig shareInstanse] change:nil context:nil];
        }else{
            _dayTitleLayer.hidden = YES;
            _selectionLayer.hidden = YES;
            _eventIndicator.hidden = YES;
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(selectionDates))]) {
        _selectionLayer.hidden = YES;
        _dayTitleLayer.textColor = [LBCalenderConfig shareInstanse].dayColor;
        
        __weak typeof(self) weakSelf = self;
        [[LBCalenderConfig shareInstanse].selectionDates enumerateObjectsUsingBlock:^(NSDate * _Nonnull selectionDate, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([selectionDate isEqualToDate:weakSelf.date]) {
                weakSelf.selectionLayer.hidden = NO;
                weakSelf.dayTitleLayer.textColor = [LBCalenderConfig shareInstanse].daySelectionColor;
                *stop = YES;
            }
        }];
        
    }
    else if ([keyPath isEqualToString:NSStringFromSelector(@selector(eventsDates))]){
        _eventIndicator.hidden = YES;
        
        __weak typeof(self) weakSelf = self;
        [[LBCalenderConfig shareInstanse].eventsDates enumerateObjectsUsingBlock:^(NSDate * _Nonnull eventsDate, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([eventsDate isEqualToDate:weakSelf.date]) {
                weakSelf.eventIndicator.hidden = NO;
                *stop = YES;
            }
        }];
    }
}

-(void)dealloc{
    [[LBCalenderConfig shareInstanse] removeObserver:self forKeyPath:NSStringFromSelector(@selector(selectionDates))];
    [[LBCalenderConfig shareInstanse] removeObserver:self forKeyPath:NSStringFromSelector(@selector(eventsDates))];
}
@end

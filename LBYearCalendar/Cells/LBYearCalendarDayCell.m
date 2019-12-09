//
//  LBYearCalendarDayCell.m
//  test
//
//  Created by 刘彬 on 2019/11/22.
//  Copyright © 2019 刘彬. All rights reserved.
//

#import "LBYearCalendarDayCell.h"
#import "LBCalenderConfig.h"

@interface LBYearCalendarDayCell ()
@property (nonatomic,strong)NSCalendar *calendar;
@property (nonatomic,strong)CATextLayer *dayTitleLayer;
@property (nonatomic,strong)NSDateFormatter *dayFromatter;
@end

@implementation LBYearCalendarDayCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _dayFromatter = [[NSDateFormatter alloc] init];
        _dayFromatter.dateFormat = @"d";
        
        _selectionLayer = [[CAShapeLayer alloc] init];
        _selectionLayer.hidden = YES;
        _selectionLayer.frame = CGRectMake((CGRectGetWidth(frame)-(CGRectGetWidth(frame)-2.5))/2, 0, CGRectGetWidth(frame)-2.5, CGRectGetWidth(frame)-2.5);
        _selectionLayer.fillColor = [LBCalenderConfig shareInstanse].selectionColor.CGColor;
        _selectionLayer.path = [UIBezierPath bezierPathWithOvalInRect:_selectionLayer.bounds].CGPath;
        [self.layer addSublayer:_selectionLayer];
        
        _dayTitleLayer = [[CATextLayer alloc] init];
        _dayTitleLayer.contentsScale = 2;
        _dayTitleLayer.foregroundColor = [LBCalenderConfig shareInstanse].dayColor.CGColor;
        _dayTitleLayer.frame = self.bounds;
        _dayTitleLayer.alignmentMode = kCAAlignmentCenter;
        _dayTitleLayer.font = (__bridge CFTypeRef)[LBCalenderConfig shareInstanse].dayFont;
        _dayTitleLayer.fontSize = [LBCalenderConfig shareInstanse].dayFont.pointSize;
        [self.layer addSublayer:_dayTitleLayer];
        
        _eventIndicator = [[CAShapeLayer alloc] init];
        _eventIndicator.hidden = YES;
        _eventIndicator.frame = CGRectMake((CGRectGetWidth(frame)-CGRectGetWidth(_selectionLayer.frame)/2)/2, CGRectGetMaxY(_selectionLayer.frame)+2.5, 6, 1);
        _eventIndicator.fillColor = [LBCalenderConfig shareInstanse].eventIndicatorColor.CGColor;
        _eventIndicator.path = [UIBezierPath bezierPathWithRect:_eventIndicator.bounds].CGPath;
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
            _dayTitleLayer.string = [_dayFromatter stringFromDate:date];
            
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
        _dayTitleLayer.foregroundColor = [LBCalenderConfig shareInstanse].dayColor.CGColor;
        
        __weak typeof(self) weakSelf = self;
        [[LBCalenderConfig shareInstanse].selectionDates enumerateObjectsUsingBlock:^(NSDate * _Nonnull selectionDate, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([selectionDate isEqualToDate:weakSelf.date]) {
                weakSelf.selectionLayer.hidden = NO;
                weakSelf.dayTitleLayer.foregroundColor = [LBCalenderConfig shareInstanse].daySelectionColor.CGColor;
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

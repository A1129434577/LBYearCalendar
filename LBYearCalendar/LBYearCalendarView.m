//
//  LBYearCalendarView.m
//  test
//
//  Created by 刘彬 on 2019/11/22.
//  Copyright © 2019 刘彬. All rights reserved.
//

#import "LBYearCalendarView.h"
#import "LBOneYearCollectionView.h"

@interface LBYearCalendarView ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>
@property (nonatomic,strong)NSCalendar *calendar;
@property (nonatomic,strong)NSDateFormatter *yearFormatter;
@property (nonatomic,strong)NSMutableArray<LBOneYearCollectionView *> *oneYearCollectionViews;
@end

@implementation LBYearCalendarView

- (instancetype)initWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(CGRectGetWidth(frame), CGRectGetHeight(frame));
    layout.minimumLineSpacing = 0;
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        _calendar = [NSCalendar currentCalendar];
        
        _yearFormatter = [[NSDateFormatter alloc] init];
        _yearFormatter.dateFormat = @"yyyy";
        
        _startYear = [NSDate dateWithTimeIntervalSince1970:0];
        NSDate *date = [_yearFormatter dateFromString:[_yearFormatter stringFromDate:[NSDate date]]];
        _endYear = [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitYear value:1500 toDate:date options:0];
        
        _oneYearCollectionViews = [NSMutableArray array];
        for (int i = 0; i < 2; i ++) {
            LBOneYearCollectionView *oneYearCollectionView = [[LBOneYearCollectionView alloc] initWithFrame:self.bounds];
            [_oneYearCollectionViews addObject:oneYearCollectionView];
        }
        
        
        
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.dataSource = self;

        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass(UICollectionViewCell.self)];
    }
    return self;
}

-(void)setLb_delegate:(id<LBYearCalendarDelegate>)lb_delegate{
    _lb_delegate = lb_delegate;
    self.delegate = self;//重定位delegate，让lb_delegate响应代理
}
-(void)setDelegate:(id<UIScrollViewDelegate>)delegate{
    if (delegate) [super setDelegate:self];
}
-(void)setStartYear:(NSDate *)startYear{
    startYear = [_yearFormatter dateFromString:[_yearFormatter stringFromDate:startYear]];
    if (![_startYear isEqualToDate:startYear]) {
        _startYear = startYear;
        [self reloadData];
    }
    
}

-(void)setEndYear:(NSDate *)endYear{
    endYear = [_yearFormatter dateFromString:[_yearFormatter stringFromDate:endYear]];;
    if (![_endYear isEqualToDate:endYear]) {
        _endYear = endYear;
        [self reloadData];
    }
}

-(void)setCurrentPage:(NSDate *)currentPage{
    currentPage = [_yearFormatter dateFromString:[_yearFormatter stringFromDate:currentPage]];
    if (![_currentPage isEqualToDate:currentPage]) {
        _currentPage = currentPage;
        [self scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:[_calendar components:NSCalendarUnitYear fromDate:_startYear toDate:_currentPage options:0].year+1 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
    if (!_currentPage) {
        self.currentPage = [NSDate date];
    }
}


#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSUInteger years = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:_startYear toDate:_endYear options:0].year+1;
    return years;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifir = NSStringFromClass(UICollectionViewCell.self);
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifir forIndexPath:indexPath];
    
    return cell;
}

#pragma mark UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *invisibleCollectionViews = _oneYearCollectionViews.mutableCopy;
    [invisibleCollectionViews removeObject:[collectionView.visibleCells.firstObject viewWithTag:1000]];
    
    LBOneYearCollectionView *invisibleCollectionView = invisibleCollectionViews.firstObject;
     invisibleCollectionView.year = [_calendar dateByAddingUnit:NSCalendarUnitYear value:indexPath.row toDate:_startYear options:0];
    invisibleCollectionView.tag = 1000;
    [cell addSubview:invisibleCollectionView];
}
-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    self.currentPage = [_calendar dateByAddingUnit:NSCalendarUnitYear value:collectionView.contentOffset.x/CGRectGetWidth(collectionView.bounds) toDate:_startYear options:0];
}

//如果本类没实现的代理方法由lb_delegate实现
- (BOOL)respondsToSelector:(SEL)aSelector{
    BOOL respondsSelector = [super respondsToSelector:aSelector];
    if (!respondsSelector && [self.lb_delegate respondsToSelector:aSelector]) {
        return YES;
    }
    return respondsSelector;
}
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if (![super respondsToSelector:aSelector] && [self.lb_delegate respondsToSelector:aSelector]) {
        return self.lb_delegate;
    }
    return [super forwardingTargetForSelector: aSelector];
}
@end

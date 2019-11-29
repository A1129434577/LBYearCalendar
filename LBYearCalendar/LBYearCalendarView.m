//
//  LBYearCalendarView.m
//  test
//
//  Created by 刘彬 on 2019/11/22.
//  Copyright © 2019 刘彬. All rights reserved.
//

#import "LBYearCalendarView.h"
#import "LBYearCalenderCell.h"

@interface LBYearCalendarView ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>
@property (nonatomic,strong)NSDateFormatter *yearDateFormatter;
@end

@implementation LBYearCalendarView
- (instancetype)initWithFrame:(CGRect)frame delegate:(nonnull id<LBYearCalendarDelegate> )delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        _lb_delegate = delegate;
        
        
        _yearDateFormatter = [[NSDateFormatter alloc] init];
        _yearDateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
        _yearDateFormatter.dateFormat = @"yyyy";
        
        _startYear = [_yearDateFormatter dateFromString:@"1970"];
        _endYear = [_yearDateFormatter dateFromString:@"3030"];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
        layout.minimumLineSpacing = 0;
        
        _calenderYearCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, layout.itemSize.width, layout.itemSize.height) collectionViewLayout:layout];
        _calenderYearCollectionView.showsHorizontalScrollIndicator = NO;
        _calenderYearCollectionView.pagingEnabled = YES;
        _calenderYearCollectionView.dataSource = self;
        _calenderYearCollectionView.delegate = self;

        [_calenderYearCollectionView registerClass:[LBYearCalenderCell class] forCellWithReuseIdentifier:NSStringFromClass(LBYearCalenderCell.self)];
        [self addSubview:_calenderYearCollectionView];
    }
    return self;
}
-(void)setStartYear:(NSDate *)startYear{
    _startYear = startYear;
    [_calenderYearCollectionView reloadData];
}

-(void)setEndYear:(NSDate *)endYear{
    _endYear = endYear;
    [_calenderYearCollectionView reloadData];
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSUInteger years = [[LBCalenderConfig shareInstanse].calendar components:NSCalendarUnitYear fromDate:_startYear toDate:_endYear options:0].year+1;
    return years;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifir = NSStringFromClass(LBYearCalenderCell.self);
    LBYearCalenderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifir forIndexPath:indexPath];
    
    cell.year = [[LBCalenderConfig shareInstanse].calendar dateByAddingUnit:NSCalendarUnitYear value:indexPath.row toDate:_startYear options:0];
    return cell;
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

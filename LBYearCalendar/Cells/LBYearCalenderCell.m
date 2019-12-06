//
//  FCCalenderYearCell.m
//  fachan
//
//  Created by 刘彬 on 2019/11/22.
//  Copyright © 2019 Swartz. All rights reserved.
//

#import "LBYearCalenderCell.h"
#import "LBYearCalenderMonthCell.h"
#import "LBCalenderConfig.h"

@interface LBYearCalenderCell()<UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView *oneYearCollectionView;
@end

@implementation LBYearCalenderCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(CGRectGetWidth(self.bounds)/3.0, CGRectGetHeight(self.bounds)/4.0);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;

        UICollectionView *oneYearCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        if (@available(iOS 13.0, *)) {
            oneYearCollectionView.backgroundColor = [UIColor systemGroupedBackgroundColor];
        } else {
            oneYearCollectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }
        
        oneYearCollectionView.showsHorizontalScrollIndicator = NO;
        oneYearCollectionView.scrollEnabled = NO;
        oneYearCollectionView.dataSource = self;
        [oneYearCollectionView registerClass:[LBYearCalenderMonthCell class] forCellWithReuseIdentifier:NSStringFromClass(LBYearCalenderMonthCell.self)];
        [self addSubview:oneYearCollectionView];
        _oneYearCollectionView = oneYearCollectionView;
    }
    return self;
}

-(void)setYear:(NSDate *)year{
    _year = year;
    [_oneYearCollectionView reloadData];
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;//每年12个月
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifir = NSStringFromClass(LBYearCalenderMonthCell.self);
    LBYearCalenderMonthCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifir forIndexPath:indexPath];
    cell.month = [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitMonth value:indexPath.row toDate:_year options:0];
    return cell;
}
@end

//
//  FCCalenderYearCell.m
//  fachan
//
//  Created by 刘彬 on 2019/11/22.
//  Copyright © 2019 Swartz. All rights reserved.
//

#import "LBOneYearCollectionView.h"
#import "LBYearCalenderMonthCell.h"
#import "LBCalenderConfig.h"

@interface LBOneYearCollectionView()<UICollectionViewDataSource>
@end

@implementation LBOneYearCollectionView
- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(CGRectGetWidth(frame)/3.0, CGRectGetHeight(frame)/4.0);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.scrollEnabled = NO;
        self.dataSource = self;
        [self registerClass:[LBYearCalenderMonthCell class] forCellWithReuseIdentifier:NSStringFromClass(LBYearCalenderMonthCell.self)];
    }
    return self;
}

-(void)setYear:(NSDate *)year{
    _year = year;
    [self reloadData];
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

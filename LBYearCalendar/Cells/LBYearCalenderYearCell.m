//
//  LBYearCalenderYearCell.m
//  LBYearCalendarExample
//
//  Created by 刘彬 on 2020/3/10.
//  Copyright © 2020 刘彬. All rights reserved.
//

#import "LBYearCalenderYearCell.h"


@implementation LBYearCalenderYearCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _oneYearCollectionView = [[LBOneYearCollectionView alloc] initWithFrame:self.bounds];
        [self addSubview:_oneYearCollectionView];
    }
    return self;
}
@end

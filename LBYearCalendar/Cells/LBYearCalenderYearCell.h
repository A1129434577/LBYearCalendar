//
//  LBYearCalenderYearCell.h
//  LBYearCalendarExample
//
//  Created by 刘彬 on 2020/3/10.
//  Copyright © 2020 刘彬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBOneYearCollectionView.h"
NS_ASSUME_NONNULL_BEGIN

@interface LBYearCalenderYearCell : UICollectionViewCell
@property (nonatomic, strong, readonly) LBOneYearCollectionView *oneYearCollectionView;
@end

NS_ASSUME_NONNULL_END

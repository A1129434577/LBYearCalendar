//
//  LBCalenderShareData.h
//  test
//
//  Created by 刘彬 on 2019/11/23.
//  Copyright © 2019 刘彬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LBCalenderConfig : NSObject
@property (nonatomic,strong)NSCalendar *calendar;

@property (nonatomic,strong,nullable)NSArray<NSDate *> *selectionDates;
@property (nonatomic,strong,nullable)NSArray<NSDate *> *eventsDates;

@property (nonatomic,strong,nullable)UIFont *monthFont;
@property (nonatomic,strong,nullable)UIFont *dayFont;

@property (nonatomic,strong,nullable)UIColor *monthColor;
@property (nonatomic,strong,nullable)UIColor *dayColor;
@property (nonatomic,strong,nullable)UIColor *daySelectionColor;
@property (nonatomic,strong,nullable)UIColor *selectionColor;
@property (nonatomic,strong,nullable)UIColor *eventIndicatorColor;

+(LBCalenderConfig *)shareInstanse;
@end

NS_ASSUME_NONNULL_END

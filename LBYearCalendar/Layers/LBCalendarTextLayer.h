//
//  LBCalendarTextLayer.h
//  LBYearCalendarExample
//
//  Created by 刘彬 on 2020/3/10.
//  Copyright © 2020 刘彬. All rights reserved.
//

#import <YYAsyncLayer/YYAsyncLayer.h>

NS_ASSUME_NONNULL_BEGIN

@interface LBCalendarTextLayer : YYAsyncLayer
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) NSTextAlignment alignment;
@end

NS_ASSUME_NONNULL_END

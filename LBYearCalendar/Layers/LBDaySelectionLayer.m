//
//  LBDaySelectionLayer.m
//  LBYearCalendarExample
//
//  Created by 刘彬 on 2020/3/10.
//  Copyright © 2020 刘彬. All rights reserved.
//

#import "LBDaySelectionLayer.h"
@interface LBDaySelectionLayer ()<CALayerDelegate>

@end
@implementation LBDaySelectionLayer
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate = self;
        _fillColor = [UIColor magentaColor];
        
        [[YYTransaction transactionWithTarget:self selector:@selector(setNeedsDisplay)] commit];
    }
    return self;
}
-(void)setFillColor:(UIColor *)fillColor{
    _fillColor = fillColor;
    [self setNeedsDisplay];
}

- (YYAsyncLayerDisplayTask *)newAsyncDisplayTask {
    
    UIColor  *fillColor = _fillColor;
    
    YYAsyncLayerDisplayTask *task = [YYAsyncLayerDisplayTask new];
    task.willDisplay = ^(CALayer *layer) {
        //...
    };
    
    CGRect frame = self.bounds;
    
    task.display = ^(CGContextRef context, CGSize size, BOOL(^isCancelled)(void)) {
        if (isCancelled()) return;
        CGContextAddArc(context, CGRectGetWidth(frame)/2.0, CGRectGetHeight(frame)/2.0, CGRectGetWidth(frame)/2.0-0.5, 0, 2*M_PI, 0);
        CGContextSetFillColorWithColor(context, fillColor.CGColor);
        CGContextDrawPath(context, kCGPathFill);
    };
    
    task.didDisplay = ^(CALayer *layer, BOOL finished) {
        if (finished) {
            // finished
        } else {
            // cancelled
        }
    };
    
    return task;
}
@end

//
//  LBEventIndicatorLayer.m
//  LBYearCalendarExample
//
//  Created by 刘彬 on 2020/3/10.
//  Copyright © 2020 刘彬. All rights reserved.
//

#import "LBEventIndicatorLayer.h"

@interface LBEventIndicatorLayer ()<CALayerDelegate>

@end
@implementation LBEventIndicatorLayer
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
        CGContextAddRect(context, frame);
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


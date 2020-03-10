//
//  LBCalendarTextLayer.m
//  LBYearCalendarExample
//
//  Created by 刘彬 on 2020/3/10.
//  Copyright © 2020 刘彬. All rights reserved.
//

#import "LBCalendarTextLayer.h"

@interface LBCalendarTextLayer ()<CALayerDelegate>

@end

@implementation LBCalendarTextLayer
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate = self;
        _font = [UIFont systemFontOfSize:20];
        _textColor = [UIColor blackColor];
        _alignment = NSTextAlignmentLeft;
        
        [[YYTransaction transactionWithTarget:self selector:@selector(setNeedsDisplay)] commit];
    }
    return self;
}


-(void)setFont:(UIFont *)font{
    _font = font;
    [self setNeedsDisplay];
}
-(void)setText:(NSString *)text{
    _text = text;
    [self setNeedsDisplay];
}
-(void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    [self setNeedsDisplay];
}
-(void)setAlignment:(NSTextAlignment)alignment{
    _alignment = alignment;
    [self setNeedsDisplay];
}

- (YYAsyncLayerDisplayTask *)newAsyncDisplayTask {
    NSString *text      = _text;
    UIFont   *font      = _font;
    UIColor  *textColor = _textColor;
    NSTextAlignment  alignment = _alignment;
    
    YYAsyncLayerDisplayTask *task = [YYAsyncLayerDisplayTask new];
    task.willDisplay = ^(CALayer *layer) {
        //...
    };
    
    
    UILabel *fontLabel = [[UILabel alloc] init];
    fontLabel.numberOfLines = 0;
    fontLabel.font = font;
    fontLabel.text = text;
    [fontLabel sizeToFit];
    
    CGRect frame = self.bounds;
    CGFloat marginTop = (CGRectGetHeight(frame)-CGRectGetHeight(fontLabel.bounds))/2;
    frame.origin.y = marginTop;
    
    task.display = ^(CGContextRef context, CGSize size, BOOL(^isCancelled)(void)) {
        if (isCancelled()) return;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = alignment;
        if (isCancelled()) return;
        [text drawInRect:frame withAttributes:@{NSForegroundColorAttributeName:textColor,NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle}];
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

//
//  ZZTimerLayer.m
//  MathTutor
//
//  Created by Morgan Wilde on 12/06/2014.
//  Copyright (c) 2014 morganwilde. All rights reserved.
//

#import "ZZTimerLayer.h"

@implementation ZZTimerLayer

@dynamic endAngle;

- (instancetype)init
{
    self = [super init];
    if (!self) {
        self.endAngle = 0; //M_PI_2 - FLT_EPSILON;
    }
    return self;
}
- (id)initWithLayer:(id)layer
{
    ZZTimerLayer *temp = (ZZTimerLayer *)layer;
    self = [super initWithLayer:layer];
    if (self) {
        self.timerColor = temp.timerColor;
    }
    return self;
}
- (void)drawInContext:(CGContextRef)ctx
{
    [super drawInContext:ctx];
    UIGraphicsPushContext(ctx);
    
    CGRect rect = self.bounds;
    
    [self.timerColor setFill];
    
    CGPoint center = CGPointMake(rect.size.width/2.0, rect.size.width/2.0);
    CGFloat lineWidth = 5.0;
    UIBezierPath *circleBack = [[UIBezierPath alloc] init];
    [circleBack addArcWithCenter:center
                          radius:rect.size.width/2.0 - lineWidth/2.0
                      startAngle:0
                        endAngle:self.endAngle
                       clockwise:YES];
    [circleBack addLineToPoint:center];
    [circleBack closePath];
    [circleBack fill];
    
    UIGraphicsPopContext();
}
+ (BOOL)needsDisplayForKey:(NSString *)key
{
    if ([key isEqualToString:@"endAngle"]) {
        return YES;
    } else {
        return [super needsDisplayForKey:key];
    }
}
- (void)setTimerColor:(UIColor *)timerColor
{
    _timerColor = timerColor;
}

@end

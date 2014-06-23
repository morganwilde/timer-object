//
//  ZZTimerView.m
//  MathTutor
//
//  Created by Morgan Wilde on 12/06/2014.
//  Copyright (c) 2014 morganwilde. All rights reserved.
//

#import "ZZTimerView.h"
#import "ZZTimerLayer.h"
//#import "View/Abstractions/UIViewAbstraction.h"

@interface ZZTimerView()

@property (strong, nonatomic) ZZTimerLayer *backgroundLayer;
@property (nonatomic) CFTimeInterval startedTime;
@property (nonatomic) CFTimeInterval stopedTime;
@property (nonatomic) float endAngle;
@property (nonatomic) float endAngleInitial;
@property (nonatomic) float endAngleFinal;
@property (nonatomic) UIColor *timerColorPermanent;
@property (nonatomic) CGAffineTransform transformCurrent;
@property (strong, nonatomic) NSInvocation *invocation;
@property (strong, nonatomic) NSMethodSignature *signature;
@property (nonatomic, getter = isReadjusted) BOOL readjusted;

@end

@implementation ZZTimerView

#pragma mark - Designated initialiser
- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
        self.endAngleInitial = 0;
        self.endAngleFinal = M_PI*2;
        self.endAngle = self.endAngleInitial;
        self.timerColor = color;
        self.timerColorPermanent = color;
        self.stopped = YES;
        self.transformCurrent = self.transform;
        
        [self.layer addSublayer:self.backgroundLayer];
        [self.backgroundLayer setNeedsDisplay];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color withCallback:(void (^)(void))callback
{
    self = [self initWithFrame:frame color:color];
    self.callback = callback;
    return self;
}
#pragma mark - Lazy instantiation
- (ZZTimerLayer *)backgroundLayer
{
    if (!_backgroundLayer) {
        CGFloat scale = [[UIScreen mainScreen] scale];
        _backgroundLayer = [ZZTimerLayer layer];
        _backgroundLayer.frame = self.bounds;
        _backgroundLayer.rasterizationScale = scale;
        _backgroundLayer.contentsScale = scale;
        _backgroundLayer.transform = CATransform3DMakeRotation(270.0 / 180.0*M_PI, 0.0, 0.0, 1.0);
    }
    return _backgroundLayer;
}
- (void)setEndAngle:(float)endAngle
{
    _endAngle = endAngle;
    self.backgroundLayer.endAngle = _endAngle;
}
- (void)setTimerColor:(UIColor *)timerColor
{
    _timerColor = timerColor;
    self.backgroundLayer.timerColor = _timerColor;
}
#pragma mark - Animation start/stop
- (void)timerBeginWithDuration:(double)duration
{
    self.timerDuration = duration;
    self.stopped = NO;
    self.timerColor = self.timerColorPermanent;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"endAngle"];
    animation.duration = duration;
    animation.fromValue = [NSNumber numberWithDouble:self.endAngleInitial];
    animation.toValue = [NSNumber numberWithDouble:self.endAngleFinal];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.delegate = self;
    
    [self.backgroundLayer addAnimation:animation forKey:@"endAngle"];
}
- (void)timerBeginWithDuration:(double)duration andStop:(double)after with:(BOOL)answer
{
    [self timerBeginWithDuration:duration];
    self.signature = [[self class] instanceMethodSignatureForSelector:@selector(timerStopAnswer:)];
    self.invocation = [NSInvocation invocationWithMethodSignature:self.signature];
    [self.invocation setSelector:@selector(timerStopAnswer:)];
    [self.invocation setTarget:self];
    [self.invocation setArgument:&answer atIndex:2];
    [self.invocation performSelector:@selector(invokeWithTarget:) withObject:self afterDelay:after];
}
- (double)timerStop
{
    self.stopped = YES;
    CFTimeInterval pausedTime = [self.backgroundLayer convertTime:CACurrentMediaTime() fromLayer:self.layer];
    self.backgroundLayer.speed = 0.0;
    self.backgroundLayer.timeOffset = pausedTime;
    self.stopedTime = pausedTime;
    self.duration = self.stopedTime - self.startedTime;
    if (self.callback) {
        self.callback();
    }
    [self animateTimerBlowUp];
    
    return self.duration;
}
- (void)animateTimerBlowUp
{
    [UIView animateWithDuration:2 delay:0.0 usingSpringWithDamping:0.25 initialSpringVelocity:0.25 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformScale(self.transformCurrent, 1.5, 1.5);
    } completion:^(BOOL finished){
        [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.25 initialSpringVelocity:0.25 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = self.transformCurrent;
        } completion:^(BOOL finished){
            
        }];
    }];
}
- (double)timerStopAnswer:(BOOL)correct
{
    if (!self.isReadjusted || self.stopped) {
        if (correct) {
            self.backgroundLayer.timerColor = [UIColor greenColor];//[UIViewAbstraction colorGood];
        } else {
            self.backgroundLayer.timerColor = [UIColor redColor];//[UIViewAbstraction colorBad];
        }
        return [self timerStop];
    }
    return self.duration;
}
- (double)timerStopAnswer:(BOOL)correct andReadjustTo:(double)timer
{
    // Readjust to the timer
    self.stopped = YES;
    self.readjusted = YES;
    CFTimeInterval pausedTime = [self.backgroundLayer convertTime:CACurrentMediaTime() fromLayer:self.layer];
    self.backgroundLayer.speed = 1.0;
    self.backgroundLayer.timeOffset = pausedTime;
    self.stopedTime = pausedTime;
    self.duration = self.stopedTime - self.startedTime;
    
    float startAngle = self.duration/self.timerDuration * self.endAngleFinal;
    float endAngle = timer/self.timerDuration * self.endAngleFinal;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"endAngle"];
    animation.duration = 0.25;
    animation.fromValue = [NSNumber numberWithDouble:startAngle];
    animation.toValue = [NSNumber numberWithDouble:endAngle];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.delegate = self;
    
    [self.backgroundLayer addAnimation:animation forKey:@"endAngle"];
    if (correct) {
        self.backgroundLayer.timerColor = [UIColor greenColor];//[UIViewAbstraction colorGood];
    } else {
        self.backgroundLayer.timerColor = [UIColor redColor];//[UIViewAbstraction colorBad];
    }
    [self animateTimerBlowUp];
    
    return timer;
}
- (void)timerStoppedShowAnswer:(BOOL)correct
{
    [self timerStopAnswer:correct andReadjustTo:self.timerDuration];
}
- (void)timerStopHard
{
    [self.layer removeAllAnimations];
}
- (void)timerReset
{
    self.backgroundLayer.speed = 1.0;
    self.backgroundLayer.timeOffset = 0.0;
    self.backgroundLayer.beginTime = 0.0;
    // Paused
    //self.backgroundLayer.beginTime = [self.backgroundLayer convertTime:CACurrentMediaTime() fromLayer:nil] - self.stopedTime;
    self.endAngle = self.endAngleInitial;
    self.startedTime = 0;
    self.stopedTime = 0;
    self.duration = 0;
    [self timerBeginWithDuration:self.timerDuration];
}
#pragma mark - Animation events
- (void)animationDidStart:(CAAnimation *)anim
{
    self.startedTime = CACurrentMediaTime();
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag && !self.isReadjusted) {
        [self timerStop];
        //[self timerStopAnswer:NO]; // Changed because this when the timer runs out there is no default color;
    }
}

@end

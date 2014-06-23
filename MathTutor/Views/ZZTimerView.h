//
//  ZZTimerView.h
//  MathTutor
//
//  Created by Morgan Wilde on 12/06/2014.
//  Copyright (c) 2014 morganwilde. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ZZTimerView : UIView

@property (nonatomic) double timerDuration;
@property (nonatomic) double duration;
@property (strong, nonatomic) UIColor *timerColor;
@property (nonatomic, copy) void (^callback)();
@property (nonatomic, getter = isStopped) BOOL stopped;

// Designated initialiser
- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color;
- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color withCallback:(void (^)(void))callback;
// Begin timer animation takes takes duration seconds
- (void)timerBeginWithDuration:(double)duration;
// Begin timer animation with auto stop
- (void)timerBeginWithDuration:(double)duration andStop:(double)after with:(BOOL)answer;
// Stop timer
- (double)timerStop;
// Stop timer with color
- (double)timerStopAnswer:(BOOL)correct;
// Stop timer with color and readjust to the given time
- (double)timerStopAnswer:(BOOL)correct andReadjustTo:(double)timer;
// Timer ran out and then user posted answer
- (void)timerStoppedShowAnswer:(BOOL)correct;
// Stop all animations abruptly
- (void)timerStopHard;
// Reset timer
- (void)timerReset;

@end

//
//  ZZTimerView.h
//  MathTutor
//
//  Created by Morgan Wilde on 12/06/2014.
//  Copyright (c) 2014 morganwilde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZTimerView : UIView


@property (nonatomic) double duration;
@property (strong, nonatomic) UIColor *timerColor;
@property (nonatomic, copy) void (^callback)();

// Designated initialiser
- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color;
- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color withCallback:(void (^)(void))callback;
// Begin timer animation takes takes duration seconds
- (void)timerBeginWithDuration:(CGFloat)duration;
// Stop timer
- (double)timerStop;

@end

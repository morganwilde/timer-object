//
//  RootVC.m
//  MathTutor
//
//  Created by Morgan Wilde on 11/06/2014.
//  Copyright (c) 2014 morganwilde. All rights reserved.
//

#import "RootVC.h"
#import "../Views/ZZTimerView.h"

@interface RootVC ()

@property (nonatomic, strong) ZZTimerView *timerView;

@end

@implementation RootVC

- (void)loadView
{
    CGRect frameView = [[UIScreen mainScreen] bounds];
    UIView *view = [[UIView alloc] initWithFrame:frameView];
    view.backgroundColor = [UIColor grayColor];
    view.userInteractionEnabled = YES;
    
    CGFloat width = 50;
    CGRect frameTimer = CGRectMake(frameView.size.width/2.0 - width/2.0,
                                   frameView.size.height/2.0 - width/2.0,
                                   width,
                                   width);
    self.timerView = [[ZZTimerView alloc] initWithFrame:frameTimer color:[UIColor brownColor] withCallback:^{
        [self timerStopped];
    }];
    [view addSubview:self.timerView];
    
    [self.timerView timerBeginWithDuration:10.0];
    
    self.view = view;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.timerView timerStop];
    
}
- (void)timerStopped
{
    NSLog(@"stopped at: %lf", self.timerView.duration);
}

@end

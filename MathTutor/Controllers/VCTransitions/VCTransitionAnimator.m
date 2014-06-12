//
//  VCTransitionAnimator.m
//  MathTutor
//
//  Created by Morgan Wilde on 11/06/2014.
//  Copyright (c) 2014 morganwilde. All rights reserved.
//

#import "VCTransitionAnimator.h"

@implementation VCTransitionAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [[transitionContext containerView] addSubview:toVC.view];
    toVC.view.alpha = 0;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         fromVC.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
                         toVC.view.alpha = 1;
                     }
                     completion:^(BOOL finished){
                         fromVC.view.transform = CGAffineTransformIdentity;
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

@end

//
//  Video.m
//  MathTutor
//
//  Created by Morgan Wilde on 13/06/2014.
//  Copyright (c) 2014 morganwilde. All rights reserved.
//

#import "Video.h"


@implementation Video

- (void)private
{
    
    /*
    
    // Get first question
    Question *question = [self.sdk nextQuestion];
    
    
    
    // Set User Response
    Action *action = [[Action alloc] init];
    action.correct  = YES;
    action.duration = 5;
    [self.sdk logAction:action];
    
    
    
    // Automatically determines next question based on past result
    Question *question = [self.sdk nextQuestion];
    */
    
    
    
    
    
    // Create multiplayer Game
    Activity *activity = [[Activity alloc] init];
    activity.multiplayer = YES;

    
    
    
    // Start Playing
    Action *action = [[Action alloc] init];
    action.correct  = YES;
    action.duration = 5;
    [self.sdk logAction:action];
    
    
    
    
    
    
    
}

@end

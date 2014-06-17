//
//  Question.h
//  MathTutor
//
//  Created by Morgan Wilde on 13/06/2014.
//  Copyright (c) 2014 morganwilde. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Action.h"

@interface Question : NSObject

- (instancetype)nextQuestion;
- (void)logAction:(Action *)action;

@end

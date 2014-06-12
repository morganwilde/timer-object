//
//  BlankVC.m
//  MathTutor
//
//  Created by Morgan Wilde on 11/06/2014.
//  Copyright (c) 2014 morganwilde. All rights reserved.
//

#import "BlankVC.h"

@interface BlankVC ()

@end

@implementation BlankVC

#pragma mark - Initialiser
- (id)initWithColor:(UIColor *)color
{
    self = [super init];
    if (self) {
        self.color = color;
    }
    return self;
}
#pragma mark - View lifecycle
- (void)loadView
{
    CGRect frameView = CGRectMake(0, 0, 100, 100);
    UIView *view = [[UIView alloc] initWithFrame:frameView];
    view.backgroundColor = self.color;
    
    self.view = view;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

@end

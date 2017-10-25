//
//  ResultsVC.m
//  ADHD
//
//  Created by Apple on 06/02/17.
//  Copyright © 2017 Apple. All rights reserved.
//

#import "ResultsVC.h"

@interface ResultsVC ()

@end

@implementation ResultsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.hidesBackButton = YES;
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];
    
    //The event handling method
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    [super methodReset:recognizer];
    [self.navigationController popToRootViewControllerAnimated:true];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.hidesBackButton = YES;
}

@end

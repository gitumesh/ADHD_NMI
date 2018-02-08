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
    _resultLabel.text = _result;
    [super methodReset:self];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    viewBottomView.hidden = true;
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    [self.navigationController popToRootViewControllerAnimated:true];
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    viewBottomView.hidden = true;
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.hidesBackButton = YES;
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];
}

@end

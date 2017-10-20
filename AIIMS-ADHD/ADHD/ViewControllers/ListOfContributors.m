//
//  ListOfContributors.m
//  ADHD
//
//  Created by Umesh Sharma on 14/10/17.
//  Copyright © 2017 Apple. All rights reserved.
//

#import "ListOfContributors.h"

@implementation ListOfContributors

-(void) viewDidLoad{
    [super viewDidLoad];
    [self.view setUserInteractionEnabled:false];
    viewBottomView.hidden = true;
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:true];
    });
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

@end

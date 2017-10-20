//
//  MoreAppsVC.m
//  AIIMS-NMI
//
//  Created by Umesh Sharma on 14/10/17.
//  Copyright © 2017 Umesh Sharma. All rights reserved.
//

#import "MoreAppsVC.h"

@interface MoreAppsVC ()

@end

@implementation MoreAppsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    viewBottomView.hidden = true;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)autism:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/US/app/autism-spectrum-disorder-diagnostic-tool/id1151524697?mt=8"]];
}

- (IBAction)childhoodEpilepsy:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/in/app/childhood-epilepsy-diagnostic/id1078173463?mt=8"]];
}



@end

//
//  InfoVC.m
//  ADHD
//
//  Created by Umesh Sharma on 30/04/17.
//  Copyright © 2017 Apple. All rights reserved.
//

#import "InfoVC.h"

@interface InfoVC ()

@end

@implementation InfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    viewBottomView.hidden = true;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionOpenUrl:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.pedneuroaiims.org"]];
}

- (IBAction)actionSendEmail:(UIButton*)sender {
    if ([MFMailComposeViewController canSendMail]) {
        NSString *emailTitle = @"Info on ADHD - iOS App";
        // Email Content
        NSString *messageBody = @"";
        // To address
        NSArray *toRecipents = [NSArray arrayWithObject:@"support@appcoda.com"];
        switch (sender.tag) {
            case 0:
                toRecipents = [NSArray arrayWithObject:@"sheffaligulati@gmail.com"];
                break;
                
            case 1:
                toRecipents = [NSArray arrayWithObject:@"sheffalig@yahoo.com"];
                break;
                
            case 2:
                toRecipents = [NSArray arrayWithObject:@"pedsneuroaiims@gmail.com"];
                break;
                
            default:
                break;
        }
        
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        [mc setToRecipients:toRecipents];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
    }else{
        [Utilities showAlertwithTitle:kAlertTitle withMessage:@"Mail services unable with this device." withButtonTitle:kAlertButtonOK withController:self];
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

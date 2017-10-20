//
//  AgeGroupVC.m
//  ADHD
//
//  Created by Apple on 05/02/17.
//  Copyright © 2017 Apple. All rights reserved.
//

#import "AgeGroupVC.h"

@interface AgeGroupVC ()

@property (weak, nonatomic) IBOutlet UIImageView *launchImage;
@property (weak, nonatomic) IBOutlet UIButton *buttonChild;
@property (weak, nonatomic) IBOutlet UIButton *buttonTeenager;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItem;

@end

@implementation AgeGroupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [_launchImage setHidden:true];
        [self performSegueWithIdentifier:@"ListOfContributors" sender:self];
    });
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    selectedChildAge  = kSelectedChildAgeNone;
    [self resetButtons];
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}


-(void) viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
}

-(void) viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionChildSelected:(id)sender {
    selectedChildAge = kSelectedChildAgeBelow13;
    [self changeButtonIcon:sender];
}


- (IBAction)actionTeenagerSelected:(id)sender {
    selectedChildAge = kSelectedChildAgeAbove13;
    [self changeButtonIcon:sender];
  
}

-(void) changeButtonIcon:(id)sender{
    [self resetButtons];
    UIButton *buttonSelected = (UIButton*)sender;
    [buttonSelected setImage:[UIImage imageNamed:@"Selection-Selected"] forState:UIControlStateNormal];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:kSequeShowQuestionView sender:self];
    });
    
}

-(void) resetButtons{
    [_buttonChild setImage:[UIImage imageNamed:@"Selection-Unselected"] forState:UIControlStateNormal];
    [_buttonTeenager setImage:[UIImage imageNamed:@"Selection-Unselected"] forState:UIControlStateNormal];
}

#pragma mark - PrepareForSegue

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kSequeShowQuestionView]) {
        QuestionsVC *vc = (QuestionsVC *)segue.destinationViewController;
        NSLog(@"selectedChildAge = %d",selectedChildAge);
        switch (selectedChildAge) {
            case kSelectedChildAgeAbove13:
                [[NSUserDefaults standardUserDefaults] setValue:@"13" forKey:@"age"];
                break;
                
            default:
                [[NSUserDefaults standardUserDefaults] setValue:@"12" forKey:@"age"];
                break;
        }
        
        vc.selectedChildAgeForCalculation = selectedChildAge;
    }
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

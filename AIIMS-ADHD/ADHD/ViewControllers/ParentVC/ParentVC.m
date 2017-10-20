//
//  ParentVC.m
//  ADHD
//
//  Created by Apple on 05/02/17.
//  Copyright © 2017 Apple. All rights reserved.
//

#import "ParentVC.h"
#import "InfoVC.h"
#import "SupportVC.h"
#import "MoreAppsVC.h"

@interface ParentVC ()

@end

@implementation ParentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = NO;
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    float height = self.view.frame.size.height * 0.1;
    viewBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - height, self.view.frame.size.width, height)];
    [self.view addSubview:viewBottomView];
    [self addButtonsToBottomView];
    
    [viewBottomView setBackgroundColor:[UIColor lightTextColor]];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:viewBottomView];
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.view bringSubviewToFront:viewBottomView];
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

#pragma mark - Methods Button Below

- (void) methodBack:(id)sender{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void) methodHome:(id)sender{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [Utilities showAlertwithTitle:kAlertTitle withMessage:kAlertGoToHome withButtonTitle:kAlertButtonOK withHandler:^(UIAlertAction *action) {
        [self methodReset:sender];
        [self.navigationController popToRootViewControllerAnimated:true];
    } andCancelButtonTitle:kAlertButtonCancel withHandler:nil withController:self];
}

- (void) methodSupport:(id)sender{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SupportVC *infoVC = [storyboard instantiateViewControllerWithIdentifier:@"SupportVC"];
    [[self navigationController] pushViewController:infoVC animated:true];
}

- (void) methodOtherApps:(id)sender{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MoreAppsVC *infoVC = [storyboard instantiateViewControllerWithIdentifier:@"MoreAppsVC"];
    [[self navigationController] pushViewController:infoVC animated:true];
}

- (void) methodInfo:(id)sender{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    InfoVC *infoVC = [storyboard instantiateViewControllerWithIdentifier:@"InfoVC"];
    [[self navigationController] pushViewController:infoVC animated:true];
}

- (void) methodReset:(id)sender{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"QuestionAnswers" ofType:@"plist"]];
    NSArray *arrayQuestionsSectionA;
    NSArray *arrayQuestionsSectionB;
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"age"]) {
        NSString *selectedAge = [[NSUserDefaults standardUserDefaults] valueForKey:@"age"];
        SelectedChildAge childAgeCal = kSelectedChildAgeNone;
        if ([selectedAge isEqualToString:@"13"]) {
            childAgeCal = kSelectedChildAgeAbove13;
        }else{
            childAgeCal = kSelectedChildAgeBelow13;
        }
        switch (childAgeCal) {
            case kSelectedChildAgeBelow13:
                arrayQuestionsSectionA = (NSArray*)[dictionary objectForKey:@"ArrayQuestionsBelow13SectionA"];
                arrayQuestionsSectionB = (NSArray*)[dictionary objectForKey:@"ArrayQuestionsBelow13SectionB"];
                break;
                
            case kSelectedChildAgeAbove13:
                arrayQuestionsSectionA = (NSArray*)[dictionary objectForKey:@"ArrayQuestionsAbove13SectionA"];
                arrayQuestionsSectionB = (NSArray*)[dictionary objectForKey:@"ArrayQuestionsAbove13SectionB"];
                break;
                
            default:
                break;
        }
        for (int i = 0; i < arrayQuestionsSectionA.count; i++) {
            NSDictionary *dictionaryQuestion = (NSDictionary*)[arrayQuestionsSectionA objectAtIndex:i];
            //        NSString *question = (NSString*)[dictionaryQuestion valueForKey:kKeyQuestion];
            NSString *questionNumberString = (NSString*)[dictionaryQuestion valueForKey:kKeyQuestionNumber];
            NSString *section = (NSString*)[dictionaryQuestion valueForKey:kKeySection];
            [[NSUserDefaults standardUserDefaults] setValue:nil forKey:[NSString stringWithFormat:@"%@_%@",section,questionNumberString]];
        }
        for (int i = 0; i < arrayQuestionsSectionB.count; i++) {
            NSDictionary *dictionaryQuestion = (NSDictionary*)[arrayQuestionsSectionB objectAtIndex:i];
            //        NSString *question = (NSString*)[dictionaryQuestion valueForKey:kKeyQuestion];
            NSString *questionNumberString = (NSString*)[dictionaryQuestion valueForKey:kKeyQuestionNumber];
            NSString *section = (NSString*)[dictionaryQuestion valueForKey:kKeySection];
            [[NSUserDefaults standardUserDefaults] setValue:nil forKey:[NSString stringWithFormat:@"%@_%@",section,questionNumberString]];
        }
    }
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"age"];
}


#pragma mark - Bottom View Actions

-(void) addButtonsToBottomView{
    int maximumNumberOfButtonsInMenu = 6;
    for (int i = 0; i < maximumNumberOfButtonsInMenu; i++){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        switch (i) {
            case 0:
                [button addTarget:self
                           action:@selector(methodBack:)
                 forControlEvents:UIControlEventTouchUpInside];
                [button setTitle:@"Back" forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"bottomBarBack"] forState:UIControlStateNormal];
                break;
                
            case 1:
                [button addTarget:self
                           action:@selector(methodHome:)
                 forControlEvents:UIControlEventTouchUpInside];
                [button setTitle:@"Home" forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"bottomBarHome"] forState:UIControlStateNormal];
                break;
                
            case 2:
                [button addTarget:self
                           action:@selector(methodSupport:)
                 forControlEvents:UIControlEventTouchUpInside];
                [button setTitle:@"Support" forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"bottomBarSupport"] forState:UIControlStateNormal];
                break;
                
            case 3:
                [button addTarget:self
                           action:@selector(methodOtherApps:)
                 forControlEvents:UIControlEventTouchUpInside];
                [button setTitle:@"Other Apps" forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"bottomBarOtherApps"] forState:UIControlStateNormal];
                break;
                
            case 4:
                [button addTarget:self
                           action:@selector(methodInfo:)
                 forControlEvents:UIControlEventTouchUpInside];
                [button setTitle:@"Info" forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"bottomBarInfo"] forState:UIControlStateNormal];
                break;
                
            case 5:
                [button addTarget:self
                           action:@selector(methodReset:)
                 forControlEvents:UIControlEventTouchUpInside];
                [button setTitle:@"Reset" forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"bottomBarReset"] forState:UIControlStateNormal];
                break;
                
            default:
                break;
        }
        
        CGFloat floatForSpacing = 1.0/maximumNumberOfButtonsInMenu;
        button.frame = CGRectMake(self.view.frame.size.width * i * floatForSpacing, 0.0, self.view.frame.size.width * floatForSpacing, self.view.frame.size.height * 0.1);
        
        
        button.titleLabel.numberOfLines = 2;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [viewBottomView addSubview:button];
        if ([Utilities isIPhone5S]) {
            button.titleLabel.font = [UIFont boldSystemFontOfSize:10];
        }else if ([Utilities isiPad]){
            button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        }else{
            button.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        }
        [self setButtonOffset:button];
    }
}

-(void) removeAllButtonsFromBottomView{
    for (UIView *view in viewBottomView.subviews) {
        [view removeFromSuperview];
    }
}

-(void) setButtonOffset:(UIButton *)button{
    CGFloat spacing = 4.0;
    
    // lower the text and push it left so it appears centered
    //  below the image
    CGSize imageSize = button.imageView.image.size;
    button.titleEdgeInsets = UIEdgeInsetsMake(
                                              0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
    
    // raise the image and push it right so it appears centered
    //  above the text
    CGSize titleSize = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: button.titleLabel.font}];
    button.imageEdgeInsets = UIEdgeInsetsMake(
                                              - (titleSize.height + spacing), 0.0, 0.0, - titleSize.width);
    
    // increase the content height to avoid clipping
    CGFloat edgeOffset = fabs(titleSize.height - imageSize.height) / 2.0;
    button.contentEdgeInsets = UIEdgeInsetsMake(edgeOffset, 0.0, edgeOffset, 0.0);
    
    [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
}

@end

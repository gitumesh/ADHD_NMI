//
//  QuestionsVC.m
//  ADHD
//
//  Created by Apple on 06/02/17.
//  Copyright © 2017 Apple. All rights reserved.
//

#import "QuestionsVC.h"
#import "ResultsVC.h"

@interface QuestionsVC ()

@property (weak, nonatomic) IBOutlet UILabel *labelQuestion1Numbering;
@property (weak, nonatomic) IBOutlet UILabel *labelQuestion1;

@property (weak, nonatomic) IBOutlet UILabel *labelQuestion2Numbering;
@property (weak, nonatomic) IBOutlet UILabel *labelQuestion2;

@property (weak, nonatomic) IBOutlet UILabel *labelQuestion1Yes;
@property (weak, nonatomic) IBOutlet UILabel *labelQuestion1No;
@property (weak, nonatomic) IBOutlet UIButton *buttonQuestion1Yes;
@property (weak, nonatomic) IBOutlet UIButton *buttonQuestion1No;

@property (weak, nonatomic) IBOutlet UILabel *labelQuestion2Yes;
@property (weak, nonatomic) IBOutlet UILabel *labelQuestion2No;
@property (weak, nonatomic) IBOutlet UIButton *buttonQuestion2Yes;
@property (weak, nonatomic) IBOutlet UIButton *buttonQuestion2No;


@end

@implementation QuestionsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    questionNumber = 0;
    [self setTitle:@"Question"];
    _sectionQuestion = kSectionQuestionA;
    [self readDataFromPlistAndCreateQuestionsAnswers];
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Read From Plist

-(void) readDataFromPlistAndCreateQuestionsAnswers{
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"QuestionAnswers" ofType:@"plist"]];
    switch (_selectedChildAgeForCalculation) {
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
    [self setQuestion1LabelForSection];
}

-(void) resetQuestionOptions{
    [self resetQuestion1Options];
}

-(void) resetQuestion1Options{
    [_buttonQuestion1No setImage:[UIImage imageNamed:kNameUnselectedImage] forState:UIControlStateNormal];
    [_buttonQuestion1Yes setImage:[UIImage imageNamed:kNameUnselectedImage] forState:UIControlStateNormal];
}

-(void) setQuestion1LabelForSection//:(SectionQuestion) section{
{
    switch (_sectionQuestion) {
        case kSectionQuestionA:{
            boolIsFirstQuestionAnswered = false;
            [self resetQuestionOptions];
            arrayForQuestions = arrayQuestionsSectionA;
            NSDictionary *dictionaryQuestion = (NSDictionary*)[arrayQuestionsSectionA objectAtIndex:questionNumber];
            stringQuestion = (NSString*)[dictionaryQuestion valueForKey:kKeyQuestion];
            stringQuestionNumber = (NSString*)[dictionaryQuestion valueForKey:kKeyQuestionNumber];
            stringSection = (NSString*)[dictionaryQuestion valueForKey:kKeySection];
            [self setTitleLabel];
            [_labelQuestion1 setText:stringQuestion];
            [_labelQuestion1Numbering setText:stringQuestionNumber];
            
            if ([self getAnswerForQuestionNumber:stringQuestionNumber andSection:stringSection] != nil) {
                NSString *answer = [self getAnswerForQuestionNumber:stringQuestionNumber andSection:stringSection];
                if ([answer isEqualToString:@"0"]) {
                    [_buttonQuestion1No setImage:[UIImage imageNamed:kNameSelectedImage] forState:UIControlStateNormal];
                }else{
                    [_buttonQuestion1Yes setImage:[UIImage imageNamed:kNameSelectedImage] forState:UIControlStateNormal];
                }
            }
        }
            break;
            
        default:
        {
            
            boolIsFirstQuestionAnswered = false;
            [self resetQuestionOptions];
            arrayForQuestions = arrayQuestionsSectionB;
            NSDictionary *dictionaryQuestion = (NSDictionary*)[arrayQuestionsSectionB objectAtIndex:questionNumber];
            stringQuestion = (NSString*)[dictionaryQuestion valueForKey:kKeyQuestion];
            stringQuestionNumber = (NSString*)[dictionaryQuestion valueForKey:kKeyQuestionNumber];
            stringSection = (NSString*)[dictionaryQuestion valueForKey:kKeySection];
            [self setTitleLabel];
            [_labelQuestion1 setText:stringQuestion];
            [_labelQuestion1Numbering setText:stringQuestionNumber];
            
            if ([self getAnswerForQuestionNumber:stringQuestionNumber andSection:stringSection] != nil) {
                NSString *answer = [self getAnswerForQuestionNumber:stringQuestionNumber andSection:stringSection];
                if ([answer isEqualToString:@"0"]) {
                    [_buttonQuestion1No setImage:[UIImage imageNamed:kNameSelectedImage] forState:UIControlStateNormal];
                }else{
                    [_buttonQuestion1Yes setImage:[UIImage imageNamed:kNameSelectedImage] forState:UIControlStateNormal];
                }
            }
        }
            break;
    }
}

-(void) setTitleLabel{
    [self setTitle:stringSection];
}

-(void) showQuestion1Label:(BOOL)show{
    [_labelQuestion1 setHidden:!show];
    [_labelQuestion1No setHidden:!show];
    [_labelQuestion1Yes setHidden:!show];
    [_labelQuestion1Numbering setHidden:!show];
    [_buttonQuestion1Yes setHidden:!show];
    [_buttonQuestion1No setHidden:!show];
}

#pragma mark - Button Actions Yes No

- (IBAction)actionYesButton1:(id)sender {
    [self saveAnswerForQuestionNumber:true];
    boolIsFirstQuestionAnswered = true;
    [self resetQuestion1Options];
    UIButton *buttonSelected = (UIButton*)sender;
    [buttonSelected setImage:[UIImage imageNamed:kNameSelectedImage] forState:UIControlStateNormal];
    [self checkForNextQuestion];
}

- (IBAction)actionNoButton1:(id)sender {
    [self saveAnswerForQuestionNumber:false];
    boolIsFirstQuestionAnswered = true;
    [self resetQuestion1Options];
    UIButton *buttonSelected = (UIButton*)sender;
    [buttonSelected setImage:[UIImage imageNamed:kNameSelectedImage] forState:UIControlStateNormal];
    [self checkForNextQuestion];
}

-(void) saveAnswerForQuestionNumber:(BOOL) answer{
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",answer] forKey:[NSString stringWithFormat:@"%@_%@",stringSection,stringQuestionNumber]];
}

-(NSString *)getAnswerForQuestionNumber:(NSString*) questionNumberString andSection:(NSString*) section {
    return [[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"%@_%@",section,questionNumberString]];
}

-(void) resetAllSavedAnswers{
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

-(void) checkForNextQuestion{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (boolIsFirstQuestionAnswered) {
            if (questionNumber < arrayForQuestions.count - 1) {
                questionNumber++;
                [self setQuestion1LabelForSection];
            }else{
                questionNumber = 0;
                switch (_sectionQuestion) {
                    case kSectionQuestionA:
                        [self completionOfSectionA];
                        break;
                        
                    default:
                        [self completionOfSectionB];
                        break;
                }
                
            }
        }
    });
}


#pragma mark - Methods Button Below
- (void) methodBack:(id)sender{
//    [Utilities showAlertwithTitle:kAlertTitle withMessage:kAlertMessageAreYouSure withButtonTitle:@"Ok" withHandler:^(UIAlertAction *action) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(),^{
            if (questionNumber > 0) {
                questionNumber--;
            }else{
                questionNumber = 0;
            }
            [self resetQuestionOptions];
            [self setQuestion1LabelForSection];
        });
//    } andCancelButtonTitle:@"Cancel" withHandler:^(UIAlertAction *action) {
        
//    } withController:self];
}

- (void) methodHome:(id)sender{
    [Utilities showAlertwithTitle:kAlertTitle withMessage:kAlertMessageAreYouSure withButtonTitle:@"Ok" withHandler:^(UIAlertAction *action) {
        [super methodReset:sender];
        [self.navigationController popToRootViewControllerAnimated:true];
    } andCancelButtonTitle:@"Cancel" withHandler:^(UIAlertAction *action) {
        
    } withController:self];
}

- (void) methodReset:(id)sender{
    [Utilities showAlertwithTitle:kAlertTitle withMessage:kAlertMessageAreYouSure withButtonTitle:@"Ok" withHandler:^(UIAlertAction *action) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(),^{
            questionNumber = 0;
            [self resetQuestionOptions];
            [self resetAllSavedAnswers];
            [self setQuestion1LabelForSection];
        });
    } andCancelButtonTitle:@"Cancel" withHandler:^(UIAlertAction *action) {
        
    } withController:self];
}

#pragma mark - Completion Of Section A

-(void) completionOfSectionA{
    NSLog(@"Section A completed");
    countYesInSectionA = 0;
    countYesInSectionA1 = 0;
    countYesInSectionA2 = 0;
    for (int i = 0; i < arrayQuestionsSectionA.count; i++) {
        NSDictionary *dictionaryQuestion = (NSDictionary*)[arrayQuestionsSectionA objectAtIndex:i];
        NSString *questionNumberString = (NSString*)[dictionaryQuestion valueForKey:kKeyQuestionNumber];
        NSString *section = (NSString*)[dictionaryQuestion valueForKey:kKeySection];
        BOOL answer = false;
        NSString* answerValue = [[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"%@_%@",section,questionNumberString]];
        if ([answerValue isEqualToString:@"0"]) {
            
        }else{
            answer = true;
        }
        NSLog(@"answerValue = %@",answerValue);
        NSLog(@"answer = %d",answer);
        NSLog(@"%@_%@",section,questionNumberString);
        if (answer) {
            countYesInSectionA += 1;
            NSLog(@"section = %@",section);
            NSLog(@"questionNumberString = %@",questionNumberString);
            if ([section containsString:@"A1"] || [section containsString:@"a1"] ) {
                countYesInSectionA1 += 1;
            }
            if ([section containsString:@"A2"] || [section containsString:@"a2"] ) {
                countYesInSectionA2 += 1;
            }
        }
    }
    if (countYesInSectionA >= 12) {
        result = @"Severe symptoms as per Conners Rating scale for ADHD. Tap to return";
        [self performSegueWithIdentifier:@"Result" sender:self];
    }else{
        if (countYesInSectionA1 >= 6 || countYesInSectionA2 >= 6) {
            _sectionQuestion = kSectionQuestionB;
            [self setQuestion1LabelForSection];
            [Utilities showAlertwithTitle:kAlertTitle withMessage:@"Move to section B for further queries." withButtonTitle:@"OK" withHandler:nil andCancelButtonTitle:nil withHandler:nil withController:self];
        }else{
                result = @"No Adhd present. Tap to return";
                [self performSegueWithIdentifier:@"Result" sender:self];
        }
        
    }
}

-(void) completionOfSectionB{
    int countYesInSectionB = 0;
    for (int i = 0; i < arrayQuestionsSectionB.count; i++) {
        NSDictionary *dictionaryQuestion = (NSDictionary*)[arrayQuestionsSectionB objectAtIndex:i];
        NSString *questionNumberString = (NSString*)[dictionaryQuestion valueForKey:kKeyQuestionNumber];
        NSString *section = (NSString*)[dictionaryQuestion valueForKey:kKeySection];
        BOOL answerValue = [[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"%@_%@",section,questionNumberString]];
        if (answerValue && i == arrayQuestionsSectionB.count - 1) {
            countYesInSectionB += 1;
        }else if (i == arrayQuestionsSectionB.count - 1 && !answerValue){
            countYesInSectionB += 1;
        }
        NSLog(@"countYesInSectionB = %d",countYesInSectionB);
    }
    switch (_selectedChildAgeForCalculation) {
        case kSelectedChildAgeBelow13:
        {
            if (countYesInSectionB == 3) { //ADHD present
                result = @"ADHD is present. Tap to return";
            }else{//ADHD absent
                result = @"No Adhd present. Tap to return";
            }
        }
            break;
            
        default:{
            if (countYesInSectionB == 4) { // ADHD present
                result = @"ADHD is present. Tap to return";
            }else{//ADHD absent
                result = @"No Adhd present. Tap to return";
            }
        }
            break;
    }
    [self performSegueWithIdentifier:@"Result" sender:self];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kSequeShowResults]) {
        ResultsVC *vc = (ResultsVC *)segue.destinationViewController;
        NSLog(@"result = %@",result);
        vc.result = result;
    }
}

@end

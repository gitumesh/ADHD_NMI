//
//  QuestionsVC.h
//  ADHD
//
//  Created by Apple on 06/02/17.
//  Copyright © 2017 Apple. All rights reserved.
//

#import "ParentVC.h"

@interface QuestionsVC : ParentVC{
    NSArray *arrayQuestionsSectionA;
    NSArray *arrayQuestionsSectionB;
    int questionNumber;
    NSArray *arrayForQuestions;
    BOOL boolIsFirstQuestionAnswered;
    NSString *stringQuestion;
    NSString *stringQuestionNumber;
    NSString *stringSection;
    NSString *result;
}

@property (nonatomic, assign) SelectedChildAge selectedChildAgeForCalculation;
@property (nonatomic, assign) SectionQuestion sectionQuestion;

@end

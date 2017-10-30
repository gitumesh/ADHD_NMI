//
//  Constants.h
//  ADHD
//
//  Created by Apple on 06/02/17.
//  Copyright © 2017 Apple. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

typedef enum SelectedChildAge{
    kSelectedChildAgeNone = 1,
    kSelectedChildAgeBelow13,
    kSelectedChildAgeAbove13,
}SelectedChildAge;

typedef enum SectionQuestion{
    kSectionQuestionA = 1,
    kSectionQuestionB
}SectionQuestion;

#define kSequeShowQuestionView          @"showQuestionView"
#define kSequeShowResults               @"Result"
#define kAlertTitle                     @"Alert!"
#define kAlertButtonOK                  @"Ok"
#define kAlertButtonCancel              @"Cancel"
#define kAlertGoToHome                  @"Are you sure you want to stop and go to home?"
#define kNameUnselectedImage            @"Selection-Unselected"
#define kNameSelectedImage              @"Selection-Selected"
#define kKeyQuestion                    @"Question"
#define kKeyQuestionNumber              @"QuestionNumber"
#define kKeySection                     @"Section"
#define kAlertMessageAreYouSure         @"Are you sure?"

#endif /* Constants_h */

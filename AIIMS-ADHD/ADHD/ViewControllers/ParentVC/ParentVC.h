//
//  ParentVC.h
//  ADHD
//
//  Created by Apple on 05/02/17.
//  Copyright © 2017 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utilities.h"
#import "Constants.h"

@interface ParentVC : UIViewController{
    UIView *viewBottomView;
}

- (void) methodBack:(id)sender;
- (void) methodHome:(id)sender;
- (void) methodSupport:(id)sender;
- (void) methodOtherApps:(id)sender;
- (void) methodInfo:(id)sender;
- (void) methodReset:(id)sender;

@end

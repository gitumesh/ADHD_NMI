//
//  Utilities.h
//  ADHD
//
//  Created by Apple on 05/02/17.
//  Copyright © 2017 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utilities : NSObject

+ (BOOL)isiPad;
+ (BOOL)isIPhone5S;

+(void)showAlertwithTitle:(NSString*)title withMessage:(NSString*)message withButtonTitle:(NSString*)buttonTitle withController:(UIViewController*)controller;
+(void)showAlertwithTitle:(NSString*)title withMessage:(NSString*)message withButtonTitle:(NSString*)buttonTitle withHandler:(void (^ __nullable)(UIAlertAction *action))handler withController:(UIViewController*)controller;
+(void)showAlertwithTitle:(NSString*)title withMessage:(NSString*)message withButtonTitle:(NSString*)buttonTitle withHandler:(void (^ __nullable)(UIAlertAction *action))handler andCancelButtonTitle:(NSString*)canceltitle withHandler:(void (^ __nullable)(UIAlertAction *action))cancelHandler withController:(UIViewController*)controller;

@end

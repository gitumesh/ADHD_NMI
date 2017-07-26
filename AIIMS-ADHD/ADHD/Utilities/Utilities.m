//
//  Utilities.m
//  ADHD
//
//  Created by Apple on 05/02/17.
//  Copyright © 2017 Apple. All rights reserved.
//

#import "Utilities.h"

#define ISIPHONE5 (fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON)

@implementation Utilities

+ (BOOL)isiPad{
    BOOL isiPad = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
    return isiPad;
}

+ (BOOL)isIPhone5S
{
    if (ISIPHONE5) return true;
    return false;
    
}

+(void)showAlertwithTitle:(NSString*)title withMessage:(NSString*)message withButtonTitle:(NSString*)buttonTitle withController:(UIViewController*)controller{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if(buttonTitle){
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleCancel handler:nil];
        
        [alertController addAction:alertAction];
    }
    
    if(controller){
        [controller presentViewController:alertController animated:YES completion:nil];
    }
}

+(void)showAlertwithTitle:(NSString*)title withMessage:(NSString*)message withButtonTitle:(NSString*)buttonTitle withHandler:(void (^ __nullable)(UIAlertAction *action))handler withController:(UIViewController*)controller{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if(buttonTitle){
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleCancel handler:handler];
        
        [alertController addAction:alertAction];
    }
    
    if(controller){
        [controller presentViewController:alertController animated:YES completion:nil];
    }
}

+(void)showAlertwithTitle:(NSString*)title withMessage:(NSString*)message withButtonTitle:(NSString*)buttonTitle withHandler:(void (^ __nullable)(UIAlertAction *action))handler andCancelButtonTitle:(NSString*)canceltitle withHandler:(void (^ __nullable)(UIAlertAction *action))cancelHandler withController:(UIViewController*)controller{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    
    if(buttonTitle){
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:handler];
        [alertController addAction:alertAction];
    }
    if(canceltitle){
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:canceltitle style:UIAlertActionStyleCancel handler:cancelHandler];
        [alertController addAction:alertAction];
    }
    
    if(controller){
        [controller presentViewController:alertController animated:YES completion:nil];
    }
}

@end

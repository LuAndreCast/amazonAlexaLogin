//
//  ViewController.h
//  AVSObjcFTW
//
//  Created by Luis Castillo on 5/3/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlexaAuthorizeUserDelegate.h"
#import "AlexaLogOutDelegate.h"

@interface AlexaLoginViewController : UIViewController
{
    
}
@property (weak, nonatomic) IBOutlet UIButton *amazonLoginButton;
@property (weak, nonatomic) IBOutlet UIProgressView *taskIndicator;
@property (weak, nonatomic) IBOutlet UILabel *taskLabel;


-(void)receivedToken:(NSString *)userToken withError:(NSString *)errorMessage;

-(void)updateLogOutStatus:(BOOL)userSignedIn withError:(NSString *)errorMessage;


@end


//
//  ViewController.h
//  AVSObjcFTW
//
//  Created by Luis Castillo on 5/3/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMZNAuthorizeUserDelegate.h"
#import "AMZNGetAccessTokenDelegate.h"
#import "UserViewController.h"

@interface LoginViewController : UIViewController
{
    
}
@property (weak, nonatomic) IBOutlet UIButton *amazonLoginButton;
@property (weak, nonatomic) IBOutlet UIProgressView *taskIndicator;
@property (weak, nonatomic) IBOutlet UILabel *taskLabel;



-(void)updateSignInStatus:(BOOL)userSignedIn withError:(NSString *)errorMessage;
-(void)receiveProfileData:(NSDictionary *) profile withError:(NSString *)errorMessage;



@end


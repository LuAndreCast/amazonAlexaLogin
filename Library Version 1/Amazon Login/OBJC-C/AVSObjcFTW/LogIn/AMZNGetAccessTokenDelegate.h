//
//  AMZNGetAccessTokenDelegate.h
//  AVSObjcFTW
//
//  Created by Luis Castillo on 5/3/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LoginWithAmazon/LoginWithAmazon.h>
#import "AMZNGetProfileProfileDelegate.h"
#import "LoginViewController.h"
@class LoginViewController;

@interface AMZNGetAccessTokenDelegate : NSObject<AIAuthenticationDelegate>

-(id)initWithParentController:(LoginViewController *) controller;

@end

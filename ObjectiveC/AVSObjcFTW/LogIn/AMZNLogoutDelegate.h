//
//  AMZNLogoutDelegate.h
//  AVSObjcFTW
//
//  Created by Luis Castillo on 5/3/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LoginWithAmazon/LoginWithAmazon.h>
#import "UserViewController.h"
@class UserViewController;

@interface AMZNLogoutDelegate : NSObject<AIAuthenticationDelegate>

-(id)initWithParentController:(UserViewController *) controller;


@end

//
//  UserViewController.h
//  AVSObjcFTW
//
//  Created by Luis Castillo on 5/4/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import <LoginWithAmazon/LoginWithAmazon.h>
#import "AMZNLogoutDelegate.h"

@interface UserViewController : UIViewController


@property (nonatomic , strong) NSDictionary * profileData;




-(void)updateLogOutStatus:(BOOL)userSignedIn withError:(NSString *)errorMessage;

@end

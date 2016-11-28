//
//  GetAccessTokenDelegate.h
//  AVSObjcFTW
//
//  Created by Luis Castillo on 5/9/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LoginWithAmazon/LoginWithAmazon.h>

#import "AlexaLoginViewController.h"
@class AlexaLoginViewController;


@interface AlexaGetAccessTokenDelegate : NSObject<AIAuthenticationDelegate>


-(id)initWithParentController:(AlexaLoginViewController *) controller;


@end

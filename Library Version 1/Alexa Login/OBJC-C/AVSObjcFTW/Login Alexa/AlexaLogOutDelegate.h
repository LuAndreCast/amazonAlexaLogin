//
//  AlexaLogOutDelegate.h
//  AVSObjcFTW
//
//  Created by Luis Castillo on 6/7/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AlexaLoginViewController.h"
@class AlexaLoginViewController;


@interface AlexaLogOutDelegate : NSObject<AIAuthenticationDelegate>

-(id)initWithParentController:(AlexaLoginViewController *) controller;


@end

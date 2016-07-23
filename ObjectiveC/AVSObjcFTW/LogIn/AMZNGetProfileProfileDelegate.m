//
//  AMZNGetProfileProfileDelegate.m
//  AVSObjcFTW
//
//  Created by Luis Castillo on 5/3/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "AMZNGetProfileProfileDelegate.h"

@implementation AMZNGetProfileProfileDelegate
{
    LoginViewController * parentController;
}

-(id)initWithParentController:(LoginViewController *) controller
{
    self = [super init];
    if (self) {
        self->parentController = controller;
    }
    return self;
    
}//eom


#pragma mark - results


-(void)requestDidSucceed:(APIResult *)apiResult
{
    /** Refers to `[AIMobileLib getProfile:]` */
    if ( apiResult.api ==  kAPIGetProfile )
    {
        NSDictionary * profile  = (NSDictionary *)apiResult.result;
       
        [parentController receiveProfileData:profile withError:nil];
    }
    else
    {
        NSLog(@"unknown result");
        NSLog(@"%@", [apiResult debugDescription]);
        
        [parentController receiveProfileData:nil withError:@"unknown result"];
    }
    
}//eom

-(void)requestDidFail:(APIError *)errorResponse
{
    [parentController receiveProfileData:nil withError:errorResponse.error.message];
    
    //app is not authorize, revert back to login page
    if ( errorResponse.error.code == kAIApplicationNotAuthorized)
    {
        NSLog(@"Application is not authorized to use this amazon account");
    }
    //
    else
    {
        NSLog(@"Error requesting profile : %@", errorResponse.error.message);
    }
    
}//eom

@end

//
//  AMZNGetAccessTokenDelegate.m
//  AVSObjcFTW
//
//  Created by Luis Castillo on 5/3/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "AMZNGetAccessTokenDelegate.h"

@implementation AMZNGetAccessTokenDelegate
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
    /** Refers to `[AIMobileLib getAccessTokenForScopes:withOverrideParams:delegate:]` */
    if ( apiResult.api ==  kAPIGetAccessToken )
    {
        AMZNGetProfileProfileDelegate * profileDelegate =  [[AMZNGetProfileProfileDelegate alloc]initWithParentController:parentController];
        [AIMobileLib getProfile:profileDelegate];
    }
    else
    {
        
        [parentController updateSignInStatus:false withError:@"unknown result"];
        
        NSLog(@"unknown result");
        NSLog(@"%@", [apiResult debugDescription]);
    }
}//eom


-(void)requestDidFail:(APIError *)errorResponse
{
    
    [parentController updateSignInStatus:false withError:errorResponse.error.message];
    
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

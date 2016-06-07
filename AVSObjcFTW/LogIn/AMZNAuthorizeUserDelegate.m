//
//  AMZNAuthorizeUserDelegate.m
//  AVSObjcFTW
//
//  Created by Luis Castillo on 5/3/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "AMZNAuthorizeUserDelegate.h"


@implementation AMZNAuthorizeUserDelegate
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
    /** Refers to `[AIMobileLib authorizeUserForScopes:delegate:]` */
    if ( apiResult.api ==  kAPIAuthorizeUser )
    {
        AMZNGetProfileProfileDelegate * profileDelegate =  [[AMZNGetProfileProfileDelegate alloc]initWithParentController:parentController];
        [AIMobileLib getProfile:profileDelegate];
        
        [parentController updateSignInStatus:true withError:nil];
    }
    /** Refers to `[AIMobileLib getAccessTokenForScopes:withOverrideParams:delegate:]` */
    else if ( apiResult.api ==  kAPIGetAccessToken )
    {
        NSLog(@"app is still authorized");[parentController updateSignInStatus:true withError:nil];
    }
    /** Refers to `[AIMobileLib clearAuthorizationState:]` */
    else if ( apiResult.api ==  kAPIClearAuthorizationState )
    {
        NSLog(@"successfully signout");[parentController updateSignInStatus:false withError:nil];
    }
    /** Refers to `[AIMobileLib getProfile:]` */
    else if ( apiResult.api ==  kAPIGetProfile )
    {
        NSDictionary * profile  = (NSDictionary *)apiResult.result;
        
        [parentController receiveProfileData:profile withError:nil];
    }
    /** Refers to `[AIMobileLib authorizeUserForScopes:delegate:options]` */
    else if ( apiResult.api ==  kAPIGetAuthorizationCode )
    {
    
    }
    else
    {
        NSLog(@"unknown result");
        [parentController updateSignInStatus:false withError:@"unknown result"];
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

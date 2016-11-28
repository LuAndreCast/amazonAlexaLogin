//
//  AlexaLogOutDelegate.m
//  AVSObjcFTW
//
//  Created by Luis Castillo on 6/7/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "AlexaLogOutDelegate.h"

@implementation AlexaLogOutDelegate
{
    AlexaLoginViewController * parentController;
}

-(id)initWithParentController:(AlexaLoginViewController *) controller
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
    ///** Refers to `[AIMobileLib clearAuthorizationState:]` */
    if ( apiResult.api ==  kAPIClearAuthorizationState )
    {
        NSLog(@"successfully signout");
        [parentController updateLogOutStatus:true withError:nil];
    }
    else
    {
        NSLog(@"unknown result");
        NSLog(@"%@", [apiResult debugDescription]);
        [parentController updateLogOutStatus:false withError:@"unknown result"];
    }
}//eom


-(void)requestDidFail:(APIError *)errorResponse
{
    
    [parentController updateLogOutStatus:false withError:errorResponse.error.message];
    
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

//
///** Refers to `[AIMobileLib authorizeUserForScopes:delegate:]` */
//if ( apiResult.api ==  kAPIAuthorizeUser )
//{
//     NSLog(@"successfully signin");
//}
///** Refers to `[AIMobileLib getAccessTokenForScopes:withOverrideParams:delegate:]` */
//else if ( apiResult.api ==  kAPIGetAccessToken )
//{
//    //the result here specifies if the app is still authorized.
//}
///** Refers to `[AIMobileLib clearAuthorizationState:]` */
//else if ( apiResult.api ==  kAPIClearAuthorizationState )
//{
//   NSLog(@"successfully signout");
//}
///** Refers to `[AIMobileLib getProfile:]` */
//else if ( apiResult.api ==  kAPIGetProfile )
//{
//     NSLog(@"successfully obtained profile data");
//}
///** Refers to `[AIMobileLib authorizeUserForScopes:delegate:options]` */
//else if ( apiResult.api ==  kAPIGetAuthorizationCode )
//{
//
//}
//else
//{
//    NSLog(@"unknown result");
//    NSLog(@"%@", [apiResult debugDescription]);
//}



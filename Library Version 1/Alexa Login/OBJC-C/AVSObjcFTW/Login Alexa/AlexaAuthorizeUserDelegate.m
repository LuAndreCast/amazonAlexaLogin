//
//  AuthorizeUserDelegate.m
//  AVSObjcFTW
//
//  Created by Luis Castillo on 5/9/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "AlexaAuthorizeUserDelegate.h"

@implementation AlexaAuthorizeUserDelegate
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
    //NSLog(@"[%@]  %@\n", self, apiResult);

    AlexaGetAccessTokenDelegate * delegate = [[AlexaGetAccessTokenDelegate alloc]initWithParentController:parentController];
    
    NSArray * requestScopes = [NSArray arrayWithObjects:@"alexa:all", nil];
                               
    [AIMobileLib getAccessTokenForScopes:requestScopes withOverrideParams:nil delegate:delegate];
    
}//eom

-(void)requestDidFail:(APIError *)errorResponse
{
    [parentController receivedToken:nil withError:errorResponse.error.message];
}//eom

@end

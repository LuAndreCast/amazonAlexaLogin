//
//  GetAccessTokenDelegate.m
//  AVSObjcFTW
//
//  Created by Luis Castillo on 5/9/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "AlexaGetAccessTokenDelegate.h"

@implementation AlexaGetAccessTokenDelegate
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
    //NSLog(@"\n[%@]  %@\n", self, apiResult.result);
    
    NSString * accessToken = apiResult.result;
    if ( [accessToken length] > 0  )
    {
        [parentController receivedToken:accessToken withError:nil];
    }
    else
    {
        [parentController receivedToken:nil withError:nil];
    }
}//eom

-(void)requestDidFail:(APIError *)errorResponse
{
    [parentController receivedToken:nil withError:errorResponse.error.message];
}//eom


@end

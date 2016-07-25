//
//  ViewController.m
//  AVSObjcFTW
//
//  Created by Luis Castillo on 5/3/16.
//  Copyright © 2016 LC. All rights reserved.
//


#import "AlexaLoginViewController.h"
#import <LoginWithAmazon/LoginWithAmazon.h>

//NEEDED FOR COMPANION APPROACH
//#import <CommonCrypto/CommonDigest.h>


//Constants
NSString *const AlexaTASKAuthorization = @"Obtaining Authrization";
NSString *const AlexaTASKUserProfile = @"Obtaining User Profile";
NSString *const AlexaTASKCompleted = @" ";



@interface AlexaLoginViewController ()
{
    AlexaAuthorizeUserDelegate * loginDelegate;
    
    
    NSArray *requestScopes;
    NSString * deviceSerialNumber;
    NSString* scopeData;
    NSString * productId; //This can be obtained at amazon developer website
}
@end

@implementation AlexaLoginViewController

@synthesize amazonLoginButton;
@synthesize taskLabel, taskIndicator;




#pragma mark - View Loading

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //setting delegates
    loginDelegate = [[AlexaAuthorizeUserDelegate alloc] initWithParentController:self];
    
    //UI stuff
    [taskIndicator setHidden:true];
    [taskLabel setHidden:true];
    taskLabel .text         = AlexaTASKAuthorization;
    taskIndicator .progress = 0.0;
    [amazonLoginButton setHidden:true];
    
    
    //to be used when calling amazon login
    
    productId           = @"ENTER HERE"; //THIS CAN BE OBTAINED AT THE Amazon Developer website
    deviceSerialNumber  = @"plpFTW"; //THIS SHOULD BE UNIQUE every time
    
    requestScopes       = [NSArray arrayWithObjects:@"alexa:all", nil];
    scopeData           = [NSString stringWithFormat:@"{\"alexa:all\":{\"productID\":\"%@\", "
                           "\"productInstanceAttributes\":{\"deviceSerialNumber\":\"%@\"}}}",
                           productId, deviceSerialNumber];

}//eom

-(void)viewDidAppear:(BOOL)animated
{
    [self checkIfUserSignedIn];
}//eom

#pragma mark - Memory
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}//eom


#pragma mark - Log In
- (IBAction)login:(UIButton *)sender
{
    //sign-out
    if (sender.selected == true) {
        
        [AIMobileLib clearAuthorizationState:loginDelegate];
        
        sender.selected = false;
    }
    //sign-in
    else
    {
        [self authorizeUserAndGetAccessToken];
        
        taskLabel .text = AlexaTASKAuthorization;
        taskIndicator .progress = 0.3;
        [taskIndicator setHidden:false];
        [taskLabel setHidden:false];
        
        sender.selected = true;
    }
}//eo-a


-(void)receivedToken:(NSString *)userToken withError:(NSString *)errorMessage
{
    if (errorMessage != nil )
    {
        NSLog(@"%@",errorMessage);
        
        //lets try to sign out - just incase
        AlexaLogOutDelegate * delegate = [[AlexaLogOutDelegate alloc]initWithParentController:self];
        [AIMobileLib clearAuthorizationState:delegate];
    }
    else
    {
        NSLog(@"%@", userToken);
        [self performSegueWithIdentifier:@"avsAlexaHome" sender:nil];
    }
}//eom

#pragma mark: Helpers

-(void)checkIfUserSignedIn
{
    AlexaGetAccessTokenDelegate * delegate = [[AlexaGetAccessTokenDelegate alloc]initWithParentController:self];
    
    [AIMobileLib getAccessTokenForScopes:requestScopes withOverrideParams:nil delegate:delegate];
}//eom

-(void)authorizeUserAndGetAccessToken
{
    NSMutableDictionary *options    = [[NSMutableDictionary alloc] init];
 
    options[kAIOptionScopeData] = scopeData;
    
    [AIMobileLib authorizeUserForScopes:requestScopes delegate:loginDelegate options:options];
}//eom


#pragma mark: Delegates
-(void)updateLogOutStatus:(BOOL)userSignedOut withError:(NSString *)errorMessage
{
    if ([errorMessage length] > 0)
    {
        NSLog(@"%@", errorMessage);
    }
    
    if (userSignedOut)
    {
        [amazonLoginButton setHidden:false];
    }
    
}//eom


/*
 BELOW IS FOR AVS COMPANION APPROACH 
 
    Have not tried this approach so be warned of the methods below!!
 */

//        NSArray *requestScopes          = [NSArray arrayWithObjects:@"alexa:all", nil];
//
//        NSString * codeChallenge = [self createCodeChallenge:@"codeChallengeFTW"];
//
//        NSString * productId            = @"UNIQUE value here";
//        NSString * deviceSerialNumber   = @"plpFTW";
//
//
//        NSMutableDictionary *options    = [[NSMutableDictionary alloc] init];
//
//
//        NSString* scopeData = [NSString stringWithFormat:@"{\"alexa:all\":{\"productID\":\"%@\","
//                               "\"productInstanceAttributes\":{\"deviceSerialNumber\":\"%@\"}}}",
//                               productId, deviceSerialNumber];
//
//        options[kAIOptionScopeData] = scopeData;
//        options[kAIOptionReturnAuthCode] = @YES;
//        options[kAIOptionCodeChallenge] = codeChallenge;
//        options[kAIOptionCodeChallengeMethod] = @"S256";



//-(NSData*) sha256:(NSData*)dataIn
//{
//    NSMutableData *dataOut = [[NSMutableData alloc] initWithCapacity: CC_SHA256_DIGEST_LENGTH];
//    CC_SHA256(dataIn.bytes, dataIn.length, dataOut.mutableBytes);
//    return dataOut;
//}//eom
//
//-(NSString *)createCodeChallenge:(NSString *) codeWord
//{
//    NSData * startCode = [codeWord dataUsingEncoding:NSUTF8StringEncoding];
//
//    NSData * encryptedCode  = [self sha256:startCode];
//
//    NSString * finalCode = [encryptedCode base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//
//    return finalCode;
//}//eom

@end

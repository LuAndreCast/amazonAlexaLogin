//
//  ViewController.m
//  AVSObjcFTW
//
//  Created by Luis Castillo on 5/3/16.
//  Copyright © 2016 LC. All rights reserved.
//


#import "LoginViewController.h"
#import <LoginWithAmazon/LoginWithAmazon.h>


//Constants
NSString *const TASKAuthorization = @"Obtaining Authrization";
NSString *const TASKUserProfile = @"Obtaining User Profile";
NSString *const TASKCompleted = @" ";



@interface LoginViewController ()
{
        AMZNAuthorizeUserDelegate * loginDelegate;
        NSArray * requests;
}
@end

@implementation LoginViewController

@synthesize amazonLoginButton;
@synthesize taskLabel, taskIndicator;




#pragma mark - View Loading

- (void)viewDidLoad {
    [super viewDidLoad];
    
    loginDelegate = [[AMZNAuthorizeUserDelegate alloc] initWithParentController:self];
    
    requests = [[NSArray alloc]initWithObjects:@"profile", @"postal_code", nil];
    
    //UI Stuff
    [taskIndicator setHidden:true];
    [taskLabel setHidden:true];
    taskLabel .text         = TASKAuthorization;
    taskIndicator .progress = 0.0;
    [amazonLoginButton setHidden:true];
}//eom

-(void)viewDidAppear:(BOOL)animated
{
     [self checkIfUserSignedIn];
}//eom

#pragma mark - Memory
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Log In
- (IBAction)login:(UIButton *)sender {
    
    //sign-out
    if (sender.selected == true) {
        
        
        [AIMobileLib clearAuthorizationState:loginDelegate];
        
        sender.selected = false;
    }
    //sign-in
    else
    {
        [AIMobileLib authorizeUserForScopes:requests delegate:loginDelegate];
        
        taskLabel .text = TASKAuthorization;
        taskIndicator .progress = 0.3;
        [taskIndicator setHidden:false];
        [taskLabel setHidden:false];
        
        
        sender.selected = true;
    }
}//eo-a

-(void)checkIfUserSignedIn
{
   AMZNGetAccessTokenDelegate * tokenDelegate = [[AMZNGetAccessTokenDelegate alloc]initWithParentController:self];
    
    [AIMobileLib getAccessTokenForScopes:requests withOverrideParams:nil delegate:tokenDelegate];
}//eom

-(void)updateSignInStatus:(BOOL)userSignedIn withError:(NSString *)errorMessage
{
    if(userSignedIn == false)
    {
        [amazonLoginButton setHidden:false];
        
        [taskIndicator setHidden:true];
        [taskLabel setHidden:true];
        taskLabel .text = TASKAuthorization;
        taskIndicator .progress = 0.0;
    }
    else
    {
        [amazonLoginButton setHidden:true];
        taskLabel .text = TASKUserProfile;
        taskIndicator .progress = 0.5;
        [taskIndicator setHidden:false];
        [taskLabel setHidden:false];
    }
}//eom

-(void)receiveProfileData:(NSDictionary * ) profile withError:(NSString *)errorMessage;
{
    taskIndicator .progress = 0.8;
    
    if ([errorMessage length] > 0) {
        NSLog(@"%@", errorMessage);
        
        [taskIndicator setHidden:true];
        [taskLabel setHidden:true];
        taskLabel .text = TASKAuthorization;
        taskIndicator .progress = 0.0;
    }
    else
    {
        taskLabel .text = TASKCompleted;
        taskIndicator .progress = 1.0;
       
        //go to next view
        UserViewController * userVC = (UserViewController*) [self.storyboard instantiateViewControllerWithIdentifier:@"userVC"] ;
        userVC .profileData = profile;
        
        [self presentViewController:userVC animated:true completion:nil];
    }//eom
    
}//eom



@end

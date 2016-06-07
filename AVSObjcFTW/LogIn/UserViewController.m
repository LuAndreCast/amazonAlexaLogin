//
//  UserViewController.m
//  AVSObjcFTW
//
//  Created by Luis Castillo on 5/4/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "UserViewController.h"

@interface UserViewController ()

@end

@implementation UserViewController

@synthesize profileData;


#pragma mark - View Loading

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString * name         = [profileData objectForKey:@"name"];
    NSString * email        = [profileData objectForKey:@"email"];
    NSString * user_id      = [profileData objectForKey:@"user_id"];
    NSString * zipcode      = [profileData objectForKey:@"postal_code"];
    
    NSLog(@"name: %@", name);
    NSLog(@"email: %@", email);
    NSLog(@"user_id: %@", user_id);
    NSLog(@"zipcode: %@", zipcode);
}//eom


#pragma mark - Memory
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Log Out
- (IBAction)logOut:(UIButton *)sender
{
    //log out already requested
    if (sender .selected == true) {
       //do nothing
        sender .selected = false;
    }
    else
    {
        //loggin out
        AMZNLogoutDelegate * logOutDelegate = [[AMZNLogoutDelegate alloc]initWithParentController:self];
        [AIMobileLib clearAuthorizationState:logOutDelegate];
        
        sender .selected = true;
    }
}//eom

-(void)updateLogOutStatus:(BOOL)userSignedIn withError:(NSString *)errorMessage
{
    if ([errorMessage length] > 0)
    {
        NSLog(@"%@", errorMessage);
    }
    else
    {
       LoginViewController * loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
        
        [self presentViewController:loginVC animated:true completion:nil];
    }
}//eom


#pragma mark - 


@end

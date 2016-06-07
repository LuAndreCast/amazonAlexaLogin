//
//  HomeViewController.m
//  AVSObjcFTW
//
//  Created by Luis Castillo on 5/9/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "AlexaHomeViewController.h"



@interface AlexaHomeViewController ()
{
    
}
@end

@implementation AlexaHomeViewController


@synthesize askAlexaButton;
@synthesize settingsButton;



#pragma mark - View Loading
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [askAlexaButton setSelected:false];
    
    
    
    //button actions
    UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc]init];
    longPress.minimumPressDuration = 0.1;
    
    [longPress addTarget:self action:@selector(askAlexa:)];
    [askAlexaButton addGestureRecognizer:longPress];
}///eom


#pragma mark - Ask
-(void)askAlexa:(id)sender
{
    /*  Start communicating with Alexa!!!  */
}//eom


- (IBAction)recordSpeech:(id)sender {
    
    //stop recording
    if ( [askAlexaButton isSelected] == true)
    {
        NSLog(@"stopping");
        
        [askAlexaButton setSelected:false];
    }
    //start recording
    else
    {
        NSLog(@"starting");
        
        [askAlexaButton setSelected:true];
    }
}//eo-a

@end

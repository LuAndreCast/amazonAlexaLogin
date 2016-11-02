//
//  ViewController.swift
//  AmazonLoginSwift
//
//  Created by Luis Castillo on 7/22/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, AmazonLoginResultsDelegate {

    let amazonLogin:AmazonLogin =  AmazonLogin.sharedInstance
    
    //MARK: Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        amazonLogin.delegate = self
    }//eom

    
    override func viewDidAppear(_ animated: Bool)
    {
        amazonLogin.checkAlexaUserStatus()
    }//eom
    
    //MARK: - Login
    @IBAction func login(_ sender: UIButton)
    {
        amazonLogin.requestALEXAauth()
    }//eo-a

    //MARK: - Login Results
    func authorizationResult(_ success: Bool, accessToken: String?, error: String?) {
        if success
        {
            print("access token: \(accessToken)")
            
//            if alexaSwitch.on == false {
//                amazonLogin.requestProfile()
//            }
        }
        else
        {
            print("\(error)")
        }
    }//eom
    
    
    func logOutResult(_ success: Bool, error: String?) {
        if error == nil {
            print("successfully signed out")
        }
        else
        {
            print("error: \(error)")
        }
    }//eom
    

    
    //MARK: - Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


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

    
    override func viewDidAppear(animated: Bool)
    {
        
    }//eom
    
    //MARK: - Login
    @IBAction func login(sender: UIButton)
    {
       amazonLogin.requestAuth()
    }//eo-a

    //MARK: - Login Results
    func authorizationResult(success: Bool, accessToken: String?, error: String?) {
        if success == false
        {
            print("\(error)")
        }
        else
        {
            print("authorization granted .... fetching profile data")
        }
    }//eom
    
    
    func logOutResult(success: Bool, error: String?) {
        if error == nil {
            print("successfully signed out")
        }
        else
        {
            print("error: \(error)")
        }
    }//eom
    
    
    func profileResult(success: Bool, profileDict: NSDictionary?, error: String?) {
        if error == nil {
            print("profile data: \(profileDict)")
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


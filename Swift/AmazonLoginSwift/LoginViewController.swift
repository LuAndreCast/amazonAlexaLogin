//
//  ViewController.swift
//  AmazonLoginSwift
//
//  Created by Luis Castillo on 7/22/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, AmazonLoginResultsDelegate {

    @IBOutlet weak var alexaSwitch: UISwitch!
    
    let amazonLogin:AmazonLogin =  AmazonLogin.sharedInstance
    
    //MARK: Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        amazonLogin.delegate = self
    }//eom

    
    override func viewDidAppear(animated: Bool)
    {
        amazonLogin.checkUserStatus()
    }//eom
    
    //MARK: - Login
    @IBAction func login(sender: UIButton)
    {
        //checking state
        if alexaSwitch.on {
           amazonLogin.requestALEXAauth()
        }
        else
        {
            amazonLogin.requestAuth()
        }
    }//eo-a

    //MARK: - Login Results
    func authorizationResult(success: Bool, accessToken: String?, error: String?) {
        
    }
    
    
    func logOutResult(success: Bool, error: String?) {
        
    }
    
    
    func profileResult(success: Bool, profileDict: NSDictionary?, error: String?) {
        
    }
    
    
    //MARK: - Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


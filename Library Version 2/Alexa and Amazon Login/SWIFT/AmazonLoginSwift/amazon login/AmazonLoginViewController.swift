//
//  AmazonLoginViewController.swift
//  AmazonLoginSwift
//
//  Created by Luis Castillo on 11/28/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit

class AmazonLoginViewController: UIViewController, AmazonAuthorizationRequestDelegate {

    @IBOutlet weak var alexaRequestSwitch: UISwitch!
    
    //models
    let amazonLogin:AmazonAuthorizationRequest = AmazonAuthorizationRequest.sharedInstance
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        amazonLogin.delegate = self
        amazonLogin.requestingAlexa = alexaRequestSwitch.isOn
        amazonLogin.amazon_checkUserPermission()
    }//eom
    
    
    @IBAction func changeAlexaRequest(_ sender: UISwitch)
    {
        amazonLogin.requestingAlexa = sender.isOn
    }//eo-a
    
    
    //MARK: - Login
    @IBAction func login(_ sender: UIButton)
    {
        amazonLogin.requestPermission()
    }//eo-a
    
    
    //MARK: - Logout
    @IBAction func logout(_ sender: UIButton)
    {
        amazonLogin.requestLogout()
    }//eo-a
    
    //MARK: - Delegates
    func amazonAuthorizationExistingAccess(_ success: Bool, accessToken: String?, error: String?)
    {
        if success
        {
            if amazonLogin.requestingAlexa
            {
                self.printAlexaInfo()
            }
            else
            {
                self.printAmazonInfo()
            }
        }
        else
        {
            print("error: \(error)")
        }
    }//eom
    
    func amazonAuthorizationLogin(_ success: Bool, processCancel: Bool, error: String?) {
        
        if success {
            if amazonLogin.requestingAlexa
            {
                self.printAlexaInfo()
            }
            else
            {
                self.printAmazonInfo()
            }
        }
        else
        {
            print("error: \(error)")
        }
    }//eom
    
    func amazonAuthorizationLogOut(_ success: Bool, error: String?)
    {
        if success
        {
            print("successfully logged out!")
        }
        else
        {
            print("failure logging out, error \(error)")
        }
    }//eom
    
    
    //MARK: - DEBUG
    func printAlexaInfo()
    {
        let accessToken:String? = amazonLogin.token
        print("accessToken: \(accessToken)")
    }//eom
    
    
    func printAmazonInfo()
    {
        let accessToken:String? = amazonLogin.token
        let clientId:String? = amazonLogin.clientId
        let authorizationCode:String? = amazonLogin.authorizationCode
        let redirectUri:String? = amazonLogin.redirectUri
        //
        let name:String? = amazonLogin.name
        let email:String? = amazonLogin.email
        let postalCode:String? = amazonLogin.postalCode
        let profile = amazonLogin.profile
        
        
        print("accessToken: \(accessToken)")
        print("clientId: \(clientId)")
        print("authorizationCode: \(authorizationCode)")
        print("redirectUri: \(redirectUri)")
        print("\n")
        print("name: \(name)")
        print("email: \(email)")
        print("postalCode: \(postalCode)")
        print("accessToken: \(postalCode)")
        print("profile: \(profile)")
    }//eom

}

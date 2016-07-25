//
//  AmazonLoginDelegate.swift
//  AmazonLoginSwift
//
//  Created by Luis Castillo on 7/23/16.
//  Copyright © 2016 LC. All rights reserved.
//

import Foundation

protocol AmazonLoginDelegate {
    
    func alexa_authorizationResult(success:Bool, error:String?)
    func alexa_accessTokenResult(success:Bool, accessToken:String?, error:String?)
    func logOutResult(success:Bool, error:String?)
}



protocol AmazonLoginResultsDelegate {
    
    func authorizationResult(success:Bool, accessToken:String?, error:String?)
    func logOutResult(success:Bool, error:String?)
}


class AmazonLogin:NSObject, AmazonLoginDelegate {
    static let sharedInstance = AmazonLogin()
    
    private let _delegate_AlexaAuthorize    = AMZNAlexaAuthorizeUserDelegate()
    private let _delegate_accessToken       = AMZNAlexaGetAccessTokenDelegate()
    private let _delegate_logout            = AMZNLogoutDelegate()
    
    //properties
    private let productID = "ENTER YOUR PRODUCT ID HERE" /* can be obtained at amazon developer website, the Device Type ID of the app */
    
    private var alexa_requestScope:[AnyObject]  = ["alexa:all"]
    private var alexa_options:[NSObject:AnyObject] = [:]
    
    var delegate:AmazonLoginResultsDelegate? = nil
    
    //MARK: - Constructor
    override init()
    {
        super.init()
        _delegate_AlexaAuthorize.delegate = self
        _delegate_accessToken.delegate  = self
        _delegate_logout.delegate       = self
        
        //must be unique everytime
        let uniqueDeviceSerialNumber = "makeMeUnique"
        
        let scopeData =  NSString(string: "{\"alexa:all\":{\"productID\":\"\(self.productID)\",\"productInstanceAttributes\":{\"deviceSerialNumber\":\"\(uniqueDeviceSerialNumber)\"}}}")
        
        self.alexa_options = [kAIOptionScopeData : scopeData]
    }//eom
    
    //MARK: - Check if User is Signed in
    func checkAlexaUserStatus()
    {
        self.requestAlexaAccessTokens()
    }//eom
    
    
    private func requestAlexaAccessTokens()
    {
        AIMobileLib.getAccessTokenForScopes(alexa_requestScope, withOverrideParams: alexa_options, delegate: _delegate_accessToken)
    }//eom
    func alexa_accessTokenResult(success: Bool, accessToken: String?, error:String?) {
        delegate?.authorizationResult(success,accessToken: accessToken, error: error)
    }//eom
    
    //MARK: - Alexa Authorization
    func requestALEXAauth()
    {
    AIMobileLib.authorizeUserForScopes(alexa_requestScope, delegate: _delegate_AlexaAuthorize, options: alexa_options)
    }//eom
    
    
    func alexa_authorizationResult(success: Bool, error: String?) {
        if success
        {
            self.requestAlexaAccessTokens()
        }
        else
        {
            //
            delegate?.authorizationResult(false, accessToken: nil, error:error)
        }
    }//eom
        
    //MARK: - Logout
    func requestLogOut()
    {
        AIMobileLib .clearAuthorizationState(_delegate_logout)
    }//eom
    
    func logOutResult(success: Bool,error:String?) {
        delegate?.logOutResult(success, error:error)
    }//eom
    
    
}//eoc
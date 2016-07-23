//
//  AmazonLoginDelegate.swift
//  AmazonLoginSwift
//
//  Created by Luis Castillo on 7/23/16.
//  Copyright © 2016 LC. All rights reserved.
//

import Foundation

protocol AmazonLoginDelegate {
    
    func authorizationResult(success:Bool, error:String?)
    func accessTokenResult(success:Bool, accessToken:String?, error:String?)
    func profileResult(success:Bool, profileDict:NSDictionary?, error:String?)
    func logOutResult(success:Bool, error:String?)
}



protocol AmazonLoginResultsDelegate {
    
    func authorizationResult(success:Bool, accessToken:String?, error:String?)
    func profileResult(success:Bool, profileDict:NSDictionary?, error:String?)
    func logOutResult(success:Bool, error:String?)
}


class AmazonLogin:NSObject, AmazonLoginDelegate {
    static let sharedInstance = AmazonLogin()
    
    private let _delegate_authorize     = AMZNAuthorizeUserDelegate()
    private let _delegate_accessToken   = AMZNGetAccessTokenDelegate()
    private let _delegate_profile       = AMZNGetProfileDelegate()
    private let _delegate_logout        = AMZNLogoutDelegate()
    
    //properties
    private let productID = "" /* can be obtained at amazon developer website  */
    
    private var amazon_requestScope:[AnyObject] = ["profile", "postal_code"]
    private var alexa_requestScope:[AnyObject]  = ["alexa:all"]
    
    var delegate:AmazonLoginResultsDelegate? = nil
    
    //MARK: - Constructor
    override init()
    {
        super.init()
        _delegate_authorize.delegate    = self
        _delegate_accessToken.delegate  = self
        _delegate_profile.delegate      = self
        _delegate_logout.delegate       = self
    }//eom
    
    //MARK: - Check User Login Status
    func checkUserStatus()
    {
        //TODO:
    }
    
    //MARK: - Authorization
    func requestAuth()
    {
        AIMobileLib .authorizeUserForScopes(amazon_requestScope, delegate: _delegate_authorize)
    }//eom
    
    func requestALEXAauth()
    {
        //must be unique everytime
        let uniqueDeviceSerialNumber = "makeMeUnique"
        
        let scopeData =  NSString(string: "{\"alexa:all\":{\"productID\":\"\(self.productID)\",\"productInstanceAttributes\":{\"deviceSerialNumber\":\"\(uniqueDeviceSerialNumber)\"}}}")
        
        let alexa_options:[NSObject:AnyObject] = [kAIOptionScopeData : scopeData]
        
        
        AIMobileLib.authorizeUserForScopes(alexa_requestScope, delegate: _delegate_authorize, options: alexa_options)
    }//eom
    
    func authorizationResult(success: Bool, error:String?) {
        if success {
            //requesting access token
            AIMobileLib .clearAuthorizationState(_delegate_logout)
        }
        else
        {
            //
            delegate?.authorizationResult(false, accessToken: nil, error:error)
        }
    }//eom
    
    
    //MARK:  Access Token
    func accessTokenResult(success: Bool, accessToken: String?, error:String?) {
        delegate?.authorizationResult(success,accessToken: accessToken, error: error)
    }//eom
    
    //MARK: - Profile
    func requestProfile()
    {
        AIMobileLib.getProfile(_delegate_profile)
    }//eom
    
    func profileResult(success: Bool, profileDict: NSDictionary?, error:String?)
    {
        delegate?.profileResult(success, profileDict: profileDict, error: error)
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
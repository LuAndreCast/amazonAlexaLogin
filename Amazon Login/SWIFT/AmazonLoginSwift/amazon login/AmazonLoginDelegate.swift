//
//  AmazonLoginDelegate.swift
//  AmazonLoginSwift
//
//  Created by Luis Castillo on 7/23/16.
//  Copyright © 2016 LC. All rights reserved.
//

import Foundation

protocol AmazonLoginDelegate {
    
    func amazon_AuthorizationResult(_ success:Bool, error:String?)
    func profileResult(_ success:Bool, profileDict:NSDictionary?, error:String?)
    func logOutResult(_ success:Bool, error:String?)
}



protocol AmazonLoginResultsDelegate {
    
    func authorizationResult(_ success:Bool, accessToken:String?, error:String?)
    func profileResult(_ success:Bool, profileDict:NSDictionary?, error:String?)
    func logOutResult(_ success:Bool, error:String?)
}


class AmazonLogin:NSObject, AmazonLoginDelegate {
    static let sharedInstance = AmazonLogin()
    
    fileprivate let _delegate_authorize         = AMZNAuthorizeUserDelegate()
    fileprivate let _delegate_profile           = AMZNGetProfileDelegate()
    fileprivate let _delegate_logout            = AMZNLogoutDelegate()
    
    //properties
    fileprivate var amazon_requestScope:[AnyObject] = ["profile" as AnyObject, "postal_code" as AnyObject]
    
    var delegate:AmazonLoginResultsDelegate? = nil
    
    //MARK: - Constructor
    override init()
    {
        super.init()
        _delegate_authorize.delegate    = self
        _delegate_profile.delegate      = self
        _delegate_logout.delegate       = self
    }//eom
    
    //MARK: - Amazon Authorization
    func requestAuth()
    {
        AIMobileLib .authorizeUser(forScopes: amazon_requestScope, delegate: _delegate_authorize)
    }//eom
    
    func amazon_AuthorizationResult(_ success: Bool, error: String?) {
        if success {
            //getting profile info
            AIMobileLib .getProfile(_delegate_profile)
        }
        else
        {
            //
            delegate?.authorizationResult(false, accessToken: nil, error:error)
        }
    }//eom
    
    
    //MARK: - Profile
    func requestProfile()
    {
        AIMobileLib.getProfile(_delegate_profile)
    }//eom
    
    func profileResult(_ success: Bool, profileDict: NSDictionary?, error:String?)
    {
        delegate?.profileResult(success, profileDict: profileDict, error: error)
    }//eom
    
    //MARK: - Logout
    func requestLogOut()
    {
        AIMobileLib .clearAuthorizationState(_delegate_logout)
    }//eom
    
    func logOutResult(_ success: Bool,error:String?) {
        delegate?.logOutResult(success, error:error)
    }//eom
    
    
}//eoc

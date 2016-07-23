//
//  AMZNAuthorizeUserDelegate.swift
//  AmazonLoginSwift
//
//  Created by Luis Castillo on 7/22/16.
//  Copyright © 2016 LC. All rights reserved.
//

import Foundation

class AMZNAuthorizeUserDelegate:NSObject, AIAuthenticationDelegate {
 
    var delegate:AmazonLoginDelegate? = nil
    
    //MARK: Delegates
    func requestDidSucceed(apiResult: APIResult!) {
       
        if apiResult.api == API.AuthorizeUser
        {
            delegate?.authorizationResult(true, error: nil)
        }
        else
        {
            let error = "un-able to authorize user"
            delegate?.authorizationResult(false, error: error)
        }
        
    }//eom
    
    
    func requestDidFail(errorResponse: APIError!) {
        let error = errorResponse.description
        delegate?.authorizationResult(false, error: error)
    }//eom
    
}//eoc
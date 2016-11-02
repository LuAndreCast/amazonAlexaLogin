//
//  AMZNAlexaAuthorizeUserDelegate.swift
//  AmazonLoginSwift
//
//  Created by Luis Castillo on 7/22/16.
//  Copyright © 2016 LC. All rights reserved.
//

import Foundation

class AMZNAlexaAuthorizeUserDelegate:NSObject, AIAuthenticationDelegate {
 
    var delegate:AmazonLoginDelegate? = nil
    
    //MARK: Delegates
    func requestDidSucceed(_ apiResult: APIResult!) {
       
        if apiResult.api == API.authorizeUser
        {
            delegate?.alexa_authorizationResult(true, error: nil)
        }
        else
        {
            let error = "un-able to authorize user"
            delegate?.alexa_authorizationResult(false, error: error)
        }
        
    }//eom
    
    
    func requestDidFail(_ errorResponse: APIError!) {
        let error = errorResponse.description
        delegate?.alexa_authorizationResult(false, error: error)
    }//eom
    
}//eoc

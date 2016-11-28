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
    func requestDidSucceed(_ apiResult: APIResult!) {
       
        if apiResult.api == API.authorizeUser
        {
            delegate?.amazon_AuthorizationResult(true, error: nil)
        }
        else
        {
            let error = "un-able to authorize user"
            delegate?.amazon_AuthorizationResult(false, error: error)
        }
        
    }//eom
    
    
    func requestDidFail(_ errorResponse: APIError!) {
        let error = errorResponse.description
        delegate?.amazon_AuthorizationResult(false, error: error)
    }//eom
    
}//eoc

//
//  AMZNLogoutDelegate.swift
//  AmazonLoginSwift
//
//  Created by Luis Castillo on 7/22/16.
//  Copyright © 2016 LC. All rights reserved.
//

import Foundation

class AMZNLogoutDelegate:NSObject, AIAuthenticationDelegate {
 
    var delegate:AmazonLoginDelegate? = nil
    
    //MARK: Delegates
    func requestDidSucceed(_ apiResult: APIResult!) {
        
        if apiResult.api == API.clearAuthorizationState {
            delegate?.logOutResult(true, error: nil)
        }
        else
        {
            let error = apiResult.result as? String
            delegate?.logOutResult(true, error: error)
        }
    }//eom
    
    func requestDidFail(_ errorResponse: APIError!) {
        let error = errorResponse.description
        delegate?.logOutResult(false, error:error)
    }//eom

}//eoc

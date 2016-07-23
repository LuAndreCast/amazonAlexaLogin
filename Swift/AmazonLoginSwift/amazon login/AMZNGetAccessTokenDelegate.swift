//
//  AMZNGetAccessTokenDelegate.swift
//  AmazonLoginSwift
//
//  Created by Luis Castillo on 7/22/16.
//  Copyright © 2016 LC. All rights reserved.
//

import Foundation

class AMZNGetAccessTokenDelegate:NSObject, AIAuthenticationDelegate {
 
    var delegate:AmazonLoginDelegate? = nil
    
    //MARK: Delegates
    func requestDidSucceed(apiResult: APIResult!)
    {
        let error = ""
        delegate?.accessTokenResult(false, accessToken: nil, error: error)
    }//eom
    
    func requestDidFail(errorResponse: APIError!)
    {
        let error = errorResponse.description
        delegate?.accessTokenResult(false, accessToken: nil, error: error)
    }//eom
    
}//eoc
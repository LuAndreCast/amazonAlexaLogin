//
//  AMZNGetAccessTokenDelegate.swift
//  AmazonLoginSwift
//
//  Created by Luis Castillo on 7/22/16.
//  Copyright © 2016 LC. All rights reserved.
//

import Foundation

class AMZNAlexaGetAccessTokenDelegate:NSObject, AIAuthenticationDelegate {
 
    var delegate:AmazonLoginDelegate? = nil
    
    //MARK: Delegates
    func requestDidSucceed(apiResult: APIResult!)
    {
        if let accessToken:String = apiResult.result as? String
        {
            delegate?.alexa_accessTokenResult(true, accessToken: accessToken, error: nil)
        }
        else
        {
            let error = "un-able to retrieve access token. unknown error"
            delegate?.alexa_accessTokenResult(false, accessToken: nil, error: error)
        }
    }//eom
    
    func requestDidFail(errorResponse: APIError!)
    {
        let error = "user not authorize. error: \(errorResponse.description)"
        delegate?.alexa_accessTokenResult(false, accessToken: nil, error: error)
    }//eom
    
}//eoc
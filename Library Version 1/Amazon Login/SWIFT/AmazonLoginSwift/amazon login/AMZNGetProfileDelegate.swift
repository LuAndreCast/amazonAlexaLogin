//
//  AMZNGetProfileDelegate.swift
//  AmazonLoginSwift
//
//  Created by Luis Castillo on 7/22/16.
//  Copyright © 2016 LC. All rights reserved.
//

import Foundation

class AMZNGetProfileDelegate:NSObject, AIAuthenticationDelegate {
 
    var delegate:AmazonLoginDelegate? = nil
    
    //MARK: Delegates
    func requestDidSucceed(_ apiResult: APIResult!)
    {
        if let userProfile:NSDictionary = apiResult.result as? NSDictionary
        {
            delegate?.profileResult(true, profileDict: userProfile, error: nil)
        }
        else
        {
            let error = "un-able to get user data"
            delegate?.profileResult(false, profileDict: nil, error: error)
        }
    }//eom
    
    
    func requestDidFail(_ errorResponse: APIError!) {
        let error = errorResponse.description
        delegate?.profileResult(false, profileDict: nil, error: error)
    }//eom
    
}//eoc

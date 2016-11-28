//
//  AmazonAuthorizationRequest.swift
//  AmazonLoginSwift
//
//  Created by Luis Castillo on 11/28/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit


/*
 Relays Status to ViewControllers
 */
protocol AmazonAuthorizationRequestDelegate
{
    func amazonAuthorizationExistingAccess(_ success:Bool, accessToken:String?, error:String?)
    func amazonAuthorizationLogin(_ success:Bool, processCancel:Bool, error:String?)
    func amazonAuthorizationLogOut(_ success:Bool, error:String?)
}

class AmazonAuthorizationRequest: NSObject {

    static let sharedInstance = AmazonAuthorizationRequest()
    
    var delegate:AmazonAuthorizationRequestDelegate?
    
    //MARK: - Properties
    /* the Device Type ID of the app located at amazon developer website */
    private let productID = "UPDATE ME"
    private let dateformatter:DateFormatter  = DateFormatter()
    
    
    public var requestingAlexa = true
    
    //amazon
    private var _authorizationCode:String?
    private var _clientId:String?
    private var _redirectUri:String?
    private var _token:String = ""  //alexa
    
    var authorizationCode:String? {
        return _authorizationCode
    }
    
    var clientId:String? {
        return _clientId
    }
    
    var redirectUri:String? {
        return _redirectUri
    }
    
    var token:String {
        return _token
    }
    
    //amazon user properties
    private var _userID:String?
    private var _postalCode:String?
    private var _profile:[AnyHashable:Any]?
    private var _email:String?
    private var _name:String?
    
    var userID:String? {
        return _userID
    }
    
    var name:String? {
        return _name
    }
    
    var postalCode:String? {
        return _postalCode
    }
    
    var profile:[AnyHashable:Any]? {
        return _profile
    }
    
    var email:String? {
        return _email
    }
    
    
    //MARK: - Constructor
    override init()
    {
        super.init()
       
        
        print("iOS Version Running: ", UIDevice.current.systemVersion)
    }//eom
    
    
    //MARK: - Auto
    /*!
     * @warning DO NOT CALL this method on ViewDidAppear - Infinite request will occur!
     */
    func checkPermission()
    {
        if requestingAlexa {
            self.alexa_checkUserPermission()
        }
        else
        {
            self.amazon_checkUserPermission()
        }
    }//eom
    
    func requestPermission()
    {
        if requestingAlexa {
            self.alexa_requestPermission()
        }
        else
        {
            self.amazon_requestPermission()
        }
    }//eom
    
    /*!
     * @warning This will remove all access including amazon and alexa
     */
    func requestLogout()
    {
        let signoutHandler:AMZNSignOutRequestHandler = { [weak self] error in
            if error != nil
            {
                self?.delegate?.amazonAuthorizationLogOut(false, error: error!.localizedDescription)
            }
            else
            {
                self?.delegate?.amazonAuthorizationLogOut(true, error: nil)
            }
        }//eo
        
        
        let manager = AMZNAuthorizationManager.shared()
        manager.signOut(signoutHandler)
    }//eom
    
    
    //MARK: - Amazon
    private func amazon_createRequest()->AMZNAuthorizeRequest
    {
        let scopes:[Any] = [
            AMZNProfileScope.userID(),
            AMZNProfileScope.postalCode(),
            AMZNProfileScope.profile()
        ]
        
        let amazonRequest:AMZNAuthorizeRequest = AMZNAuthorizeRequest()
        amazonRequest.scopes = scopes
        
        return amazonRequest
    }//eom
    
    func amazon_checkUserPermission()
    {
        let request = self.amazon_createRequest()
        request.interactiveStrategy = AMZNInteractiveStrategy.always
        
        let handler:AMZNAuthorizationRequestHandler =
        { result, userDidCancel, error in
            if error != nil
            {
                self.delegate?.amazonAuthorizationLogin(false, processCancel: false, error: error!.localizedDescription)
            }
            else if userDidCancel
            {
                let errorMessage:String = "Authorization was cancelled prior to completion. To continue, you will need to try logging in again."
                self.delegate?.amazonAuthorizationLogin(false, processCancel: true, error: errorMessage)
            }
            else if let amazon_userID:AMZNUser = result!.user
            {
                self._email         = amazon_userID.email
                self._name          = amazon_userID.name
                self._userID        = amazon_userID.userID
                self._postalCode    = amazon_userID.postalCode
                self._profile       = amazon_userID.profileData
                
                self.delegate?.amazonAuthorizationLogin(true, processCancel: false, error: nil)
                
                if result != nil
                {
                    self._token = result!.token
                    self._authorizationCode = result!.authorizationCode
                    self._clientId = result!.clientId
                    self._redirectUri = result!.redirectUri
                }
            }
            else
            {
                let errorMessage:String = "Unknown Error"
                self.delegate?.amazonAuthorizationLogin(false, processCancel: false, error: errorMessage)
            }
        }//eo
        
        self.authorize(request: request, withHandler: handler)
    }//eom
    
    func amazon_requestPermission()
    {
        let request = self.amazon_createRequest()
        request.interactiveStrategy = AMZNInteractiveStrategy.always
        
        let handler:AMZNAuthorizationRequestHandler = { [weak self] result, userDidCancel, error in
            if error != nil
            {
                self?.delegate?.amazonAuthorizationLogin(false, processCancel: false, error: error!.localizedDescription)
            }
            else if userDidCancel
            {
                let errorMessage:String = "Authorization was cancelled prior to completion. To continue, you will need to try logging in again."
                self?.delegate?.amazonAuthorizationLogin(false, processCancel: true, error: errorMessage)
            }
            else if let amazon_userID:AMZNUser = result!.user
            {
                self?._email         = amazon_userID.email
                self?._name          = amazon_userID.name
                self?._userID        = amazon_userID.userID
                self?._postalCode    = amazon_userID.postalCode
                self?._profile       = amazon_userID.profileData
                
                self?.delegate?.amazonAuthorizationLogin(true, processCancel: false, error: nil)
                
                if result != nil
                {
                    self?._token = result!.token
                    self?._authorizationCode = result!.authorizationCode
                    self?._clientId = result!.clientId
                    self?._redirectUri = result!.redirectUri
                }
            }
            else
            {
                let errorMessage:String = "Unknown Error"
                self?.delegate?.amazonAuthorizationLogin(false, processCancel: false, error: errorMessage)
            }
        }//eo
        
        self.authorize(request: request, withHandler: handler)
    }//eom
   
    
    //MARK: - Alexa
    private func alexa_createRequest()->AMZNAuthorizeRequest
    {
        //unique device serial number
        let time:Date = Date.init()
        dateformatter .dateFormat = "ddMMyyyy-hh-mm-ss-a"
        let currentDateString = dateformatter .string(from: time)
        
        let uniqueDeviceSerialNumber = "serialNumUniqe".appending(currentDateString)
        
        let scopeData_alexa:[AnyHashable:Any] = [
            "productID" : self.productID,
            "productInstanceAttributes": [ "deviceSerialNumber" : uniqueDeviceSerialNumber ]
        ]
        
        let scopeForAlexa = AMZNScopeFactory.scope(withName: "alexa:all", data: scopeData_alexa)
        let scopes_alexa:[Any] = [ scopeForAlexa ]
        
        let alexaRequest:AMZNAuthorizeRequest = AMZNAuthorizeRequest()
        alexaRequest.scopes = scopes_alexa
        
        //below is for Companion applications (Speakers etc)
        //        alexaRequest.codeChallenge
        //        alexaRequest.codeChallengeMethod
        //        alexaRequest.grantType = AMZNAuthorizationGrantType.token
        
        return alexaRequest
    }//eom
    
    func alexa_checkUserPermission()
    {
        let alexaRequest:AMZNAuthorizeRequest = self.alexa_createRequest()
        alexaRequest.interactiveStrategy = AMZNInteractiveStrategy.never
        
        let handler:AMZNAuthorizationRequestHandler = { [weak self] result, userDidCancel, error in
            if result != nil
            {
                self?._token = result!.token
                self?.delegate?.amazonAuthorizationExistingAccess(true, accessToken: result!.token, error: nil)
                
                self?._authorizationCode = result!.authorizationCode
                self?._clientId = result!.clientId
                self?._redirectUri = result!.redirectUri
            }
            else
            {
                let errorMessage:String = "the user is not authorized"
                self?.delegate?.amazonAuthorizationExistingAccess(false, accessToken: nil, error: errorMessage)
            }
        }//eo
        
        self.authorize(request: alexaRequest, withHandler: handler)
        
    }//eom
    
    func alexa_requestPermission()
    {
        let alexaRequest:AMZNAuthorizeRequest = self.alexa_createRequest()
        alexaRequest.interactiveStrategy = AMZNInteractiveStrategy.auto
        
        let handler:AMZNAuthorizationRequestHandler = { [weak self] result, userDidCancel, error in
            if error != nil
            {
                self?.delegate?.amazonAuthorizationLogin(false, processCancel: false, error: error!.localizedDescription)
            }
            else if userDidCancel
            {
                let errorMessage:String = "Authorization was cancelled prior to completion. To continue, you will need to try logging in again."
                self?.delegate?.amazonAuthorizationLogin(false, processCancel: true, error: errorMessage)
            }
            else if result != nil
            {
                self?._token = result!.token
                self?.delegate?.amazonAuthorizationLogin(true, processCancel: false, error: nil)
                
                self?._authorizationCode = result!.authorizationCode
                self?._clientId = result!.clientId
                self?._redirectUri = result!.redirectUri
            }
            else
            {
                let errorMessage:String = "Unknown Error"
                self?.delegate?.amazonAuthorizationLogin(false, processCancel: false, error: errorMessage)
            }
        }//eo
        
        self.authorize(request: alexaRequest, withHandler: handler)
    }//eom
    
    
    //MARK: - HELPERS
    private func authorize( request:AMZNAuthorizeRequest,
                    withHandler handler:@escaping AMZNAuthorizationRequestHandler )
    {
        let manager = AMZNAuthorizationManager.shared()
        manager.authorize(request, withHandler: handler)
    }//eom
    
    
    /*
     AMZNAuthorizeRequest Types:
         AMZNInteractiveStrategyAuto (default): The SDK looks for a locally stored authorization grant from previous authorize:withHandler: responses. If one is available, valid, and contains all requested scopes, the SDK will return a successful response via AMZNAuthorizationRequestHandler, and will not prompt the user to login. Otherwise, the user will be prompted to login.
         
         AMZNInteractiveStrategyAlways: The SDK will always prompt the user to login regardless of whether they have previously been authorized to use the app. When the user is prompted, the SDK will remove all locally cached authorization grants for the app.
         
         AMZNInteractiveStrategyNever: The SDK looks for a locally stored authorization grant from previous authorize:withHandler responses. If one is available, valid, and contains all requested scopes, the SDK will return an AMZNAuthorizeResult object that contains an access token and user profile data. Otherwise, it will return an NSError object via AMZNAuthorizationRequestHandler.
     
     */
    
}//eoc

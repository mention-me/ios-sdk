//
//  MentionmeRefereeRegisterRequest.swift
//  TestMentionme
//
//  Created by Andreas Bagias on 05/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import Foundation

public class MentionmeRefereeRegisterRequest: MentionmeRequest{
    
    public var mentionmeReferrerParameters: MentionmeReferrerParameters?
    public var mentionmeCustomerParameters: MentionmeCustomerParameters?
    
    override init() {
        super.init()
    }
    
    public convenience init(mentionmeReferrerParameters: MentionmeReferrerParameters,
                            mentionmeCustomerParameters: MentionmeCustomerParameters){
        self.init()
        
        super.method = MethodType.post
        super.urlSuffix = "referee/register"
        super.urlEndpoint = "consumer"
        
        self.mentionmeReferrerParameters = mentionmeReferrerParameters
        self.mentionmeCustomerParameters = mentionmeCustomerParameters
        
    }
    
    func createBodyParameters(){
        var params: [String: Any] = [String: Any]()
        
        if let mentionmeReferrerParameters = mentionmeReferrerParameters,
            let mentionmeCustomerParameters = mentionmeCustomerParameters{
            
            
            params["referrerMentionMeIdentifier"] = mentionmeReferrerParameters.referrerMentionMeIdentifier
            params["referrerToken"] = mentionmeReferrerParameters.referrerToken
            
            
            var customerParams: [String: Any] = [String: Any]()
            
            customerParams["emailAddress"] = mentionmeCustomerParameters.emailAddress
            customerParams["firstname"] = mentionmeCustomerParameters.firstname
            customerParams["surname"] = mentionmeCustomerParameters.surname
            if let title = mentionmeCustomerParameters.title{
                customerParams["title"] = title
            }
            if let uniqueIdentifer = mentionmeCustomerParameters.uniqueIdentifier{
                customerParams["uniqueIdentifer"] = uniqueIdentifer
            }
            if let segment = mentionmeCustomerParameters.segment{
                customerParams["segment"] = segment
            }
            
            params["customer"] = customerParams
            
            
        }
        
        bodyParameters = params
        
    }
    
    override func createRequest(requestParameters: MentionmeRequestParameters) -> NSMutableURLRequest {
        
        createBodyParameters()
        
        return super.createRequest(requestParameters: requestParameters)
    }
    
}

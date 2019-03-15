//
//  MentionmeCustomerRequest.swift
//  TestMentionme
//
//  Created by Andreas Bagias on 04/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import UIKit

public class MentionmeCustomerRequest: MentionmeRequest {

    public var mentionmeCustomerParameters: MentionmeCustomerParameters?
    
    override init() {
        super.init()
    }
    
    public convenience init(mentionmeCustomerParameters: MentionmeCustomerParameters) {
        self.init()
        
        super.method = MethodType.post
        super.urlSuffix = "referrer/enrol"
        super.urlEndpoint = "consumer"
        
        self.mentionmeCustomerParameters = mentionmeCustomerParameters
    }
    
    func createBodyParameters(){
        var params: [String: Any] = [String: Any]()
        
        if let mentionmeCustomerParameters = mentionmeCustomerParameters{
            
            
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

//
//  MentionmeReferrerEnrollment.swift
//  MentionmeSwift
//
//  Created by Andreas Bagias on 11/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import Foundation

public class MentionmeReferrerEnrollmentRequest: MentionmeRequest {
    
    public var mentionmeCustomerParameters: MentionmeCustomerParameters?
    
    override init() {
        super.init()
    }
    
    public convenience init(mentionmeCustomerParameters: MentionmeCustomerParameters) {
        self.init()
        
        super.method = MethodType.post
        super.urlSuffix = "referrer"
        super.urlEndpoint = "entry-point"
        
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
            if let uniqueIdentifier = mentionmeCustomerParameters.uniqueIdentifier{
                customerParams["uniqueIdentifier"] = uniqueIdentifier
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

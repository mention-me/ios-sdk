//
//  MentionmeDashboardRequest.swift
//  TestMentionme
//
//  Created by Andreas Bagias on 04/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import UIKit

public class MentionmeDashboardRequest: MentionmeRequest {

    public var mentionmeDashboardParameters: MentionmeDashboardParameters?
    
    override init() {
        super.init()
    }
    
    public convenience init(mentionmeDashboardParameters: MentionmeDashboardParameters) {
        self.init()
        
        super.method = MethodType.get
        super.urlSuffix = "referrer/dashboard"
        super.urlEndpoint = "consumer"
        
        self.mentionmeDashboardParameters = mentionmeDashboardParameters
    }
    
    func createQueryParameters(){
        var params: [String: Any] = [String: Any]()
        
        if let mentionmeDashboardParameters = mentionmeDashboardParameters{
            
            params["emailAddress"] = mentionmeDashboardParameters.emailAddress
            if let uniqueCustomerIdentifier = mentionmeDashboardParameters.uniqueCustomerIdentifier{
                params["uniqueCustomerIdentifier"] = uniqueCustomerIdentifier
            }
            
        }
        
        queryParameters = params
        
    }
    
    override func createRequest(requestParameters: MentionmeRequestParameters) -> NSMutableURLRequest {
        
        createQueryParameters()
        
        return super.createRequest(requestParameters: requestParameters)
    }
    
}

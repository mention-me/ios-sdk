//
//  MentionmeReferrerByNameRequest.swift
//  TestMentionme
//
//  Created by Andreas Bagias on 05/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import Foundation

public class MentionmeReferrerByNameRequest: MentionmeRequest{
    
    public var mentionmeReferrerNameParameters: MentionmeReferrerNameParameters?
    
    override init() {
        super.init()
    }
    
    public convenience init(mentionmeReferrerNameParameters: MentionmeReferrerNameParameters){
        self.init()
        
        super.method = MethodType.get
        super.urlSuffix = "referrer/search"
        super.urlEndpoint = "consumer"
        
        self.mentionmeReferrerNameParameters = mentionmeReferrerNameParameters
    }
    
    func createQueryParameters(){
        var params: [String: Any] = [String: Any]()
        
        if let mentionmeReferrerNameParameters = mentionmeReferrerNameParameters{
            
            
            params["name"] = mentionmeReferrerNameParameters.name
            if let email = mentionmeReferrerNameParameters.email{
                params["email"] = email
            }
            
        }
        
        
        queryParameters = params
        
    }
    
    override func createRequest(requestParameters: MentionmeRequestParameters) -> NSMutableURLRequest {
        
        createQueryParameters()
        
        return super.createRequest(requestParameters: requestParameters)
    }
}

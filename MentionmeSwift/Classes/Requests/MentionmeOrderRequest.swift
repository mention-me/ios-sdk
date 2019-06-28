//
//  MentionmeOrderRequest.swift
//  TestMentionme
//
//  Created by Andreas Bagias on 04/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import Foundation

public class MentionmeOrderRequest: MentionmeRequest{
    
    public var mentionmeOrderParameters: MentionmeOrderParameters?
    public var mentionmeCustomerParameters: MentionmeCustomerParameters?
    
    
    override init() {
        super.init()
    }
    
    public convenience init(mentionmeOrderParameters: MentionmeOrderParameters,
                            mentionmeCustomerParameters: MentionmeCustomerParameters) {
        self.init()
        
        super.method = MethodType.post
        super.urlSuffix = "order"
        super.urlEndpoint = "consumer"
        
        self.mentionmeOrderParameters = mentionmeOrderParameters
        self.mentionmeCustomerParameters = mentionmeCustomerParameters
    }
    
    func createBodyParameters(){
        var params: [String: Any] = [String: Any]()
        
        if let mentionmeCustomerParameters = mentionmeCustomerParameters,
            let mentionmeOrderParameters = mentionmeOrderParameters{
            
            
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
            
            
            
            var orderParams: [String: Any] = [String: Any]()
            
            orderParams["orderIdentifier"] = mentionmeOrderParameters.orderIdentifier
            orderParams["total"] = mentionmeOrderParameters.total
            orderParams["currencyCode"] = mentionmeOrderParameters.currencyCode
            orderParams["dateString"] = mentionmeOrderParameters.dateString
            if let couponCode = mentionmeOrderParameters.couponCode{
                orderParams["couponCode"] = couponCode
            }
            
            params["order"] = orderParams
            
            
        }
        
        bodyParameters = params
        
    }
    
    override func createRequest(requestParameters: MentionmeRequestParameters) -> NSMutableURLRequest {
        
        createBodyParameters()
        
        return super.createRequest(requestParameters: requestParameters)
    }
    
}

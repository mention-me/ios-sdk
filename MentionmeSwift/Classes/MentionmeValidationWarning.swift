//
//  MentionmeWarning.swift
//  MentionmeSwift
//
//  Created by Mention-me on 08/03/2019.
//

import Foundation

open class MentionmeValidationWarning{
    
    public init() {
        
    }
    
    func validate(mentionmeRequest: MentionmeRequest){
        
        if let customerRequest = mentionmeRequest as? MentionmeCustomerRequest{
            validateCustomerRequest(customerRequest: customerRequest)
        }else if let refereeRegisterRequest = mentionmeRequest as? MentionmeRefereeRegisterRequest{
            validateRefereeRequest(refereeRegisterRequest: refereeRegisterRequest)
        }else if let referrerByNameRequest = mentionmeRequest as? MentionmeReferrerByNameRequest{
            validateReferrerByNameRequest(referrerByNameRequest: referrerByNameRequest)
        }else if let orderRequest = mentionmeRequest as? MentionmeOrderRequest{
            validateOrderRequest(orderRequest: orderRequest)
        }else if let dashboardRequest = mentionmeRequest as? MentionmeDashboardRequest{
            validateDashboardRequest(dashboardRequest: dashboardRequest)
        }
        
    }
    
    open func reportWarning(_ warning: String){
        print(warning)
    }
    
    func validate(requestParameters: MentionmeRequestParameters){
        
        if requestParameters.partnerCode.count > 50{
            reportWarning("Request Parameter partnerCode is over 50 characters")
        }
        if requestParameters.situation.count > 50{
            reportWarning("Request Parameter situation is over 50 characters")
        }
        
        let pattern = "^[a-zA-Z0-9_\\- ]+$"
        
        do{
            
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let results = regex.matches(in: requestParameters.situation, options: [], range: NSRange(location: 0, length: requestParameters.situation.count))
            
            if results.count == 0{
                reportWarning("Request Parameter situation contains an invalid character")
            }
            
        }catch _{
            //print(error)
        }
        
        if let ipAddress = requestParameters.ipAddress, ipAddress.count > 20{
            reportWarning("Request Parameter ipAddress is over 20 characters")
        }
        if let variation = requestParameters.variation{
            if Int(variation) == nil{
                reportWarning("Request Parameter variation is not Integer")
            }
        }
        if let localeCode = requestParameters.localeCode, localeCode.count > 5 {
            reportWarning("Request Parameter localeCode is over 5 characters")
        }
        
    }
    
    private func validateOrderRequest(orderRequest: MentionmeOrderRequest){
        
        if let orderParameters = orderRequest.mentionmeOrderParameters{
            validateOrderParameters(orderParameters)
        }
        if let customerParameters = orderRequest.mentionmeCustomerParameters{
            validateCustomerParameters(customerParameters)
        }
    }
    
    private func validateReferrerByNameRequest(referrerByNameRequest: MentionmeReferrerByNameRequest){
        
        if let referrerByNameParameters = referrerByNameRequest.mentionmeReferrerNameParameters{
            validateReferrerByNameParameters(referrerByNameParameters)
        }
    }
    
    private func validateCustomerRequest(customerRequest: MentionmeCustomerRequest){
        
        if let customerParameters = customerRequest.mentionmeCustomerParameters{
            validateCustomerParameters(customerParameters)
        }
    }
    
    private func validateRefereeRequest(refereeRegisterRequest: MentionmeRefereeRegisterRequest){
        
        if let customerParameters = refereeRegisterRequest.mentionmeCustomerParameters{
            validateCustomerParameters(customerParameters)
        }
    }
    
    private func validateDashboardRequest(dashboardRequest: MentionmeDashboardRequest){
        
        if let dashboardParameters = dashboardRequest.mentionmeDashboardParameters{
            validateDashboardParameters(dashboardParameters)
        }
        
    }
    
    private func validateDashboardParameters(_ dashboardParameters: MentionmeDashboardParameters){
        
        if dashboardParameters.emailAddress.count > 255 {
            reportWarning("Dashboard Parameter emailAddress is over 255 characters")
        }
        if let uniquerCustomerIdentifier = dashboardParameters.uniqueCustomerIdentifier, uniquerCustomerIdentifier.count > 255{
            reportWarning("Dashboard Parameter uniqueCustomerIdentifier is over 255 characters")
        }
        
    }
    
    private func validateReferrerByNameParameters(_ referrerByNameParameters: MentionmeReferrerNameParameters){
        if referrerByNameParameters.name.count > 255{
            reportWarning("Referrer Parameter name is over 255 characters")
        }
        if let email = referrerByNameParameters.email, email.count > 255{
            reportWarning("Referrer Parameter email is over 255 characters")
        }
    }
    
    private func validateOrderParameters(_ orderParameters: MentionmeOrderParameters){
        if orderParameters.orderIdentifier.count > 50{
            reportWarning("Order Parameter orderIdentifier is over 50 characters")
        }
        if let couponCode = orderParameters.couponCode, couponCode.count > 255{
            reportWarning("Order Parameter couponCode is over 255 characters")
        }
        if orderParameters.currencyCode.count != 3{
            reportWarning("Order Parameter currencyCode is not 3 characters")
        }
    }
    
    private func validateCustomerParameters(_ customerParameters: MentionmeCustomerParameters){
        if let title = customerParameters.title, title.count > 20{
            reportWarning("Customer Parameter title is over 20 characters")
        }
        if customerParameters.firstname.count > 255{
            reportWarning("Customer Parameter firstname is over 255 characters")
        }
        if customerParameters.surname.count > 255{
            reportWarning("Customer Parameter surname is over 255 characters")
        }
        if customerParameters.emailAddress.count > 255{
            reportWarning("Customer Parameter email is over 255 characters")
        }
        if let uniqueIdentifier = customerParameters.uniqueIdentifier, uniqueIdentifier.count > 255{
            reportWarning("Customer Parameter uniqueIdentifier is over 255 characters")
        }
        if let segment = customerParameters.segment{
            if segment.count > 50{
                reportWarning("Customer Parameter segment is over 50 characters")
            }
            
            let pattern = "^[a-zA-Z0-9_\\-\\| \\*%&,.;':\"\\[\\]\\$£]+$"
            
            do{
                
                let regex = try NSRegularExpression(pattern: pattern, options: [])
                let results = regex.matches(in: segment, options: [], range: NSRange(location: 0, length: segment.count))
                
                if results.count == 0{
                    reportWarning("Customer Parameter segment contains an invalid character")
                }
                
            }catch _{
                
            }
            
        }
    }
    
}

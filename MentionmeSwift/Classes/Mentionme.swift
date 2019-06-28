//
//  Mentionme.swift
//  TestMentionme
//
//  Created by Andreas Bagias on 04/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import UIKit

public class Mentionme {

    public static var shared: Mentionme = { return Mentionme() }()
    
    ///Optional configuration class for setting demo mode or printing network debugging
    public var config: MentionmeConfig?
    ///Information about the request
    public var requestParameters: MentionmeRequestParameters?
    ///Class used for parameters validation
    public var validationWarning: MentionmeValidationWarning?
    
    private var sessionDataTask: URLSessionDataTask?
    
    private init() {
        
    }
    
    /// Cancels the session data task request
    public func cancelRequest(){
        sessionDataTask?.cancel()
    }
    
    /// Suspends the session data task request
    public func suspendRequest(){
        sessionDataTask?.suspend()
    }
    
    /// Resumes the session data task request
    public func resumeRequest(){
        sessionDataTask?.resume()
    }
    
    /**
     Tell us that an order took place so that we can reward any appropriate referrer
    */
    public func recordOrder(mentionmeOrderRequest: MentionmeOrderRequest,
                            situation: String,
                            success: @escaping () -> Void,
                            failure: @escaping (_ error:MentionmeError?) -> Void,
                            noResponse: @escaping (_ error:Error?) -> Void){
        
        guard let requestParameters = requestParameters else {
            noResponse(NSError(domain: "com.Mentionme.requestParameters.error", code: 405, userInfo: ["error": "There are no request parameters set."]) as Error)
            return
        }
        
        requestParameters.situation = situation
        
        validationWarning?.validate(requestParameters: requestParameters)
        validationWarning?.validate(mentionmeRequest: mentionmeOrderRequest)
        
        let request = mentionmeOrderRequest.createRequest(requestParameters: requestParameters)
        
        performSessionDataTask(withRequest: request, success: { (data, response) in
            DispatchQueue.main.async {
                success()
            }
        }, failure: { (data, error) in
            DispatchQueue.main.async {
                failure(error)
            }
        }) { (error) in
            DispatchQueue.main.async {
                noResponse(error)
            }
        }
        
    }
    
    /**
       Tell us a customer's details to enrol them as a referrer and receive a referral offer for them to share
     */
    public func enrolReferrer(mentionmeCustomerRequest: MentionmeCustomerRequest,
                              situation: String,
                              success: @escaping (_ mentionmeOffer:MentionmeOffer?, _ shareLinks:[MentionmeShareLink]?, _ termsLinks:MentionmeTermsLinks?) -> Void,
                              failure: @escaping (_ error:MentionmeError?) -> Void,
                              noResponse: @escaping (_ error:Error?) -> Void){
        
        guard let requestParameters = requestParameters else {
            noResponse(NSError(domain: "com.Mentionme.requestParameters.error", code: 405, userInfo: ["error": "There are no request parameters set."]) as Error)
            return
        }
        
        requestParameters.situation = situation
        
        validationWarning?.validate(requestParameters: requestParameters)
        validationWarning?.validate(mentionmeRequest: mentionmeCustomerRequest)
        
        let request = mentionmeCustomerRequest.createRequest(requestParameters: requestParameters)
        
        performSessionDataTask(withRequest: request, success: { (data, response) in
            
            if let data = data{
                MentionmeParser.getOffer(data: data, success: { offer,shareLinks,termsLinks  in
                    DispatchQueue.main.async {
                        success(offer,shareLinks,termsLinks)
                    }
                }, failure: { (message) in
                    DispatchQueue.main.async {
                        noResponse(NSError(domain: "com.Mentionme.json.error", code: 405, userInfo: ["error": message]) as Error)
                    }
                })
            }else{
                DispatchQueue.main.async{
                    noResponse(NSError(domain: "com.Mentionme.json.error", code: 400, userInfo: ["error": "There was a problem with data"]) as Error)
                }
            }
            
        }, failure: { (data, error) in
            DispatchQueue.main.async {
                failure(error)
            }
        }) { (error) in
            DispatchQueue.main.async {
                noResponse(error)
            }
        }
        
    }
    
    /**
        Get a referrer's dashboard (given a referrer identity, get their dashboard data)
     */
    public func getReferrerDashboard(mentionmeDashboardRequest: MentionmeDashboardRequest,
                                     situation: String,
                                     success: @escaping (_ offer: MentionmeOffer?,
                                                         _ links: [MentionmeShareLink]?,
                                                         _ termsLinks: MentionmeTermsLinks?,
                                                         _ referralStats: MentionmeReferralStats?,
                                                         _ dashboardRewards: [MentionmeDashboardReward]?) -> Void,
                                     failure: @escaping (_ error:MentionmeError?) -> Void,
                                     noResponse: @escaping (_ error:Error?) -> Void){
        
        guard let requestParameters = requestParameters else {
            noResponse(NSError(domain: "com.Mentionme.requestParameters.error", code: 405, userInfo: ["error": "There are no request parameters set."]) as Error)
            return
        }
        
        requestParameters.situation = situation
        
        validationWarning?.validate(requestParameters: requestParameters)
        validationWarning?.validate(mentionmeRequest: mentionmeDashboardRequest)
        
        let request = mentionmeDashboardRequest.createRequest(requestParameters: requestParameters)
        
        performSessionDataTask(withRequest: request, success: { (data, response) in
            
            if let data = data{
                MentionmeParser.getDashboard(data: data, success: { (offer, links, termsLinks, referralStats, dashboardRewards) in
                    DispatchQueue.main.async {
                        success(offer,links,termsLinks,referralStats,dashboardRewards)
                    }
                }, failure: { (message) in
                    DispatchQueue.main.async {
                        noResponse(NSError(domain: "com.Mentionme.json.error", code: 405, userInfo: ["error": message]) as Error)
                    }
                })
                
            }else{
                DispatchQueue.main.async {
                    noResponse(NSError(domain: "com.Mentionme.json.error", code: 400, userInfo: ["error": "There was a problem with data"]) as Error)
                }
            }
            
        }, failure: { (data, error) in
            DispatchQueue.main.async {
                failure(error)
            }
        }) { (error) in
            DispatchQueue.main.async {
                noResponse(error)
            }
        }
        
    }
    
    /**
        Search for a referrer to connect to a referee, using just their name
     */
    public func findReferrerByName(mentionmeReferrerByNameRequest: MentionmeReferrerByNameRequest,
                                   situation: String,
                                   success: @escaping (_ referrer: MentionmeReferrer?, _ foundMultipleReferrers: Bool?, _ links: [MentionmeContentCollectionLink]?) -> Void,
                                   failure: @escaping (_ referrer: MentionmeReferrer?, _ foundMultipleReferrers: Bool?, _ links: [MentionmeContentCollectionLink]?, _ error:MentionmeError?) -> Void,
                                   noResponse: @escaping (_ error:Error?) -> Void){
        
        guard let requestParameters = requestParameters else {
            noResponse(NSError(domain: "com.Mentionme.requestParameters.error", code: 405, userInfo: ["error": "There are no request parameters set."]) as Error)
            return
        }
        
        requestParameters.situation = situation
        
        validationWarning?.validate(requestParameters: requestParameters)
        validationWarning?.validate(mentionmeRequest: mentionmeReferrerByNameRequest)
        
        let request = mentionmeReferrerByNameRequest.createRequest(requestParameters: requestParameters)
        
        performSessionDataTask(withRequest: request, success: { (data, response) in
            
            if let data = data{
                MentionmeParser.getReferrerByName(data: data, success: { (referrer, foundMultipleReferrers, links) in
                    DispatchQueue.main.async {
                        success(referrer,foundMultipleReferrers,links)
                    }
                }, failure: { (message) in
                    DispatchQueue.main.async {
                        noResponse(NSError(domain: "com.Mentionme.json.error", code: 405, userInfo: ["error": message]) as Error)
                    }
                })
            }else{
                DispatchQueue.main.async {
                    noResponse(NSError(domain: "com.Mentionme.json.error", code: 400, userInfo: ["error": "There was a problem with data"]) as Error)
                }
            }
            
        }, failure: { (data, error) in
            if let data = data{
                MentionmeParser.getReferrerByName(data: data, success: { (referrer, foundMultipleReferrers, links) in
                    DispatchQueue.main.async {
                        failure(referrer,foundMultipleReferrers,links,error)
                    }
                }, failure: { (message) in
                    DispatchQueue.main.async {
                        noResponse(NSError(domain: "com.Mentionme.json.error", code: 405, userInfo: ["error": message]) as Error)
                    }
                })
            }else{
                DispatchQueue.main.async {
                    noResponse(NSError(domain: "com.Mentionme.json.error", code: 400, userInfo: ["error": "There was a problem with data"]) as Error)
                }
            }
        }) { (error) in
            DispatchQueue.main.async {
                noResponse(error)
            }
        }
    }
    
    /**
        Post a referee's details to register them as a referee after successfully finding a referrer to link them to
     */
    public func linkNewCustomerToReferrer(mentionmeRefereeRegisterRequest: MentionmeRefereeRegisterRequest,
                                          situation: String,
                                          success: @escaping (_ offer: MentionmeOffer?, _ refereeReward: MentionmeRefereeReward?, _ contentCollectionLink: MentionmeContentCollectionLink?, _ status: String?) -> Void,
                                          failure: @escaping (_ error:MentionmeError?) -> Void,
                                          noResponse: @escaping (_ error:Error?) -> Void){
        
        guard let requestParameters = requestParameters else {
            noResponse(NSError(domain: "com.Mentionme.requestParameters.error", code: 405, userInfo: ["error": "There are no request parameters set."]) as Error)
            return
        }
        
        requestParameters.situation = situation
        
        validationWarning?.validate(requestParameters: requestParameters)
        validationWarning?.validate(mentionmeRequest: mentionmeRefereeRegisterRequest)
        
        let request = mentionmeRefereeRegisterRequest.createRequest(requestParameters: requestParameters)
        
        performSessionDataTask(withRequest: request, success: { (data, response) in
            if let data = data{
                MentionmeParser.getRefereeRegister(data: data, success: { (offer, refereeReward, link, status) in
                    DispatchQueue.main.async {
                        success(offer,refereeReward,link,status)
                    }
                }, failure: { (message) in
                    DispatchQueue.main.async {
                        noResponse(NSError(domain: "com.Mentionme.json.error", code: 405, userInfo: ["error": message]) as Error)
                    }
                })
            }else{
                DispatchQueue.main.async {
                    noResponse(NSError(domain: "com.Mentionme.json.error", code: 400, userInfo: ["error": "There was a problem with data"]) as Error)
                }
            }
            
        }, failure: { (data, error) in
            DispatchQueue.main.async {
                failure(error)
            }
        }) { (error) in
            DispatchQueue.main.async {
                noResponse(error)
            }
        }
    }
    
    ///Request - Provide a customers' details so we can tell you if we could enrol them as a referrer. We'll provide the URL to the web-view for their journey
    public func entryPointForReferrerEnrollment(mentionmeReferrerEnrollmentRequest: MentionmeReferrerEnrollmentRequest,
                                                situation: String,
                                                success: @escaping (_ url:String, _ defaultCallToActionString:String) -> Void,
                                                failure: @escaping (_ error:MentionmeError?) -> Void,
                                                noResponse: @escaping (_ error:Error?) -> Void){
        
        guard let requestParameters = requestParameters else {
            noResponse(NSError(domain: "com.Mentionme.requestParameters.error", code: 405, userInfo: ["error": "There are no request parameters set."]) as Error)
            return
        }
        
        requestParameters.situation = situation
        
        validationWarning?.validate(requestParameters: requestParameters)
        validationWarning?.validate(mentionmeRequest: mentionmeReferrerEnrollmentRequest)
        
        let request = mentionmeReferrerEnrollmentRequest.createRequest(requestParameters: requestParameters)
        
        performSessionDataTask(withRequest: request, success: { (data, response) in
            
            if let data = data{
                MentionmeParser.getEnrollment(data: data, success: { (url, defaultCallToActionString) in
                    DispatchQueue.main.async {
                        success(url, defaultCallToActionString)
                    }
                }, failure: { (message) in
                    DispatchQueue.main.async {
                        noResponse(NSError(domain: "com.Mentionme.json.error", code: 405, userInfo: ["error": message]) as Error)
                    }
                })
            }else{
                DispatchQueue.main.async{
                    noResponse(NSError(domain: "com.Mentionme.json.error", code: 400, userInfo: ["error": "There was a problem with data"]) as Error)
                }
            }
            
        }, failure: { (data, error) in
            DispatchQueue.main.async {
                failure(error)
            }
        }) { (error) in
            DispatchQueue.main.async {
                noResponse(error)
            }
        }
        
    }
    
    
    private func performSessionDataTask(withRequest request:NSMutableURLRequest,
                                success: @escaping (_ data:Data?, _ response:URLResponse?) -> Void,
                                failure: @escaping (_ data:Data?, _ error:MentionmeError?) -> Void,
                                noResponse: @escaping (_ error:Error?) -> Void){
        
        sessionDataTask = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse {
                
                if httpResponse.statusCode < 200 || httpResponse.statusCode > 299 {
                    if let dataDict = MentionmeParser.getDictionary(data: data){
                        let mentionmeError = MentionmeError(withDataDictionary: dataDict, statusCode: httpResponse.statusCode)
                        failure(data, mentionmeError)
                    }
                }else{
                    success(data, response)
                }
            }else {
                noResponse(error)
            }
            
            
        }
        sessionDataTask?.resume()
    }
    
}

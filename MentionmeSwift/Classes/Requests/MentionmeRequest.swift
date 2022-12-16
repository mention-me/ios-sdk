//
//  MentionmeRequest.swift
//  TestMentionme
//
//  Created by Andreas Bagias on 04/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import Foundation

enum MethodType: String{
    case get = "GET"
    case post = "POST"
}

public class MentionmeRequest: NSObject {
    
    var baseURLUAT = "https://uat.mention-me.com"
    var baseURLDemo = "https://demo.mention-me.com"
    var baseURL = "https://mention-me.com"
    var urlSuffix = ""
    var urlEndpoint = ""
    var method: MethodType?
    var queryParameters: Dictionary<String, Any>?
    var bodyParameters: Dictionary<String, Any>?
    
    public override init() {
        
    }
    
    func createRequest(requestParameters: MentionmeRequestParameters) -> NSMutableURLRequest{
        
        let url = getURL(mentionmeRequestParameters: requestParameters)
        
        let request: NSMutableURLRequest = NSMutableURLRequest()
        
        request.httpMethod = (method?.rawValue)!
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.url = url
        request.httpBody = getBody(requestParameters)
        
        if Mentionme.shared.config?.debugNetwork ?? false{
            print("\(request.httpMethod)         \(url)")
        }
        
        return request
    }
    
    func getURL(mentionmeRequestParameters: MentionmeRequestParameters) -> URL{
        
        var urlString = "\(baseURL)/api/\(urlEndpoint)/v1/\(urlSuffix)"
        
        if let config = Mentionme.shared.config{
            if config.demo{
                urlString = "\(baseURLDemo)/api/\(urlEndpoint)/v1/\(urlSuffix)"
            }else if config.uat{
                urlString = "\(baseURLUAT)/api/\(urlEndpoint)/v1/\(urlSuffix)"
            }
        }
        
        if var queryParams = queryParameters{
            urlString += "?"
            
            queryParams["request"] = requestParams(mentionmeRequestParameters)
            
            for param in queryParams{
                
                if let dictValue = param.value as? [String: Any]{
                
                    for parameter in dictValue{
                        
                        if let addition = "\(param.key)[\(parameter.key)]=\(parameter.value)&".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed){
                            urlString += addition
                        }
                    }
                    
                }else{
                    let value = "\(param.value)".replacingOccurrences(of: " ", with: "+")
                    urlString += "\(param.key)=\(value)&"
                }
                
            }
            
            urlString = String(urlString[..<urlString.endIndex])
        }
        
        return URL(string: urlString)!
    }
    
    func getBody(_ mentionmeRequestParameters: MentionmeRequestParameters) -> Data?{
        
        guard var bodyParameters = bodyParameters else { return nil }
        
        bodyParameters["request"] = requestParams(mentionmeRequestParameters)
        
        do {
            let data = try JSONSerialization.data(withJSONObject: bodyParameters)
            return data
            
        } catch _ {
            return nil
        }
    }
    
    func requestParams(_ mentionmeRequestParameters: MentionmeRequestParameters) -> [String: Any]{
        
        var requestParams: [String: Any] = [String: Any]()
        
        requestParams["partnerCode"] = mentionmeRequestParameters.partnerCode
        requestParams["situation"] = mentionmeRequestParameters.situation
        if let localeCode = mentionmeRequestParameters.localeCode{
            requestParams["localeCode"] = localeCode
        }
        if let ipAddress = mentionmeRequestParameters.ipAddress{
            requestParams["ipAddress"] = ipAddress
        }
        if let userDeviceIdentifer = mentionmeRequestParameters.userDeviceIdentifier{
            requestParams["userDeviceIdentifier"] = userDeviceIdentifer
        }
        if let deviceType = mentionmeRequestParameters.deviceType{
            requestParams["deviceType"] = deviceType
        }
        if let appName = mentionmeRequestParameters.appName{
            requestParams["appName"] = appName
        }
        if let appVersion = mentionmeRequestParameters.appVersion{
            requestParams["appVersion"] = appVersion
        }
        if let authenticationToken = mentionmeRequestParameters.authenticationToken{
            requestParams["authenticationToken"] = authenticationToken
        }
        if let variation = mentionmeRequestParameters.variation{
            requestParams["variation"] = variation
        }
        if let segment = mentionmeRequestParameters.segment{
            requestParams["segment"] = segment
        }
        
        return requestParams
    }
    
}


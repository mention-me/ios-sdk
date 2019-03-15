//
//  MentionmeShareLink.swift
//  TestMentionme
//
//  Created by Andreas Bagias on 04/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import Foundation

public class MentionmeShareLink{
    
    /**
     * The type of share mechanism (e.g. Facebook, Twitter, Open link, Email link)
     */
    public var type: String = ""
    /**
     * The protocol (if available) for the share
     */
    public var protocolShareLink: String = ""
    /**
     * The url to include in the share
     */
    public var url: String = ""
    /**
     * The default message to include in the share
     */
    public var defaultShareMessage: String = ""
    /**
     * An example of the share URL you could use to initiate this share. You are free to implement this your own way if you wish
     */
    public var exampleImplementation: String = ""
    
    init(withDictionary dict: NSDictionary) {
        
        if let type = dict["type"] as? String{
            self.type = type
        }
        if let protocolShareLink = dict["protocol"] as? String{
            self.protocolShareLink = protocolShareLink
        }
        if let url = dict["url"] as? String{
            self.url = url
        }
        if let defaultShareMessage = dict["defaultShareMessage"] as? String{
            self.defaultShareMessage = defaultShareMessage
        }
        if let exampleImplementation = dict["exampleImplementation"] as? String{
            self.exampleImplementation = exampleImplementation
        }
        
    }
    
}

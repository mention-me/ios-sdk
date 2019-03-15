//
//  MentionmeContent.swift
//  TestMentionme
//
//  Created by Andreas Bagias on 05/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import Foundation

public class MentionmeContent{
    
    /**
     * Token
     */
    public var token: String = ""
    /**
     * The headline
     */
    public var headline: String = ""
    
    init(withDictionary dict: NSDictionary) {
        
        if let token = dict["token"] as? String{
            self.token = token
        }
        if let headline = dict["headline"] as? String{
            self.headline = headline
        }
        
    }
    
}

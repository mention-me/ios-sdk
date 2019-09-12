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
     * Key
     */
    public var key: String = ""
    /**
     * Content
     */
    public var content: String = ""
    
    init(withDictionary dict: NSDictionary) {
        
        if let key = dict["key"] as? String{
            self.key = key
        }
        if let content = dict["content"] as? String{
            self.content = content
        }
        
    }
    
}

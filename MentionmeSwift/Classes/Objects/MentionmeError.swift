//
//  MentionmeError.swift
//  TestMentionme
//
//  Created by Andreas Bagias on 04/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import Foundation

public class MentionmeError {
    
    /**
     * The array of errors of the response
     */
    public var errors: NSArray?
    /**
     * The status code of the response
     */
    public var statusCode: Int?
    
    init(withDataDictionary dataDict: NSDictionary, statusCode: Int?){
        
        self.statusCode = statusCode
        
        if let errors = dataDict["errors"] as? NSArray{
            self.errors = errors
        }
        
    }
    
}

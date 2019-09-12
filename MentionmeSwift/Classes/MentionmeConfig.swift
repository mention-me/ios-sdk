//
//  MentionmeConfig.swift
//  TestMentionme
//
//  Created by Andreas Bagias on 05/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import Foundation

public class MentionmeConfig{
    
    public var demo: Bool
    public var envCode: String
    public var debugNetwork: Bool = false
    
    public init(demo: Bool, envCode: String){
        self.demo = demo
        self.envCode = envCode
    }
    
}

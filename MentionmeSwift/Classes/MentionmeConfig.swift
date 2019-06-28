//
//  MentionmeConfig.swift
//  TestMentionme
//
//  Created by Andreas Bagias on 05/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import Foundation

public class MentionmeConfig{
    
    public var demo: Bool = false
    public var uat: Bool = false
    public var debugNetwork: Bool = false
    
    public init(demo: Bool){
        self.demo = demo
    }
    
    public init(uat: Bool){
        self.uat = uat
    }
    
}

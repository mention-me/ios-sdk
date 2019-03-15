//
//  CustomValidationWarning.swift
//  MentionmeSwift_Example
//
//  Created by Andreas Bagias on 13/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import UIKit
import MentionmeSwift

class CustomValidationWarning: MentionmeValidationWarning {

    override init() {
        super.init()
    }
    
    override func reportWarning(_ warning: String) {
        super.reportWarning(warning)
        
        //Here you can include you own analytics
    }
    
}

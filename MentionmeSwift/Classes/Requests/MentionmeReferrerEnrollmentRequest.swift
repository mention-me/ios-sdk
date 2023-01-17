//
//  MentionmeReferrerEnrollment.swift
//  MentionmeSwift
//
//  Created by Andreas Bagias on 11/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import Foundation

public class MentionmeReferrerEnrollmentRequest: MentionmeCustomerRequest {

  public convenience init(mentionmeCustomerParameters: MentionmeCustomerParameters) {
    self.init()
      
    super.method = MethodType.post
    super.urlSuffix = "referrer"
    super.urlEndpoint = "entry-point"
    super.mentionmeCustomerParameters = mentionmeCustomerParameters
  }
}

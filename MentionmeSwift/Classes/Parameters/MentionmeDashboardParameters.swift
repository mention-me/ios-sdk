//
//  MentionmeDashboardParameters.swift
//  TestMentionme
//
//  Created by Andreas Bagias on 04/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import Foundation

public class MentionmeDashboardParameters {

  /**
     * REQUIRED - Email address of the referrer whose dashboard you require
     */
  public var emailAddress: String = ""
  /**
     * Customer Id - your unique identifier for this customer
     */
  public var uniqueCustomerIdentifier: String?

  private init() {

  }

  public convenience init(emailAddress: String) {
    self.init()

    self.emailAddress = emailAddress
  }
}

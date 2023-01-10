//
//  MentionmeReferrerParameters.swift
//  TestMentionme
//
//  Created by Andreas Bagias on 05/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import Foundation

public class MentionmeReferrerParameters {

  /**
     * Id representing the referrer returned by a successful name search
     */
  public var referrerMentionMeIdentifier: String = ""
  /**
     * Token representing the referrer returned by a successful name search
     */
  public var referrerToken: String = ""

  private init() {

  }

  public convenience init(referrerMentionMeIdentifier: String, referrerToken: String) {
    self.init()

    self.referrerMentionMeIdentifier = referrerMentionMeIdentifier
    self.referrerToken = referrerToken
  }

}

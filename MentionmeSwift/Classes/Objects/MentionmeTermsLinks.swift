//
//  MentionmeTermsLinks.swift
//  TestMentionme
//
//  Created by Andreas Bagias on 05/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import Foundation

public class MentionmeTermsLinks {

  /**
     * The locale code of the terms link
     */
  public var localeCode: String = ""
  /**
     * Link to the terms and conditions in the locale stated
     */
  public var linkToTermsInLocale: String = ""

  init(withDictionary dict: NSDictionary) {

    if let localeCode = dict["localeCode"] as? String {
      self.localeCode = localeCode
    }
    if let linkToTermsInLocale = dict["linkToTermsInLocale"] as? String {
      self.linkToTermsInLocale = linkToTermsInLocale
    }

  }

}

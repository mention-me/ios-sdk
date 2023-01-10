//
//  MentionmeReferrerNameParameters.swift
//  TestMentionme
//
//  Created by Andreas Bagias on 05/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import Foundation

public class MentionmeReferrerNameParameters {

  /**
     * Name of a referrer to search for (entered by the new customer)
     */
  public var name: String = ""
  /**
     * Optionally ask the new customer to qualify the name with an email address belonging to the referrer. We typically ask for a Name first and then if no matches found, offer Name + Email address.
     */
  public var email: String?

  private init() {

  }

  public convenience init(name: String) {
    self.init()

    self.name = name
  }

}

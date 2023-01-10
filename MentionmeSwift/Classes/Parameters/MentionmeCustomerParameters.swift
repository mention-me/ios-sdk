//
//  MentionmeCustomerParameters.swift
//  TestMentionme
//
//  Created by Andreas Bagias on 04/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import UIKit

public class MentionmeCustomerParameters {

  /**
     * REQUIRED - Customer email address
     */
  public var emailAddress: String = ""
  /**
     * Customer title such as Mr, Miss, Dr or Sir
     */
  public var title: String?
  /**
     * REQUIRED - Customer firstname
     */
  public var firstname: String = ""
  /**
     * REQUIRED - Customer surname
     */
  public var surname: String = ""
  /**
     * Your unique identifier for this customer e.g. CustomerId
     */
  public var uniqueIdentifier: String?
  /**
     * Customer segment, a string containing segment data about this customer, e.g. vip or employee. You can concatenate multiple segments together if you wish using hyphens.
     */
  public var segment: String?

  //    override init() {
  //        super.init()
  //    }

  private init() {

  }

  public convenience init(emailAddress: String, firstname: String, surname: String) {
    self.init()

    self.emailAddress = emailAddress
    self.firstname = firstname
    self.surname = surname

  }

}

//
//  MentionmeRefereeReward.swift
//  TestMentionme
//
//  Created by Andreas Bagias on 05/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import Foundation

public class MentionmeRefereeReward {

  /**
     * Description of the reward
     */
  public var descriptionRefereeReward: String = ""
  /**
     * Reward coupon code
     */
  public var couponCode: String = ""
  /**
     * Reward security code (if appropriate)
     */
  public var securityCode: String = ""
  /**
     * The reward amount
     */
  public var amount: String = ""

  init(withDictionary dict: NSDictionary) {

    if let descriptionRefereeReward = dict["description"] as? String {
      self.descriptionRefereeReward = descriptionRefereeReward
    }
    if let couponCode = dict["couponCode"] as? String {
      self.couponCode = couponCode
    }
    if let securityCode = dict["securityCode"] as? String {
      self.securityCode = securityCode
    }
    if let amount = dict["amount"] as? String {
      self.amount = amount
    }

  }

}

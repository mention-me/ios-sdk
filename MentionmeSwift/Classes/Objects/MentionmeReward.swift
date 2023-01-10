//
//  MentionmeReward.swift
//  TestMentionme
//
//  Created by Andreas Bagias on 05/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import Foundation

public class MentionmeReward {

  /**
     * Friendly description of the reward for the intended recipient e.g. "John, give your friends {{referee-their-reward}} when they {{referee-action-for-referrer}} on {{selling-brand}}." e.g. "John, give your friends 20% off when they order for the first time on [BRAND]" e.g. "You'll get £20 for each friend you refer"
     */
  public var descriptionReward: String = ""
  /**
     * Summary of the reward itself e.g. "20% off" e.g. "£20 gift card"
     */
  public var summary: String = ""
  /**
     * The reward amount
     */
  public var amount: String = ""

  init(withDictionary dict: NSDictionary) {

    if let descriptionReward = dict["description"] as? String {
      self.descriptionReward = descriptionReward
    }
    if let summary = dict["summary"] as? String {
      self.summary = summary
    }
    if let amount = dict["amount"] as? String {
      self.amount = amount
    }

  }

}

//
//  MentionmeReferralStats.swift
//  TestMentionme
//
//  Created by Andreas Bagias on 04/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import UIKit

public class MentionmeReferralStats {

  /**
     * Number of successful referrals
     */
  public var successfulReferrals: Int?
  /**
     * Number of invitations made
     */
  public var invitations: Int?
  /**
     * Number of clicks on invites
     */
  public var clicksOnInvites: Int?

  init(withDictionary dict: NSDictionary) {

    if let successfulReferrals = dict["successfulReferrals"] as? Int {
      self.successfulReferrals = successfulReferrals
    }
    if let invitations = dict["invitations"] as? Int {
      self.invitations = invitations
    }
    if let clicksOnInvites = dict["clicksOnInvites"] as? Int {
      self.clicksOnInvites = clicksOnInvites
    }

  }

}

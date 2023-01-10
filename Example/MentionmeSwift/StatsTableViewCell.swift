//
//  StatsTableViewCell.swift
//  MentionmeSwift_Example
//
//  Created by Andreas Bagias on 05/04/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import MentionmeSwift
import UIKit

class StatsTableViewCell: UITableViewCell {

  @IBOutlet weak var successfulReferralsLabel: UILabel!
  @IBOutlet weak var invitesSentLabel: UILabel!
  @IBOutlet weak var clicksOnInvitesLabel: UILabel!

  func configureViewCell(stats: MentionmeReferralStats) {

    successfulReferralsLabel.text = "\(stats.successfulReferrals ?? 0)"
    invitesSentLabel.text = "\(stats.invitations ?? 0)"
    clicksOnInvitesLabel.text = "\(stats.clicksOnInvites ?? 0)"
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

}

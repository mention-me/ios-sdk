//
//  RewardTableViewCell.swift
//  MentionmeSwift_Example
//
//  Created by Andreas Bagias on 05/04/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import MentionmeSwift

class RewardTableViewCell: UITableViewCell {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    func configureViewCell(dashboardReward: MentionmeDashboardReward){
        
        emailLabel.text = dashboardReward.forReferring.first ?? ""
        summaryLabel.text = dashboardReward.summary
        statusLabel.text = dashboardReward.status
        
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

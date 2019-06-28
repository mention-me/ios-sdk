//
//  MentionmeDashboardReward.swift
//  TestMentionme
//
//  Created by Andreas Bagias on 04/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import UIKit

public class MentionmeDashboardReward {

    /**
     * Friendly description of the reward for the intended recipient e.g. "John, give your friends {{referee-their-reward}} when they {{referee-action-for-referrer}} on {{selling-brand}}." e.g. "John, give your friends 20% off when they order for the first time on [BRAND]" e.g. "You'll get £20 for each friend you refer"
     */
    public var descriptionDashboardReward: String = ""
    /**
     * Summary of the reward itself e.g. "20% off" e.g. "£20 gift card"
     */
    public var summary: String = ""
    /**
     * The reward amount
     */
    public var amount: String = ""
    /**
     * Status of the reward eg Pending, Cancelled, Given by email
     */
    public var status: String = ""
    /**
     * Description of who they referred to get the reward
     */
    public var forReferring: [String] = [String]()
    
    init(withDictionary dict: NSDictionary) {
        
        if let descriptionDashboardReward = dict["description"] as? String{
            self.descriptionDashboardReward = descriptionDashboardReward
        }
        if let summary = dict["summary"] as? String{
            self.summary = summary
        }
        if let amount = dict["amount"] as? String{
            self.amount = amount
        }
        if let status = dict["status"] as? String{
            self.status = status
        }
        if let forReferring = dict["forReferring"] as? [String]{
            self.forReferring = forReferring
        }
        
    }
    
}

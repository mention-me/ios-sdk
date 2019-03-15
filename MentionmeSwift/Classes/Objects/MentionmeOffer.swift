//
//  MentionmeOffer.swift
//  TestMentionme
//
//  Created by Andreas Bagias on 04/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import Foundation

public class MentionmeOffer {
    
    /**
     * The identifier of the offer
     */
    public var id: Int = 0
    /**
     * The locale code of the offer
     */
    public var localeCode: String = ""
    /**
     * The headline description for the offer e.g. "You can get a £20 gift card if you refer a friend to ..."
     */
    public var headline: String = ""
    /**
     * The details of the offer e.g. "Give your friends a 20% off introductory offer"
     */
    public var descriptionOffer: String = ""
    /**
     * The details of the reward for the referrer
     */
    public var referrerReward: MentionmeReward?
    /**
     * The details of the reward for the referee
     */
    public var refereeReward: MentionmeReward?
    
    init(withDictionary dict: NSDictionary) {
        
        if let id = dict["id"] as? Int{
            self.id = id
        }
        if let localeCode = dict["localeCode"] as? String{
            self.localeCode = localeCode
        }
        if let headline = dict["headline"] as? String{
            self.headline = headline
        }
        if let descriptionOffer = dict["description"] as? String{
            self.descriptionOffer = descriptionOffer
        }
        if let referrerRewardDict = dict["referrerReward"] as? NSDictionary{
            self.referrerReward = MentionmeReward(withDictionary: referrerRewardDict)
        }
        if let refereeRewardDict = dict["refereeReward"] as? NSDictionary{
            self.refereeReward = MentionmeReward(withDictionary: refereeRewardDict)
        }
        
    }
    
}

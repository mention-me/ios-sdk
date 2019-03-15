//
//  MentionmeReferrer.swift
//  TestMentionme
//
//  Created by Andreas Bagias on 05/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import Foundation

public class MentionmeReferrer{
    
    /**
     * Our identifier for the referrer identified, the customer ID
     */
    public var referrerMentionMeIdentifier: Int = 0
    /**
     * Token used to identify the referrer uniquely (flowId)
     */
    public var referrerToken: String = ""
    /**
     * Identify the offer
     */
    public var referrerOfferIdentifier: Int = 0
    /**
     * Description of the offer and rewards which this referrer is able to offer
     */
    public var offer: MentionmeOffer?
    
    init(withDictionary dict: NSDictionary) {
        
        if let referrerMentionMeIdentifier = dict["referrerMentionMeIdentifier"] as? Int{
            self.referrerMentionMeIdentifier = referrerMentionMeIdentifier
        }
        if let referrerToken = dict["referrerToken"] as? String{
            self.referrerToken = referrerToken
        }
        if let referrerOfferIdentifier = dict["referrerOfferIdentifier"] as? Int{
            self.referrerOfferIdentifier = referrerOfferIdentifier
        }
        if let offerDict = dict["offer"] as? NSDictionary{
            self.offer = MentionmeOffer(withDictionary: offerDict)
        }
        
    }
    
}

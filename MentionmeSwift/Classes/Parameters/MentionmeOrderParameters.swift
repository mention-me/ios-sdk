//
//  MentionmeOrderParameters.swift
//  TestMentionme
//
//  Created by Andreas Bagias on 04/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import Foundation

public class MentionmeOrderParameters{
    
    /**
     * REQUIRED - Your Order Identifier for the transaction that has taken place
     */
    public var orderIdentifier: String = ""
    /**
     * REQUIRED - Order total, excluding tax and shipping in the currency specified by currencyCode
     */
    public var total: String = ""
    /**
     * REQUIRED - 3 letter currency code for the currency in which the transaction took place
     */
    public var currencyCode: String = ""
    /**
     * REQUIRED - The date on which the transaction took place (typically the current date/time). Use ISO8601 format (e.g. 2016-11-30T17:52:50Z)
     */
    public var dateString: String = ""
    /**
     * If a coupon was used in the transaction, the coupon code the consumer used
     */
    public var couponCode: String?
    
    private init() {
        
    }
    
    public convenience init(orderIdentifier: String, total: String, currencyCode: String, dateString: String) {
        self.init()
        
        self.orderIdentifier = orderIdentifier
        self.total = total
        self.currencyCode = currencyCode
        self.dateString = dateString
    }
    
}

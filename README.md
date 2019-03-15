# MentionmeSwift

[![CI Status](https://img.shields.io/travis/andreasbagias/MentionmeSwift.svg?style=flat)](https://travis-ci.org/andreasbagias/MentionmeSwift)
[![Version](https://img.shields.io/cocoapods/v/MentionmeSwift.svg?style=flat)](https://cocoapods.org/pods/MentionmeSwift)
[![License](https://img.shields.io/cocoapods/l/MentionmeSwift.svg?style=flat)](https://cocoapods.org/pods/MentionmeSwift)
[![Platform](https://img.shields.io/cocoapods/p/MentionmeSwift.svg?style=flat)](https://cocoapods.org/pods/MentionmeSwift)

## README

Supercharge your customer growth with referral marketing through Mention Me

* Refer a friend platform tailored to your brand
* AB testing to optimise your programme
* Uniquely captures word of mouth sharing
* Best practice insight from our Client Success Team

## Installation

MentionmeSwift is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'MentionmeSwift'
```

## Documentation

[Mention Me API](https://demo.mention-me.com/api/consumer/v1/doc)

Include the below to your class to access MentionmeSwift files
```swift
import MentionmeSwift
```

To enable demo API mode and the debug network log simply include the following:
```swift
let config = MentionmeConfig(demo: true)
config.debugNetwork = true
Mentionme.shared.config = config
```
Setting it to false or not including it at all, will default to non-demo mode.

You will need to setup the Request Parameters with your partnerCode.
```swift
Mentionme.shared.requestParameters = MentionmeRequestParameters(partnerCode: "PARTNER_CODE")
```

Optionally you can create your own custom validation warning class and override the reportWarning function for analytics purposes.
```swift
Mentionme.shared.validationWarning = CustomValidationWarning()
```

### You can check if the referrer enrollment works before enrolling someone with the following:
```swift
Mentionme.shared.entryPointForReferrerEnrollment(mentionmeReferrerEnrollmentRequest: MentionmeReferrerEnrollmentRequest(), situation: "app-check-enrol-referrer", success: { (url, defaultCallToActionString) in

    //if success then enrol referrer
    
}, failure: { (error) in
    print(error?.errors)
    print(error?.statusCode)
}) { (error) in
    print(error)
}
```

### 1. Record Order
Tell us that an order took place so that we can reward any appropriate referrer
```swift
let orderParameters = MentionmeOrderParameters(orderIdentifier: orderIdentifier, total: price, currencyCode: currencyCode, dateString: dateString)
let customerParameters = MentionmeCustomerParameters(emailAddress: email, firstname: firstname, surname: surname)
let orderRequest = MentionmeOrderRequest(mentionmeOrderParameters: orderParameters, mentionmeCustomerParameters: customerParameters)

Mentionme.shared.recordOrder(mentionmeOrderRequest: orderRequest, situation: "app-record-order-screen", success: {

    //success

}, failure: { (error) in
    print(error?.errors)
    print(error?.statusCode)
}) { (error) in
    print(error)
}
```

### 2. Enrol Referrer
Tell us a customer's details to enrol them as a referrer and receive a referral offer for them to share
```swift
let parameters = MentionmeCustomerParameters(emailAddress: email, firstname: firstname, surname: surname)
let request = MentionmeCustomerRequest(mentionmeCustomerParameters: parameters)

Mentionme.shared.enrolReferrer(mentionmeCustomerRequest: request, situation: "app-enrol-referer-screen", success: { (offer, shareLinks, termsLinks) in

    //offer - Description of the offer and rewards
    //shareLinks - List of share links for different share mechanisms
    //termsLinks - Links to the terms and conditions for this offer

}, failure: { (error) in
    print(error?.errors)
    print(error?.statusCode)
}) { (error) in
    print(error)
}
```

### 3. Get referrer dashboard
Get a referrer's dashboard (given a referrer identity, get their dashboard data)
```swift
let dashboardParameters = MentionmeDashboardParameters(emailAddress: email)
let dashboardRequest = MentionmeDashboardRequest(mentionmeDashboardParameters: dashboardParameters)

Mentionme.shared.getReferrerDashboard(mentionmeDashboardRequest: dashboardRequest, situation: "app-dashboard-screen", success: { (offer, shareLinks, termsLinks, referralStats, dashboardRewards) in

    //offer - Description of the offer and rewards
    //shareLinks - List of share links for different share mechanisms
    //termsLinks - Links to the terms and conditions for this offer
    //referralStats - Referral Stats
    //dashboardRewards - Referral rewards, list of potential rewards they are due for introducing customers

}, failure: { (error) in
    print(error?.errors)
    print(error?.statusCode)
}) { (error) in
    print(error)
}
```

### 4. Find referrer by name
Search for a referrer to connect to a referee, using just their name
```swift
let request = MentionmeReferrerByNameRequest(mentionmeReferrerNameParameters: MentionmeReferrerNameParameters(name: text))

Mentionme.shared.findReferrerByName(mentionmeReferrerByNameRequest: request, situation: "app-find-referrer-screen", success: { (referrer, multipleNamesFound, contentCollectionLinks) in

    //referrer - The payload of the request
    //multipleNamesFound - Whether the user should be prompted to narrow the search (by entering an email address for example)
    //contentCollectionLinks - Pagination of output and links to associated resources, including content-collection items

}, failure: { (error) in
    print(error?.errors)
    print(error?.statusCode)
}) { (error) in
    print(error)
}
```

### 5. Link new customer to referrer
Post a referee's details to register them as a referee after successfully finding a referrer to link them to
```swift
let referrerParameters = MentionmeReferrerParameters(referrerMentionMeIdentifier: identifier, referrerToken: token)
let customerParameters = MentionmeCustomerParameters(emailAddress: email, firstname: firstname, surname: surname)

let request = MentionmeRefereeRegisterRequest(mentionmeReferrerParameters: referrerParameters, mentionmeCustomerParameters: customerParameters)

Mentionme.shared.linkNewCustomerToReferrer(mentionmeRefereeRegisterRequest: request, situation: "app-referee-register-screen", success: { (offer, refereeReward, contentCollectionLink, status) in

    //offer - Description of the offer and rewards
    //refereeReward - The details of the reward for the referee
    //contentCollectionLink - Pagination of output and link to associated resources, including content-collection items
    //status - Response status

}, failure: { (error) in
    print(error?.errors)
    print(error?.statusCode)
}) { (error) in
    print(error)
}
```

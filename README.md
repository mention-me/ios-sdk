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

This is an SDK for clients of Mention Me to integrate referral into their iOS apps.
If you're interested in becoming a client, [please contact us first](https://blog.mention-me.com/contact-us).

## Installation

### Swift Package Manager

Swift Package Manager is a dependency manager built into Xcode.

If you are using Xcode 11 or higher, go to File / Swift Packages / Add Package Dependency... and enter package repository URL https://github.com/mention-me.git, then follow the instructions.

To remove the dependency, select the project and open Swift Packages (which is next to Build Settings). You can add and remove packages from this tab.

### CocoaPods

MentionmeSwift is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'MentionmeSwift'
```

## Documentation

It's worth first reading about [integrating with Mention Me in general](https://demo.mention-me.com/api-demo/v2/generic/apps/instructions/overview). And the API reference: [Mention Me API](https://demo.mention-me.com/api/consumer/v1/doc)

Include the below to your class to access MentionmeSwift files
```swift
import MentionmeSwift
```

You will need to setup the Request Parameters with your partner code which can be obtained from your Mention Me onboarding manager.

```swift
Mentionme.shared.requestParameters = MentionmeRequestParameters(partnerCode: "PARTNER_CODE")
```

You should always use the demo mode in the SDK when developing and testing. The demo platform is a like-production version of Mention Me and will be set up with your account and has demo campaigns which will be returned when you make SDK requests.

To enable demo API mode and the debug network log simply include the following:
```swift
let config = MentionmeConfig(demo: true)
config.debugNetwork = true
Mentionme.shared.config = config
```
Setting it to false or not including it at all, will default to live mode.

You can send the demo system test/mocked customer data without risk of real customers being emailed, coupons being given out or cash/rewards changing hands. We can give you logins to the client dashboard on the demo platform at your request so you can review the state of the integration.

The offers and customer experience at each touchpoint can be disabled at any time from the Mention Me platform without requiring any development involvement so its possible to go live with your SDK app integration before any campaign is designed to start and it can start, change and finish without any further development involvement.

### There are 4 things we'll need to do in any typical customer journey (on web or in app):

 - Promote referral to those customers who are happy to share (and let them share)
 
 - Track successful orders or sign ups of new customers who may have been referred 

 - Allow "name sharing" to occur in the app for new customers who come to the app having been referred by word of mouth.

 - Show existing customers who are referrers a dashboard so they can track their shares and rewards

### 1. Enrol Referrer
Tell us a customer's details to enrol them as a referrer and receive a referral offer for them to share, including individual share methods and unique share tracking URLs to include in any native shares.

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

### Each promotional touchpoint in your app should have a specific "situation" name e.g. app-main-menu or post-purchase-success 

These different situation parameters allow us to control each touchpoint independently from the Mention Me platform meaning you can safely build new touchpoints into your app but have them turned off until fully tested and their use and variety controlled by the team managing the referral programme.

As an example, you can check if the referrer enrollment touchpoint is enabled for a particular situation (e.g. app-main-menu) before enrolling someone with the following:

```swift
Mentionme.shared.entryPointForReferrerEnrollment(mentionmeReferrerEnrollmentRequest: MentionmeReferrerEnrollmentRequest(), situation: "app-main-menu", success: { (url, defaultCallToActionString) in

    //if success then enrol referrer
    
}, failure: { (error) in
    print(error?.errors)
    print(error?.statusCode)
}) { (error) in
    print(error)
}
```

This endpoint also returns a "defaultCallToActionString" which is content which may be dynamic and can be used to set the content of a button or link. This allows the marketing team to AB test the content of such buttons (e.g. Get £20 when you refer vs Get 20% off when you refer) without the app developers needing to coordinate changes to copy.

### 2. Record Order
Tell us that an order (or customer sign up) took place so that we can reward any appropriate referrer:

```swift
let orderParameters = MentionmeOrderParameters(orderIdentifier: orderIdentifier, total: price, currencyCode: currencyCode, dateString: dateString)
let customerParameters = MentionmeCustomerParameters(emailAddress: email, firstname: firstname, surname: surname)
let orderRequest = MentionmeOrderRequest(mentionmeOrderParameters: orderParameters, mentionmeCustomerParameters: customerParameters)

Mentionme.shared.recordOrder(mentionmeOrderRequest: orderRequest, situation: "app-post-purchase", success: {

    //success

}, failure: { (error) in
    print(error?.errors)
    print(error?.statusCode)
}) { (error) in
    print(error)
}
```

### 3a. Find referrer by name
Search for a referrer to connect to a referee, using just their name
```swift
let request = MentionmeReferrerByNameRequest(mentionmeReferrerNameParameters: MentionmeReferrerNameParameters(name: text))

Mentionme.shared.findReferrerByName(mentionmeReferrerByNameRequest: request, situation: "app-checkout-name-find", success: { (referrer, multipleNamesFound, contentCollectionLinks) in

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

### 3b. Link new customer to referrer
Post a referee's details to register them as a referee after successfully finding a referrer to link them to
```swift
let referrerParameters = MentionmeReferrerParameters(referrerMentionMeIdentifier: identifier, referrerToken: token)
let customerParameters = MentionmeCustomerParameters(emailAddress: email, firstname: firstname, surname: surname)

let request = MentionmeRefereeRegisterRequest(mentionmeReferrerParameters: referrerParameters, mentionmeCustomerParameters: customerParameters)

Mentionme.shared.linkNewCustomerToReferrer(mentionmeRefereeRegisterRequest: request, situation: "app-referee-register", success: { (offer, refereeReward, contentCollectionLink, status) in

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


### 4. Get referrer dashboard
Get a referrer's dashboard (given a referrer identity, get their dashboard data)
```swift
let dashboardParameters = MentionmeDashboardParameters(emailAddress: email)
let dashboardRequest = MentionmeDashboardRequest(mentionmeDashboardParameters: dashboardParameters)

Mentionme.shared.getReferrerDashboard(mentionmeDashboardRequest: dashboardRequest, situation: "app-dashboard", success: { (offer, shareLinks, termsLinks, referralStats, dashboardRewards) in

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

Optionally you can create your own custom validation warning class and override the reportWarning function for analytics purposes.
```swift
Mentionme.shared.validationWarning = CustomValidationWarning()
```

If you'd like help designing your integration or have any questions, please reach out to your Onboarding Manager at Mention Me or email help@mention-me.com.

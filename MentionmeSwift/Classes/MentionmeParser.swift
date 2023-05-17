//
//  MentionmeParser.swift
//  TestMentionme
//
//  Created by Andreas Bagias on 04/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import Foundation

class MentionmeParser: NSObject {

  // Dictionary data parser
  static func getDictionary(data: Data?) -> NSDictionary? {
    if data == nil { return nil }
    if data?.count == 0 { return nil }

    do {
      if let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
        as? [String: Any]
      {

        if Mentionme.shared.config?.debugNetwork ?? false {
          print(json)
        }

        return json as NSDictionary?
      }
    } catch let error {
      print(error.localizedDescription)
    }
    return nil
  }

  // Offer data parser
  static func getOffer(
    data: Data,
    success: @escaping (
      _ offer: MentionmeOffer?,
      _ sharelinks: [MentionmeShareLink]?,
      _ termsLinks: MentionmeTermsLinks?
    ) -> Void, failure: @escaping (_ message: String) -> Void
  ) {
    do {
      if let json = try JSONSerialization.jsonObject(
        with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary
      {

        if Mentionme.shared.config?.debugNetwork ?? false {
          print(json)
        }

        var offer: MentionmeOffer?
        var shareLinks: [MentionmeShareLink]?
        var termsLinks: MentionmeTermsLinks?

        if let offerDict = json["offer"] as? NSDictionary {
          offer = MentionmeOffer(withDictionary: offerDict)
        }
        if let shareLinksDicts = json["shareLinks"] as? [NSDictionary] {
          shareLinks = [MentionmeShareLink]()
          for shareLinkDict in shareLinksDicts {
            shareLinks?.append(MentionmeShareLink(withDictionary: shareLinkDict))
          }
        }
        if let termsLinksDict = json["termsLinks"] as? NSDictionary {
          termsLinks = MentionmeTermsLinks(withDictionary: termsLinksDict)
        }

        success(offer, shareLinks, termsLinks)

      }
    } catch let error {
      failure(error.localizedDescription)
    }
  }

  // Referrer data Enrollment
  static func getEnrollment(
    data: Data, success: @escaping (_ url: String, _ defaultCallToAction: String) -> Void,
    failure: @escaping (_ message: String) -> Void
  ) {
    do {
      if let json = try JSONSerialization.jsonObject(
        with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary
      {

        if Mentionme.shared.config?.debugNetwork ?? false {
          print(json)
        }

        var url: String = ""
        var defaultCallToAction: String = ""

        if let urlString = json["url"] as? String {
          url = urlString
        }
        if let defaultCallToActionString = json["defaultCallToAction"] as? String {
          defaultCallToAction = defaultCallToActionString
        }

        success(url, defaultCallToAction)

      }
    } catch let error {
      failure(error.localizedDescription)
    }
  }

  // Dashboard data parser
  static func getDashboard(
    data: Data,
    success: @escaping (
      _ offer: MentionmeOffer?,
      _ links: [MentionmeShareLink]?,
      _ termsLinks: MentionmeTermsLinks?,
      _ referralStats: MentionmeReferralStats?,
      _ dashboardRewards: [MentionmeDashboardReward]?
    ) -> Void,
    failure: @escaping (_ message: String) -> Void
  ) {

    let dataString = String(data: data, encoding: String.Encoding.utf8)
    print("no data", dataString ?? "no data")

    do {
      if let json = try JSONSerialization.jsonObject(
        with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary
      {

        if Mentionme.shared.config?.debugNetwork ?? false {
          print(json)
        }

        var offer: MentionmeOffer?
        var links: [MentionmeShareLink]?
        var termsLinks: MentionmeTermsLinks?
        var referralStats: MentionmeReferralStats?
        var dashboardRewards: [MentionmeDashboardReward]?

        if let offerDict = json["offer"] as? NSDictionary {
          offer = MentionmeOffer(withDictionary: offerDict)
        }
        if let linksDict = json["shareLinks"] as? [NSDictionary] {
          links = [MentionmeShareLink]()
          for linkDict in linksDict {
            links?.append(MentionmeShareLink(withDictionary: linkDict))
          }
        }
        if let termsLinksDict = json["termsLinks"] as? NSDictionary {
          termsLinks = MentionmeTermsLinks(withDictionary: termsLinksDict)
        }
        if let referralStatsDict = json["referralStats"] as? NSDictionary {
          referralStats = MentionmeReferralStats(withDictionary: referralStatsDict)
        }
        if let referralRewardsArray = json["referralRewards"] as? [NSDictionary] {
          dashboardRewards = [MentionmeDashboardReward]()
          for refRewardDict in referralRewardsArray {
            dashboardRewards?.append(MentionmeDashboardReward(withDictionary: refRewardDict))
          }
        }

        success(offer, links, termsLinks, referralStats, dashboardRewards)
      }
    } catch let error {

      if Mentionme.shared.config?.debugNetwork ?? false {
        print("Problem parsing json response")
      }

      failure(error.localizedDescription)
    }
  }

  // Find Referrer by Name data parser
  static func getReferrerByName(
    data: Data,
    success: @escaping (
      _ referrer: MentionmeReferrer?,
      _ foundMultipleReferrers: Bool?,
      _ links: [MentionmeContentCollectionLink]?,
      _ termsLinks: MentionmeTermsLinks?
    ) -> Void, failure: @escaping (_ message: String) -> Void
  ) {
    do {
      if let json = try JSONSerialization.jsonObject(
        with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary
      {

        if Mentionme.shared.config?.debugNetwork ?? false {
          print(json)
        }

        var referrer: MentionmeReferrer?
        var foundMultipleReferrers: Bool?
        var links: [MentionmeContentCollectionLink]?
        var termsLinks: MentionmeTermsLinks?

        if let referrerDict = json["referrer"] as? NSDictionary {
          referrer = MentionmeReferrer(withDictionary: referrerDict)
        }
        if let foundMultipleReferrersDict = json["foundMultipleReferrers"] as? Bool {
          foundMultipleReferrers = foundMultipleReferrersDict
        }
        if let linksDicts = json["links"] as? [NSDictionary] {
          links = [MentionmeContentCollectionLink]()
          for linkDict in linksDicts {
            links?.append(MentionmeContentCollectionLink(withDictionary: linkDict))
          }
        }
        if let termsLinksDict = json["termsLinks"] as? NSDictionary {
          termsLinks = MentionmeTermsLinks(withDictionary: termsLinksDict)
        }

        success(referrer, foundMultipleReferrers, links, termsLinks)

      }
    } catch let error {
      failure(error.localizedDescription)
    }
  }

  // Link new Customer to Referrer data parser
  static func getRefereeRegister(
    data: Data,
    success: @escaping (
      _ offer: MentionmeOffer?,
      _ refereeReward: MentionmeRefereeReward?,
      _ contentCollectionLink: MentionmeContentCollectionLink?,
      _ status: String?,
      _ termsLinks: MentionmeTermsLinks?
    ) -> Void, failure: @escaping (_ message: String) -> Void
  ) {
    do {
      if let json = try JSONSerialization.jsonObject(
        with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary
      {

        if Mentionme.shared.config?.debugNetwork ?? false {
          print(json)
        }

        var offer: MentionmeOffer?
        var refereeReward: MentionmeRefereeReward?
        var contentCollectionLink: MentionmeContentCollectionLink?
        var status: String?
        var termsLinks: MentionmeTermsLinks?

        if let offerDict = json["offer"] as? NSDictionary {
          offer = MentionmeOffer(withDictionary: offerDict)
        }
        if let refereeRewardDict = json["refereeReward"] as? NSDictionary {
          refereeReward = MentionmeRefereeReward(withDictionary: refereeRewardDict)
        }
        if let contentCollectionLinkDict = json["content"] as? NSDictionary {
          contentCollectionLink = MentionmeContentCollectionLink(
            withDictionary: contentCollectionLinkDict)
        }
        if let statusString = json["status"] as? String {
          status = statusString
        }
        if let termsLinksDict = json["termsLinks"] as? NSDictionary {
          termsLinks = MentionmeTermsLinks(withDictionary: termsLinksDict)
        }

        success(offer, refereeReward, contentCollectionLink, status, termsLinks)
      }
    } catch let error {
      failure(error.localizedDescription)
    }
  }

}

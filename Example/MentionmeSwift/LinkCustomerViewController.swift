//
//  LinkCustomerViewController.swift
//  MentionmeSwift_Example
//
//  Created by Andreas Bagias on 07/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import MentionmeSwift
import UIKit

class LinkCustomerViewController: UIViewController {

  @IBOutlet weak var label1: UILabel!
  @IBOutlet weak var label2: UILabel!
  @IBOutlet weak var labelOff: UILabel!
  @IBOutlet weak var codeLabel: UILabel!
  @IBOutlet weak var copyButton: UIButton!
  @IBOutlet weak var continueShoppingButton: UIButton!
  @IBOutlet weak var backgroundWhiteView: UIView!
  @IBOutlet weak var emailLabel: UILabel!

  var offer: MentionmeOffer?
  var refereeReward: MentionmeRefereeReward?
  var content: MentionmeContentCollectionLink?
  var status: String?
  var email: String = ""
  var firstname: String = ""

  override func viewDidLoad() {
    super.viewDidLoad()

    configureUI()
  }

  func configureUI() {

    //status can be "Success", "OfferAlreadyFulfilled", "OfferAlreadyRedeemed"

    if let status = status {
      if status == "OfferAlreadyRedeemed" {

        backgroundWhiteView.isHidden = true
        label1.text = "You've already claimed this offer."
        label2.text =
          "You have already claimed this offer after \(firstname) introduced you. You can only claim it from one friend."

      } else if status == "OfferAlreadyFulfilled" {

        backgroundWhiteView.layer.cornerRadius = 10
        emailLabel.text = "For use by \(email) only"
        label2.text =
          "This is the same offer you've already seen. You can only use it once but in case you haven't used it yet, here it is again."
        if let descr = refereeReward?.descriptionRefereeReward {
          label1.text = descr
        } else {
          label2.text = "Thank you for coming back."
        }
        if let couponCode = refereeReward?.couponCode {
          codeLabel.text = couponCode
        }
        labelOff.text = offer?.refereeReward?.summary ?? ""

      } else if status == "Success" {

        backgroundWhiteView.layer.cornerRadius = 10
        emailLabel.text = "For use by \(email) only"
        label2.text = "This reward is valid for 7 days. We've also emailed this to you."
        if let descr = refereeReward?.descriptionRefereeReward {
          label1.text = descr
        }
        if let couponCode = refereeReward?.couponCode {
          codeLabel.text = couponCode
        }
        labelOff.text = offer?.refereeReward?.summary ?? ""

      } else if status == "ReferringSelf" {

        backgroundWhiteView.isHidden = true
        label1.text = "Sorry \(firstname)"
        var token = ""
        if let resources = content?.resource {
          for resource in resources {
            if resource.token.count > token.count {
              token = resource.token
            }
          }
        }
        label2.text = token

      } else if status == "AlreadyCustomer" {
        backgroundWhiteView.isHidden = true
        var token = ""
        if let resources = content?.resource {
          for resource in resources {
            token = resource.headline
          }
        }
        label1.text = token
        label2.text = offer?.headline ?? ""

      }

    }

    copyButton.addTarget(self, action: #selector(copyAction), for: UIControl.Event.touchUpInside)
  }

  @objc func copyAction() {
    if let couponCode = refereeReward?.couponCode {
      UIPasteboard.general.string = couponCode
    }
  }

  /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

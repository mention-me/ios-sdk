//
//  SharePanelTableViewCell.swift
//  MentionmeSwift_Example
//
//  Created by Andreas Bagias on 05/04/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import MentionmeSwift
import UIKit

protocol SharePanelTableViewCellDelegate {
  func shareUsingName()
  func shareViaEmail()
  func shareViaFacebook()
  func shareViaMessenger()
  func shareViaLink()
}

class SharePanelTableViewCell: UITableViewCell {

  @IBOutlet weak var informationLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var shareUsingNameButton: UIButton!
  @IBOutlet weak var emailShareButton: UIButton!
  @IBOutlet weak var facebookShareButton: UIButton!
  @IBOutlet weak var messengerShareButton: UIButton!
  @IBOutlet weak var linkShareButton: UIButton!

  var delegate: SharePanelTableViewCellDelegate?

  func configureViewCell(shareLinks: [MentionmeShareLink], referrerName: String) {

    nameLabel.text = referrerName

    shareUsingNameButton.addTarget(
      self, action: #selector(shareUsingNameAction), for: UIControl.Event.touchUpInside)
    emailShareButton.addTarget(
      self, action: #selector(emailShareAction), for: UIControl.Event.touchUpInside)
    facebookShareButton.addTarget(
      self, action: #selector(facebookShareAction), for: UIControl.Event.touchUpInside)
    messengerShareButton.addTarget(
      self, action: #selector(messengerShareAction), for: UIControl.Event.touchUpInside)
    linkShareButton.addTarget(
      self, action: #selector(linkShareAction), for: UIControl.Event.touchUpInside)
  }

  @objc func shareUsingNameAction() {
    delegate?.shareUsingName()
  }

  @objc func emailShareAction() {
    delegate?.shareViaEmail()
  }

  @objc func facebookShareAction() {
    delegate?.shareViaFacebook()
  }

  @objc func messengerShareAction() {
    delegate?.shareViaMessenger()
  }

  @objc func linkShareAction() {
    delegate?.shareViaLink()
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

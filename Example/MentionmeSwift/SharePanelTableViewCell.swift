//
//  SharePanelTableViewCell.swift
//  MentionmeSwift_Example
//
//  Created by Andreas Bagias on 05/04/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import MentionmeSwift

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
    
    func configureViewCell(shareLinks: [MentionmeShareLink], referrerName: String){
        
        nameLabel.text = referrerName
        
        shareUsingNameButton.addTarget(self, action: #selector(shareUsingNameAction), for: UIControlEvents.touchUpInside)
        emailShareButton.addTarget(self, action: #selector(emailShareAction), for: UIControlEvents.touchUpInside)
        facebookShareButton.addTarget(self, action: #selector(facebookShareAction), for: UIControlEvents.touchUpInside)
        messengerShareButton.addTarget(self, action: #selector(messengerShareAction), for: UIControlEvents.touchUpInside)
        linkShareButton.addTarget(self, action: #selector(linkShareAction), for: UIControlEvents.touchUpInside)
    }
    
    @objc func shareUsingNameAction(){
        delegate?.shareUsingName()
    }
    
    @objc func emailShareAction(){
        delegate?.shareViaEmail()
    }
    
    @objc func facebookShareAction(){
        delegate?.shareViaFacebook()
    }
    
    @objc func messengerShareAction(){
        delegate?.shareViaMessenger()
    }
    
    @objc func linkShareAction(){
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

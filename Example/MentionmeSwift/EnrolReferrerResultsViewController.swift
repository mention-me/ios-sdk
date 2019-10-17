//
//  FindReferrerResultsViewController.swift
//  MentionmeSwift_Example
//
//  Created by Andreas Bagias on 07/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import UIKit
import MentionmeSwift
import MessageUI

class EnrolReferrerResultsViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var copyButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var secondaryDescriptionLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var chatImageView: UIImageView!
    @IBOutlet weak var emailImageView: UIImageView!
    @IBOutlet weak var facebookImageView: UIImageView!
    @IBOutlet weak var messengerImageView: UIImageView!
    @IBOutlet weak var whatsappImageView: UIImageView!
    
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var facebookView: UIView!
    @IBOutlet weak var whatsappView: UIView!
    @IBOutlet weak var messengerView: UIView!
    @IBOutlet weak var chatView: UIView!
    
    
    var firstname: String = ""
    var surname:String = ""
    var offer: MentionmeOffer?
    var shareLinks: [MentionmeShareLink]?
    
    enum MentionType {
        case chat
        case email
        case whatsapp
        case facebook
        case messenger
    }
    
    var mentionType: MentionType = MentionType.email
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        configureUI()
        updateUI()
    }
    
    func configureUI(){
        
        copyButton.addTarget(self, action: #selector(copyAction), for: UIControl.Event.touchUpInside)
        
        label1.text = "\(firstname), simply refer one or more friends."
        if let summary = offer?.refereeReward?.summary{
            label2.text = "Treat them to \(summary) and get \(summary) for yourself. Now share it any way you like to get your reward."
        }
        
        if let shareLinks = shareLinks{
            if shareLinks.count > 0{
                if let shareLink = shareLinks.first{
                    linkLabel.text = shareLink.url
                }
            }
        }
        
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(chatAction))
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(emailAction))
        let gesture3 = UITapGestureRecognizer(target: self, action: #selector(facebookAction))
        let gesture4 = UITapGestureRecognizer(target: self, action: #selector(messengerAction))
        let gesture5 = UITapGestureRecognizer(target: self, action: #selector(whatsappAction))

        chatImageView.addGestureRecognizer(gesture1)
        emailImageView.addGestureRecognizer(gesture2)
        facebookImageView.addGestureRecognizer(gesture3)
        messengerImageView.addGestureRecognizer(gesture4)
        whatsappImageView.addGestureRecognizer(gesture5)

        chatImageView.layer.borderWidth = 1
        emailImageView.layer.borderWidth = 1
        facebookImageView.layer.borderWidth = 1
        messengerImageView.layer.borderWidth = 1
        whatsappImageView.layer.borderWidth = 1

        chatImageView.layer.borderColor = UIColor.white.cgColor
        emailImageView.layer.borderColor = UIColor.white.cgColor
        facebookImageView.layer.borderColor = UIColor.white.cgColor
        messengerImageView.layer.borderColor = UIColor.white.cgColor
        whatsappImageView.layer.borderColor = UIColor.white.cgColor
        
        if let shareLinks = shareLinks{
            for shareLink in shareLinks{
                
                if shareLink.type == "facebook"{
                    facebookView.isHidden = false
                }else if shareLink.type == "link"{
                    chatView.isHidden = false
                }else if shareLink.type == "whatsapp"{
                    whatsappView.isHidden = false
                }else if shareLink.type == "facebookmessengermobile"{
                    messengerView.isHidden = false
                }
                
            }
        }
    }
    
    func updateUI(){
        
        var descriptitionText = ""
        var shareButtonText = ""
        var titleText = ""
        
        if let shareLinks = shareLinks{
            
            // types are facebook, link, whatsapp, facebookmessengermobile
            
            for shareLink in shareLinks{
                if shareLink.type == "link" && mentionType == .chat{
                    descriptitionText = "Friends can simply enter your name at checkout to get 20% off"
                    shareButtonText = "LET ME SHARE USING MY NAME"
                    titleText = "Tell them in person"
                    secondaryDescriptionLabel.isHidden = false
                    secondaryDescriptionLabel.text = firstname + " " + surname
                }else if shareLink.type == "whatsapp" && mentionType == .whatsapp{
                    descriptitionText = shareLink.defaultShareMessage
                    shareButtonText = "SEND VIA WHATSAPP"
                    titleText = "Share By Whatsapp"
                    secondaryDescriptionLabel.isHidden = true
                }else if shareLink.type == "facebook" && mentionType == .facebook{
                    descriptitionText = shareLink.defaultShareMessage
                    shareButtonText = "SHARE"
                    titleText = "By Facebook"
                    secondaryDescriptionLabel.isHidden = true
                }else if shareLink.type == "facebookmessengermobile" && mentionType == .messenger{
                    descriptitionText = shareLink.defaultShareMessage
                    shareButtonText = "SEND ON FACEBOOK MESSENGER"
                    titleText = "By Messenger"
                    secondaryDescriptionLabel.isHidden = true
                }else if mentionType == .email{
                    descriptitionText = shareLink.defaultShareMessage
                    shareButtonText = "SEND VIA MY EMAIL"
                    titleText = "Share By Email"
                    secondaryDescriptionLabel.isHidden = true
                }
                
            }
            
        }
        
        descriptionLabel.text = descriptitionText
        shareButton.setTitle(shareButtonText, for: UIControl.State.normal)
        titleLabel.text = titleText
        
        shareButton.addTarget(self, action: #selector(shareAction), for: UIControl.Event.touchUpInside)
    }
    
    @objc func shareAction(){
        
        let message = "\(shareLinks?.first?.defaultShareMessage ?? "") \n \(shareLinks?.first?.url ?? "")"
        
        if mentionType == .email{
            
            if MFMailComposeViewController.canSendMail(){
                
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients([""])
                mail.setMessageBody(message, isHTML: false)
                present(mail, animated: true, completion: nil)
                
            }else{
                let alert = UIAlertController(title: "Error", message: "You need to set email settings.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        }else{
            
            let activity = UIActivityViewController(activityItems: [message], applicationActivities: nil)
            let excludeActivities = [UIActivity.ActivityType.airDrop,
                                     UIActivity.ActivityType.print,
                                     UIActivity.ActivityType.copyToPasteboard,
                                     UIActivity.ActivityType.assignToContact,
                                     UIActivity.ActivityType.addToReadingList,
                                     UIActivity.ActivityType.mail,
                                     UIActivity.ActivityType.init(rawValue: "com.apple.mobilenotes.SharingExtension")]
            activity.excludedActivityTypes = excludeActivities
            present(activity, animated: true, completion: nil)
        }
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @objc func copyAction(){
        if let shareLinks = shareLinks{
            if shareLinks.count > 0{
                if let shareLink = shareLinks.first{
                    UIPasteboard.general.string = shareLink.url
                }
            }
            
        }
    }
    
    func resetButtons(){
        chatImageView.image = UIImage(named: "chatIcon")
        emailImageView.image = UIImage(named: "emailIcon")
        facebookImageView.image = UIImage(named: "fbIcon")
        messengerImageView.image = UIImage(named: "messengerIcon")
        whatsappImageView.image = UIImage(named: "whatsappIcon")
    }
    
    func updateButtonsUI(){
        resetButtons()
        if mentionType == .chat{
            chatImageView.image = UIImage(named: "chatSelectedIcon")
        }else if mentionType == .email{
            emailImageView.image = UIImage(named: "emailSelectedIcon")
        }else if mentionType == .facebook{
            facebookImageView.image = UIImage(named: "fbSelectedIcon")
        }else if mentionType == .messenger{
            messengerImageView.image = UIImage(named: "messengerSelectedIcon")
        }else if mentionType == .whatsapp{
            whatsappImageView.image = UIImage(named: "whatsappSelectedIcon")
        }
    }
    
    @objc func chatAction(){
        mentionType = .chat
        updateButtonsUI()
        updateUI()
    }
    
    @objc func emailAction(){
        mentionType = .email
        updateButtonsUI()
        updateUI()
    }
    
    @objc func facebookAction(){
        mentionType = .facebook
        updateButtonsUI()
        updateUI()
    }
    
    @objc func messengerAction(){
        mentionType = .messenger
        updateButtonsUI()
        updateUI()
    }
    
    @objc func whatsappAction(){
        mentionType = .whatsapp
        updateButtonsUI()
        updateUI()
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

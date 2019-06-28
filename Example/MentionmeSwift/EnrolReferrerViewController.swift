//
//  FindReferrerViewController.swift
//  MentionmeSwift_Example
//
//  Created by Andreas Bagias on 07/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import UIKit
import MentionmeSwift

class EnrolReferrerViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var giveOffButton: UIButton!
    @IBOutlet weak var privacyButton: UIButton!
    @IBOutlet weak var warningView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    var firstname = "Logan"
    var surname = "Smith"
    var email = "logansmith813@mention-me.com"
    var privacyTermsString = ""
    var offer: MentionmeOffer?
    var shareLinks: [MentionmeShareLink]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()

        checkIfReferrerCanEnrol()
    }
    
    func configureUI(){
        
        self.navigationItem.title = "Your Order is Complete"
        self.view.isHidden = true
        giveOffButton.addTarget(self, action: #selector(giveOffAction), for: UIControlEvents.touchUpInside)
        privacyButton.addTarget(self, action: #selector(privacyAction), for: UIControlEvents.touchUpInside)
        let attrs: [NSAttributedStringKey : Any] = [NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue, NSAttributedStringKey.foregroundColor : UIColor.lightGray]
        let attributeString = NSMutableAttributedString(string: "More info and your privacy rights", attributes: attrs)
        privacyButton.setAttributedTitle(attributeString, for: .normal)
        
    }
    
    func checkIfReferrerCanEnrol(){
        
        //Check if the enrollment can even happen before trying to enrol the referrer
        Mentionme.shared.entryPointForReferrerEnrollment(mentionmeReferrerEnrollmentRequest: MentionmeReferrerEnrollmentRequest(), situation: "app-check-enrol-referrer", success: { (url, defaultCallToActionString) in
            
            //if success then enrol referrer
            self.enrolReferrer()
            
        }, failure: { (error) in
            print(error?.errors ?? "")
            print(error?.statusCode ?? "")
            if let errors = error?.errors{
                if let dict = errors.firstObject as? NSDictionary{
                    self.showMessageProblemWithPartnerCode(dict: dict)
                }
            }
        }) { (error) in
            print(error ?? "")
        }
    }
    
    func enrolReferrer(){
        
        //Creating customer parameters with email , firstname and surname
        let parameters = MentionmeCustomerParameters(emailAddress: email, firstname: firstname, surname: surname)
        //Creating the customer request needed for the referrer enrolment.
        let request = MentionmeCustomerRequest(mentionmeCustomerParameters: parameters)
        
        //Calling the API 2. Enrol Referrer
        Mentionme.shared.enrolReferrer(mentionmeCustomerRequest: request, situation: "app-enrol-referer-screen", success: { (offer, shareLinks, termsLinks) in
            
            self.updateUI(offer: offer, shareLinks: shareLinks, termsLinks: termsLinks)
            
        }, failure: { (error) in
            guard let error = error else{ return }
            if let errors = error.errors{
                print(errors)
            }
            if let statusCode = error.statusCode{
                print(statusCode)
            }
        }) { (error) in
            guard let error = error else{ return }
            print(error.localizedDescription)
        }
        
    }
    
    func showMessageProblemWithPartnerCode(dict: NSDictionary){
        
        self.view.isHidden = false
        self.warningView.isHidden = false
        self.messageLabel.text = dict["message"] as? String
        
    }
    
    func updateUI(offer: MentionmeOffer?, shareLinks: [MentionmeShareLink]?, termsLinks: MentionmeTermsLinks?){
        
        self.offer = offer
        self.shareLinks = shareLinks
        
        self.view.isHidden = false
        
        if let headline = offer?.headline{
            self.label1.text = headline
        }
        if let descriptionReward = offer?.descriptionOffer{
            self.label2.text = descriptionReward
        }
        
        if let urlString = termsLinks?.linkToTermsInLocale{
            self.privacyTermsString = urlString
        }
        
        self.giveOffButton.setTitle("INVITE A FRIEND", for: UIControlState.normal)
    }
    
    @objc func privacyAction(){
        if let url = URL(string: privacyTermsString){
            UIApplication.shared.openURL(url)
        }
    }
    
    @objc func giveOffAction(){
        self.performSegue(withIdentifier: "EnrolReferrerResultsSegue", sender: nil)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? EnrolReferrerResultsViewController{
            destination.offer = offer
            destination.shareLinks = shareLinks
            destination.firstname = firstname
            destination.surname = surname
        }
        
    }
 

}

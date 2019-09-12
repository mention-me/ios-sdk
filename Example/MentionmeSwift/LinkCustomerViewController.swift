//
//  LinkCustomerViewController.swift
//  MentionmeSwift_Example
//
//  Created by Andreas Bagias on 07/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import UIKit
import MentionmeSwift

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
    
    func configureUI(){
        
        //status can be "Success", "OfferAlreadyFulfilled", "OfferAlreadyRedeemed"
        
        if let status = status{
            
            if let resources = content?.resource{
                for resource in resources{
                    if resource.key == "headline" {
                        label1.text = resource.content
                    }
                    
                    if resource.key == "detail" {
                        label2.text = resource.content
                    }
                }
            }
            
            if status == "OfferAlreadyRedeemed" || status == "ReferringSelf" || status == "AlreadyCustomer" {
                
                backgroundWhiteView.isHidden = true
                
                
            }else if status == "OfferAlreadyFulfilled" || status == "Success" {
                
                backgroundWhiteView.layer.cornerRadius = 10
                emailLabel.text = "For use by \(email) only"
                label2.text = "This is the same offer you've already seen. You can only use it once but in case you haven't used it yet, here it is again."
                if let descr = refereeReward?.descriptionRefereeReward{
                    label1.text = descr
                }else{
                    label2.text = "Thank you for coming back."
                }
                if let couponCode = refereeReward?.couponCode{
                    codeLabel.text = couponCode
                }
                labelOff.text = offer?.refereeReward?.summary ?? ""
                
            }
            
        }
        
        
        copyButton.addTarget(self, action: #selector(copyAction), for: UIControlEvents.touchUpInside)
    }
    
    @objc func copyAction(){
        if let couponCode = refereeReward?.couponCode{
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

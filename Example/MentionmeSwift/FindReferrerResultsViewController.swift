//
//  FindReferrerResultsViewController.swift
//  MentionmeSwift_Example
//
//  Created by Andreas Bagias on 07/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import UIKit
import MentionmeSwift

class FindReferrerResultsViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var getOffButton: UIButton!
    @IBOutlet weak var emaiTextField: UITextField!
    
    var firstname: String = ""
    var referrer: MentionmeReferrer?
    var foundMultipleReferrers: Bool?
    var links: [MentionmeContentCollectionLink]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    func configureUI(){
        
        getOffButton.addTarget(self, action: #selector(getOffAction), for: UIControlEvents.touchUpInside)
        
        if let summary = referrer?.offer?.refereeReward?.summary{
            getOffButton.setTitle("GET \(summary)", for: UIControlState.normal)
            label1.text = "Great, you'll get \(summary) thanks to \(firstname)"
            label2.text = "Congratulations! Because \(firstname) referred you, you've got our BEST introductory offer... Simply enter your email address to get your voucher."
        }
        
        emaiTextField.delegate = self
    }
    
    @objc func getOffAction(){
        
        //get the parameters
        let email = emaiTextField.text!
        let identifier = "\(referrer?.referrerMentionMeIdentifier ?? 0)"
        let token = referrer?.referrerToken ?? ""
        
        //Create the Referrer Parameters
        let referrerParameters = MentionmeReferrerParameters(referrerMentionMeIdentifier: identifier, referrerToken: token)
        //Create the Customer Parameters
        let customerParameters = MentionmeCustomerParameters(emailAddress: email, firstname: "", surname: "")
        //Create the Referee Register Request
        let request = MentionmeRefereeRegisterRequest(mentionmeReferrerParameters: referrerParameters, mentionmeCustomerParameters: customerParameters)
        
        //Calling the API 5. Link new customer to referrer
        Mentionme.shared.linkNewCustomerToReferrer(mentionmeRefereeRegisterRequest: request, situation: "app-referee-register-screen", success: { (offer, refereeReward, contentCollectionLink, status) in
            
            let dict = self.prepareToNavigateToLinkCustomerResultScreen(offer: offer, refereeReward: refereeReward, contentCollectionLink: contentCollectionLink, status: status, email: email)
            self.performSegue(withIdentifier: "linkCustomerSegue", sender: dict)
            
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
    
    func prepareToNavigateToLinkCustomerResultScreen(offer: MentionmeOffer?, refereeReward: MentionmeRefereeReward?, contentCollectionLink: MentionmeContentCollectionLink?, status: String?, email: String) -> [String: Any?]{
        let dict: [String: Any?] = ["offer":offer,"refereeReward":refereeReward, "contentCollectionLink":contentCollectionLink, "status":status, "email": email]
        return dict
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? LinkCustomerViewController, let dict = sender as? [String: Any?]{
            
            destination.offer = dict["offer"] as? MentionmeOffer
            destination.status = dict["status"] as? String
            destination.content = dict["contentCollectionLink"] as? MentionmeContentCollectionLink
            destination.refereeReward = dict["refereeReward"] as? MentionmeRefereeReward
            destination.email = dict["email"] as! String
            destination.firstname = firstname
        }
        
    }
 

}

extension FindReferrerResultsViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

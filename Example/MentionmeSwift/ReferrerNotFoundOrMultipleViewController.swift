//
//  ReferrerNotFoundViewController.swift
//  MentionmeSwift_Example
//
//  Created by Andreas Bagias on 08/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import UIKit
import MentionmeSwift

class ReferrerNotFoundOrMultipleViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var findButton: UIButton!
    @IBOutlet weak var tipLabel: UILabel!
    
    var name: String = ""
    var referrer: MentionmeReferrer?
    var foundMultipleReferrers: Bool?
    var links: [MentionmeContentCollectionLink]?
    var firstname: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    func configureUI(){
        
        if let foundMultipleReferrers = foundMultipleReferrers, foundMultipleReferrers{
            label1.text = "We know a few people called \(name). Can you confirm which one is your friend?"
            label2.text = "Please enter their email address below so that we know which \(name) to thank."
            nameTextField.isHidden = true
            nameTextField.text = name
        }else{
            label1.text = "Thanks. Unfortunately, \(name) is not a name we recognise."
            label2.text = "If you think they have signed up, please check and confirm their details below."
        }
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        findButton.addTarget(self, action: #selector(findAction), for: UIControlEvents.touchUpInside)
    }
    
    @objc func findAction(){
        var name = ""
        if let foundMultipleReferrers = foundMultipleReferrers, foundMultipleReferrers{
            name = self.name
        }else{
            name = nameTextField.text!
        }
        
        let email = emailTextField.text!
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        
        //Create Referrer Name Parameters
        let referrerParams = MentionmeReferrerNameParameters(name: name)
        //Pass the email parameter to help find the referrer if the name is not sufficient
        referrerParams.email = email
        //Create ReferrerByName Request
        let request = MentionmeReferrerByNameRequest(mentionmeReferrerNameParameters: referrerParams)
        
        //Calling the API 4. Referrer By Name
        Mentionme.shared.findReferrerByName(mentionmeReferrerByNameRequest: request, situation: "app-referee-referrer-not-found-screen", success: { (referrer, multipleNamesFound, contentCollectionLinks) in
            
            self.prepareToNavigateToResultScreen(referrer: referrer, foundMultipleReferrers: multipleNamesFound, links: contentCollectionLinks)
            self.navigateToReferrerByNameResultScreen()
            
        }, failure: { (referrer, multipleNamesFound, contentCollectionLinks,error) in
            guard let error = error else{ return }
            if let errors = error.errors{
                print(errors)
            }
            if let statusCode = error.statusCode{
                print(statusCode)
            }
            
            self.showTip(contentCollectionLinks: contentCollectionLinks)
            
        }) { (error) in
            guard let error = error else{ return }
            print(error.localizedDescription)
        }
        
        
    }
    
    func prepareToNavigateToResultScreen(referrer: MentionmeReferrer?, foundMultipleReferrers: Bool?, links: [MentionmeContentCollectionLink]?){
        
        let comps = self.nameTextField.text!.components(separatedBy: " ")
        if comps.count > 0{
            if let firstname = comps.first{
                self.firstname = firstname.capitalized
            }
        }
        
        self.referrer = referrer
        self.foundMultipleReferrers = foundMultipleReferrers
        self.links = links
    }
    
    func navigateToReferrerByNameResultScreen(){
        self.performSegue(withIdentifier: "FindReferrerResultsSegue", sender: nil)
    }
    
    func showTip(contentCollectionLinks: [MentionmeContentCollectionLink]?){
        
//        guard let links = contentCollectionLinks else { return }
//        guard let link = links.first else { return }
//        guard let resource = link.resource else { return }
//        guard let content = resource.first else { return }
        
        tipLabel.text = "We couldn't find this email in our records. Please try again."//content.headline
        tipLabel.isHidden = false
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? FindReferrerResultsViewController{
            
            destination.firstname = self.firstname
            destination.referrer = self.referrer
            destination.foundMultipleReferrers = self.foundMultipleReferrers
            destination.links = self.links
            
        }
    }
 

}

extension ReferrerNotFoundOrMultipleViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

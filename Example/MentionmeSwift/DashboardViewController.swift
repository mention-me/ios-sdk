//
//  DashboardViewController.swift
//  MentionmeSwift_Example
//
//  Created by Andreas Bagias on 01/04/2019.
//  Copyright © 2019 Mention-Me. All rights reserved.
//

import UIKit
import MentionmeSwift
import CryptoSwift
import MessageUI

class DashboardViewController: UIViewController, MFMailComposeViewControllerDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    var dashboardRewards: [MentionmeDashboardReward] = [MentionmeDashboardReward]()
    var referralStats: MentionmeReferralStats?
    var offer: MentionmeOffer?
    var shareLinks: [MentionmeShareLink] = [MentionmeShareLink]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getDashboard()
    }
    
    func configureUI(){
        
        self.navigationItem.title = "Dashboard"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.register(UINib(nibName: "IntroductionTableViewCell", bundle: nil), forCellReuseIdentifier: "introductionCell")
        self.tableView.register(UINib(nibName: "StatsTableViewCell", bundle: nil), forCellReuseIdentifier: "statsCell")
        self.tableView.register(UINib(nibName: "SharePanelTableViewCell", bundle: nil), forCellReuseIdentifier: "sharePanelCell")
        self.tableView.register(UINib(nibName: "RewardTableViewCell", bundle: nil), forCellReuseIdentifier: "rewardCell")
        
    }
    
    func getDashboard(){
        
        let email = "logansmith813@mention-me.com"
        let salt = "SALT"
        let encryptedText = encryptSHA256(text: email, salt: salt).lowercased()
        
        //Adding the encrypted authentication token with sha256
        //The token consists of the email and the salt.
        Mentionme.shared.requestParameters?.authenticationToken = encryptedText
        
        let request = MentionmeDashboardRequest(mentionmeDashboardParameters: MentionmeDashboardParameters(emailAddress: email))
        
        //Calling the API 3. Dashboard
        Mentionme.shared.getReferrerDashboard(mentionmeDashboardRequest: request, situation: "dashboard-screen", success: { (offer, shareLinks, termLinks, stats, rewards) in
            
            //Update UI
            if let rewards = rewards{ self.dashboardRewards = rewards }
            self.referralStats = stats
            self.offer = offer
            if let shareLinks = shareLinks{ self.shareLinks = shareLinks }
            self.tableView.reloadData()
            
        }, failure: { (error) in
            print(error?.errors ?? "")
            print(error?.statusCode ?? "")
        }) { (error) in
            print(error ?? "")
        }
        
    }
    
    func encryptSHA256(text: String, salt: String) -> String{
        return "\(text)\(salt)".sha256()
    }
    
    func shareAction(){
        
        let message = "\(shareLinks.first?.defaultShareMessage ?? "") \n \(shareLinks.first?.url ?? "")"
        
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
    
    func shareViaEmailAction(){
        
        let message = "\(shareLinks.first?.defaultShareMessage ?? "") \n \(shareLinks.first?.url ?? "")"
        
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
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
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

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0
        }else{
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 40))
        view.backgroundColor = UIColor.white
        
        let label = UILabel(frame: CGRect(x: 16, y: 0, width: UIScreen.main.bounds.size.width-32, height: 40))
        label.text = "Track your rewards"
        view.addSubview(label)
        
        return view
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 3
        }else{
            return dashboardRewards.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            
            if indexPath.row == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "introductionCell", for: indexPath) as! IntroductionTableViewCell
                
                cell.configureViewCell()
                
                return cell
            }else if indexPath.row == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: "statsCell", for: indexPath) as! StatsTableViewCell
                
                if let stats = self.referralStats{
                    cell.configureViewCell(stats: stats)
                }
                
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "sharePanelCell", for: indexPath) as! SharePanelTableViewCell
                
                cell.configureViewCell(shareLinks: shareLinks, referrerName: "Logan Smith")
                cell.delegate = self
                
                return cell
            }
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "rewardCell", for: indexPath) as! RewardTableViewCell
            
            cell.configureViewCell(dashboardReward: dashboardRewards[indexPath.row])
            
            return cell
        }
        
    }
    
}

extension DashboardViewController: SharePanelTableViewCellDelegate{
    
    internal func shareUsingName() {
        shareAction()
    }
    
    internal func shareViaEmail() {
        shareViaEmailAction()
    }
    
    internal func shareViaFacebook() {
        shareAction()
    }
    
    internal func shareViaMessenger() {
        shareAction()
    }
    
    internal func shareViaLink() {
        shareAction()
    }
    
}

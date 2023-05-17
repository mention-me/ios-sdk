//
//  FindReferrerViewController.swift
//  MentionmeSwift_Example
//
//  Created by Andreas Bagias on 07/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import MentionmeSwift
import UIKit

class FindReferrerViewController: UIViewController {

  @IBOutlet weak var label1: UILabel!
  @IBOutlet weak var label2: UILabel!
  @IBOutlet weak var findButton: UIButton!
  @IBOutlet weak var searchTextField: UITextField!

  var referrer: MentionmeReferrer?
  var foundMultipleReferrers: Bool?
  var links: [MentionmeContentCollectionLink]?
  var firstname: String = ""

  override func viewDidLoad() {
    super.viewDidLoad()

    configureUI()
  }

  func configureUI() {

    label1.text = "Tell us who sent you so that we can thank them."
    label2.text =
      "If one of your friends loves us enough to recommend us please tell us their name below."
    searchTextField.delegate = self
    findButton.addTarget(self, action: #selector(findAction), for: UIControl.Event.touchUpInside)

    searchTextField.delegate = self

  }

  @objc func findAction() {

    //Create Referrer Name Parameters
    let referrerNameParameters = MentionmeReferrerNameParameters(name: searchTextField.text!)
    //Create ReferrerByName Request
    let request = MentionmeReferrerByNameRequest(
      mentionmeReferrerNameParameters: referrerNameParameters)

    //Calling the API 4. Referrer By Name
    Mentionme.shared.findReferrerByName(
      mentionmeReferrerByNameRequest: request,
      situation: "app-referee-find-referrer-screen",
      success: { (referrer, multipleNamesFound, contentCollectionLinks, termsLinks) in

        self.prepareToNavigateToResultScreen(
          referrer: referrer,
          foundMultipleReferrers: multipleNamesFound,
          links: contentCollectionLinks
        )
        self.navigateToReferrerByNameResultScreen()

      },
      failure: { (referrer, multipleNamesFound, contentCollectionLinks, termsLinks, error) in
        if let error = error, let statusCode = error.statusCode {
          print(error.errors ?? "")
          print(statusCode)
          self.prepareToNavigateToResultScreen(
            referrer: referrer,
            foundMultipleReferrers: multipleNamesFound,
            links: contentCollectionLinks
          )
          self.navigateToReferrerNotFoundOrMultipleReferrersScreen()
        }
      }
    ) { (error) in
      if let error = error {
        print(error)
      }
    }

  }

  func prepareToNavigateToResultScreen(
    referrer: MentionmeReferrer?, foundMultipleReferrers: Bool?,
    links: [MentionmeContentCollectionLink]?
  ) {

    let comps = self.searchTextField.text!.components(separatedBy: " ")
    if comps.count > 0 {
      if let firstname = comps.first {
        self.firstname = firstname.capitalized
      }
    }

    self.referrer = referrer
    self.foundMultipleReferrers = foundMultipleReferrers
    self.links = links

  }

  func navigateToReferrerByNameResultScreen() {
    self.performSegue(withIdentifier: "FindReferrerResultsSegue", sender: nil)
  }

  func navigateToReferrerNotFoundOrMultipleReferrersScreen() {
    self.performSegue(withIdentifier: "404StatusCodeSegue", sender: nil)
  }

  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    if let destination = segue.destination as? FindReferrerResultsViewController {

      destination.firstname = self.firstname
      destination.referrer = self.referrer
      destination.foundMultipleReferrers = self.foundMultipleReferrers
      destination.links = self.links

    } else if let destination = segue.destination as? ReferrerNotFoundOrMultipleViewController {

      destination.name = searchTextField.text!
      destination.referrer = self.referrer
      destination.foundMultipleReferrers = self.foundMultipleReferrers
      destination.links = self.links

    }
  }

}

extension FindReferrerViewController: UITextFieldDelegate {

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }

}

//
//  IntroductionTableViewCell.swift
//  MentionmeSwift_Example
//
//  Created by Andreas Bagias on 05/04/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class IntroductionTableViewCell: UITableViewCell {

    @IBOutlet weak var line1Label: UILabel!
    @IBOutlet weak var line2Label: UILabel!
    @IBOutlet weak var line3Label: UILabel!
    
    func configureViewCell(){
        
        //line1Label.text = " • "
        //line2Label.text = " • "
        //line3Label.text = " • "
        
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

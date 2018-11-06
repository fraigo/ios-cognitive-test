//
//  QuestionTableViewCell.swift
//  ios-cognitive-test
//
//  Created by Francisco on 2018-10-29.
//  Copyright © 2018 franciscoigor. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var itemInfo: UILabel!
    
    var position: Int = 0
    
    func setItem(_ position : Int){
        self.position = position
        updateView()
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        updateView()
    }
    
    func updateView(){
        if (numberLabel != nil){
            let item = TableItemCollection.item(position)
            numberLabel.text = "\(item.position)"
            questionLabel.text = item.title
            descriptionLabel.text = item.description
            var status = "-"
            if (item.state == 1){
                status = "✅"
            }
            if (item.state == 2){
                status = "❌"
            }
            itemInfo.text = "\(item.seconds) sec.\n\(status)"
        }
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      // Configure the view for the selected state
        
    }

}

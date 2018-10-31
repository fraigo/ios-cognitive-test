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
    
    var cellItem: TableItem?;
    
    func setItem(_ item : TableItem){
        self.cellItem = item;
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        if let cell = cellItem{
            numberLabel.text = "\(cell.position)"
            questionLabel.text = cell.title
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      // Configure the view for the selected state
    }

}

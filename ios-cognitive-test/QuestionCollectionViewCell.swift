//
//  QuestionCollectionViewCell.swift
//  ios-cognitive-test
//
//  Created by User on 2018-11-05.
//  Copyright © 2018 franciscoigor. All rights reserved.
//

import UIKit

class QuestionCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var item: CogView!
    
    func setContent(content: String){
        item.content = content
    }
}

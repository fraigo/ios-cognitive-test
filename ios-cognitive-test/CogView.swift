//
//  CogView.swift
//  ios-cognitive-test
//
//  Created by Francisco on 2018-10-30.
//  Copyright © 2018 franciscoigor. All rights reserved.
//

import UIKit

@IBDesignable
class CogView: UIView {

    @IBInspectable
    var content : String = "" {
        didSet {
            
        }
    }
    
    var type = 0
    var labels = [UILabel]()
    
    override func didMoveToWindow() {
        let lines = content.split(separator: ",")
        var startY : CGFloat = 4.0
        labels = [UILabel]()
        if (labels.count == 0) {
            for line in lines {
                let label = UILabel(frame:CGRect(x: 0, y: startY, width: self.frame.width, height: (self.frame.width)/4));
                label.textAlignment = .center
                label.text = String(line)
                label.font = UIFont.systemFont(ofSize: (self.frame.width)/4)
                addSubview(label)
                labels.append(label)
                startY += (self.frame.width)/4 + 4
            }
        }
    }
    
    

}

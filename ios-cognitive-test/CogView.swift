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
    
    var DIGITS     = "0️⃣,1️⃣,2️⃣,3️⃣,4️⃣,5️⃣,6️⃣,7️⃣,8️⃣,9️⃣"
    var ARROWS     = "🔼,▶️,🔽,◀️"
    var FRUITS     = "🍏,🍎,🍐,🍊,🍓,🍍,🍌,🍑,🍒,🍇"
    var VEGETABLES = "🥕,🥒,🥦,🍆,🥔,🌶,🌽,🥑,🍠,🍅"
    var FLAGS1     = "🇫🇷,🇮🇹,🇧🇪,🇬🇹,🇨🇦,🇨🇴,🇩🇪,🇪🇸,🇦🇷,🇸🇻"
    var FLAGS2     = "🇨🇱,🇺🇸,🇺🇾,🇵🇷,🇨🇳,🇧🇷,🇯🇵,🇰🇷,🇬🇧,🇵🇦"
    
    enum CogType {
        case Plain
        case Digit
        case Arrow
    }

    @IBInspectable
    var content : String = "" {
        didSet {
            
        }
    }
    
    var type : CogType = .Plain
    var labels = [UILabel]()
    
    override func didMoveToWindow() {
        let translated = translateContent()
        let lines = translated.split(separator: ",")
        var chars = 1
        if (lines.count>0){
            chars = lines[0].count
        }
        let fontSize = (self.frame.width) / CGFloat(chars+1)
        let lineHeight = fontSize + 4
        var startY : CGFloat = ( self.frame.height - lineHeight * CGFloat(lines.count) ) / 2.0
        labels = [UILabel]()
        if (labels.count == 0) {
            for line in lines {
                let label = UILabel(frame:CGRect(x: 0, y: startY, width: self.frame.width, height: lineHeight));
                label.textAlignment = .center
                label.text = String(line)
                label.font = UIFont.systemFont(ofSize: fontSize)
                addSubview(label)
                labels.append(label)
                startY += lineHeight
            }
        }
    }
    
    func translateContent() -> String{
        if (type == .Digit){
            var tmp = String(content)
            var numbers = DIGITS.split(separator: ",")
            for number in (0...9){
                tmp = tmp.replacingOccurrences(of:String(number) , with: numbers[number])
            }
            return tmp;
        }
        if (type == .Arrow){
            var tmp = String(content)
            var arrows = ARROWS.split(separator: ",")
            for number in (0...3){
                tmp = tmp.replacingOccurrences(of:String(number) , with: arrows[number])
            }
            return tmp;
        }
        return content;
    }
    
    func press(){
        let currentFont = labels[0].font
        UIView.animate(withDuration: 0.3, animations: {
            self.bounds.origin.x = -1
            self.bounds.origin.y = -1
            for label in self.labels{
                label.font = label.font.withSize(13)
            }
        }, completion:{ (finished: Bool) in
            UIView.animate(withDuration: 0.3, animations: {
                self.bounds.origin.x = 0
                self.bounds.origin.y = 0
                for label in self.labels{
                    label.font = currentFont
                }
            })
        })
    }
    
    

}

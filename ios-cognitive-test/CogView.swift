//
//  CogView.swift
//  ios-cognitive-test
//
//  Created by Francisco on 2018-10-30.
//  Copyright © 2018 franciscoigor. All rights reserved.
//

import UIKit

class Sequences {
    static var DIGITS     = "0️⃣1️⃣2️⃣3️⃣4️⃣5️⃣6️⃣7️⃣8️⃣9️⃣"
    static var ARROWS     = "🔼▶️🔽◀️"
    static var FRUITS     = "🍎🍐🍊🍓🍍🍌🍒🍏🍇🍑"
    static var VEGETABLES = "🥕🥒🥦🍆🥔🌶🌽🥑🍠🍅"
    static var FLAGS1     = "🇫🇷🇮🇹🇧🇪🇬🇹🇨🇦🇨🇴🇩🇪🇪🇸🇦🇷🇸🇻"
    static var FLAGS2     = "🇨🇱🇺🇸🇺🇾🇵🇷🇨🇳🇧🇷🇯🇵🇰🇷🇬🇧🇵🇦"
    
    static func subset(_ source: String, count: Int) -> String{
        let shuffled = String(source.shuffle())
        let index = shuffled.index(shuffled.startIndex, offsetBy: count)
        return String(shuffled[shuffled.startIndex...index])
    }
}


enum CogType {
    case Plain
    case Digit
    case Arrow
    case Fruits
    case Vegetables
    case Flags1
    case Flags2
    case Mix1
    
    static func getSequence(_ type: CogType) -> String{
        switch type {
        case .Digit:
            return Sequences.DIGITS
        case .Arrow:
            return Sequences.ARROWS
        case .Fruits:
            return Sequences.FRUITS
        case .Vegetables:
            return Sequences.VEGETABLES
        case .Flags1:
            return Sequences.FLAGS1
        case .Flags2:
            return Sequences.FLAGS2
        case .Mix1:
            return Sequences.subset(Sequences.FRUITS, count: 5) + Sequences.subset(Sequences.VEGETABLES, count: 5)
        default:
            return ""
        }
    }
    
    static func getType(_ type: String) -> CogType{
        if (type == "digit"){
            return .Digit
        }
        if (type == "arrow"){
            return .Arrow
        }
        if (type == "fruits"){
            return .Fruits
        }
        if (type == "vegetables"){
            return .Vegetables
        }
        if (type == "flags1"){
            return .Flags1
        }
        if (type == "flags1"){
            return .Flags2
        }
        if (type == "mix"){
            return .Mix1
        }
        return .Plain
    }
}

@IBDesignable
class CogView: UIView {
    
    
    @IBInspectable
    var content : String = ""
    
    
    var type : CogType = .Plain
    var labels = [UILabel]()
    
    override func didMoveToWindow() {
        updateView()
    }
    
    func updateView(){
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
        let sequence = CogType.getSequence(type)
        if (sequence != ""){
            var tmp = String(content)
            var numbers = sequence.split(separator: ",")
            for number in (0..<numbers.count){
                tmp = tmp.replacingOccurrences(of:String(number) , with: numbers[number])
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

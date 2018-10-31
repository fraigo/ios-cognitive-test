//
//  TableItem.swift
//  ios-tableview-demo
//
//  Created by Francisco on 2018-10-16.
//  Copyright © 2018 franciscoigor. All rights reserved.
//
import Foundation


struct TableItem {
    var title: String
    var description: String
    var position: Int
    var data: NSDictionary
    var option1 : String
    var option2 : String
    var option3 : String
    var option4 : String
    var answer1 : String
    var answer2 : String
    var answer3 : String
    var answer4 : String
    var result : String
    var type : String
    var state : Int
    var selectedItem : Int
    
    init(_ item: NSDictionary, pos: Int) {
        title = item.value(forKey: "title") as! String
        description = item.value(forKey: "description") as! String
        option1 = item.value(forKey: "option1") as! String
        option2 = item.value(forKey: "option2") as! String
        option3 = item.value(forKey: "option3") as! String
        option4 = item.value(forKey: "option4") as! String
        
        result = item.value(forKey: "answer1") as! String
        var answers = [
            item.value(forKey: "answer1") as! String,
            item.value(forKey: "answer2") as! String,
            item.value(forKey: "answer3") as! String,
            item.value(forKey: "answer4") as! String
        ]
        answers.shuffle()
        answer1 = answers[0]
        answer2 = answers[1]
        answer3 = answers[2]
        answer4 = answers[3]
        
        type = item.value(forKey: "type") as! String
        position = pos
        data = item
        state = 0
        selectedItem = 0
    }
}

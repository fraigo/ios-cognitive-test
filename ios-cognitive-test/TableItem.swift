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
    
    init(_ item: NSDictionary) {
        title = item.value(forKey: "title") as! String
        description = item.value(forKey: "description") as! String
        position = item.value(forKey: "position") as! Int
        option1 = item.value(forKey: "option1") as! String
        option2 = item.value(forKey: "option2") as! String
        option3 = item.value(forKey: "option3") as! String
        option4 = item.value(forKey: "option4") as! String
        answer1 = item.value(forKey: "answer1") as! String
        answer2 = item.value(forKey: "answer2") as! String
        answer3 = item.value(forKey: "answer3") as! String
        answer4 = item.value(forKey: "answer4") as! String
        result = item.value(forKey: "result") as! String
        
        
        data = item
    }
}

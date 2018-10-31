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
    var result : String
    
    init(_ item: NSDictionary) {
        title = item.value(forKey: "title") as! String
        description = item.value(forKey: "description") as! String
        position = item.value(forKey: "position") as! Int
        option1 = item.value(forKey: "option1") as! String
        option2 = item.value(forKey: "option2") as! String
        option3 = item.value(forKey: "option3") as! String
        option4 = item.value(forKey: "option4") as! String
        result = item.value(forKey: "result") as! String
        
        
        data = item
    }
}

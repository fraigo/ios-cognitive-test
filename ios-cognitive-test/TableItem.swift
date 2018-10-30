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
    
    init(_ item: NSDictionary) {
        title = item.value(forKey: "title") as! String
        description = item.value(forKey: "description") as! String
        position = item.value(forKey: "position") as! Int
    }
}

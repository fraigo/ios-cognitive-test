//
//  TableItemCollection.swift
//  ios-cognitive-test
//
//  Created by User on 2018-11-05.
//  Copyright © 2018 franciscoigor. All rights reserved.
//

import Foundation
import UIKit

class TableItemCollection {
    
    private static var tableData: [TableItem] = [TableItem]()
    private static var tableView: UITableView?
    
    static func setTable(table: UITableView){
        self.tableView = table
    }
    
    static func appendItems(items : NSArray){
        tableData.removeAll()
        for item in items {
            self.tableData.append(TableItem(item as! NSDictionary, pos: tableData.count+1))
        }
        self.tableView?.reloadData()
    }
    
    static func item(_ position: Int) -> TableItem {
        return tableData[position]
    }
    
    static func update(position: Int, item: TableItem){
        tableData[position] = item
        tableView?.reloadData()
        
    }
    
    static func count() -> Int {
        return tableData.count
    }
    
}

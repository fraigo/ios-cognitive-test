//
//  ViewController.swift
//  ios-tableview-demo
//
//  Created by Francisco on 2018-10-16.
//  Copyright © 2018 franciscoigor. All rights reserved.
//

import UIKit

class QuestionTableViewController: UITableViewController {
    
    @IBOutlet weak var questionTableView: UITableView!
    
    var tableData: [TableItem] = [TableItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionTableView.dataSource = self
        questionTableView.delegate = self
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        questionTableView.setEditing(editing, animated: animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getJsonFromUrl()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getJsonFromUrl(){
        //creating a NSURL
        let dataURL : String = "https://fraigo.github.io/ios-cognitive-test/ios-cognitive-test/questions.json"
        let url = NSURL(string: dataURL)
        
        //fetching the data from the url
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            
            if error != nil {
                print(error!)
            } else {
                if let usableData = data {
                    self.parseString(data: usableData)
                    self.parseArray(data: usableData)
                    //self.parseDictionary(data: usableData)
                    
                }
            }
            
        }).resume()
    }
    
    func parseString(data: Data){
        let string = String(data: data, encoding: String.Encoding.utf8)
        print(string!)
        
    }
    
    func parseArray(data: Data){
        if let jsonArray = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSArray {
            for item in jsonArray {
                self.tableData.append(TableItem(item as! NSDictionary))
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.questionTableView.reloadData()
            }
            
        }
    }
    
    func parseDictionary(data: Data, key: String, items: String){
        if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: key, ascending: false)
            if let itemArray = jsonObj!.value(forKey: items) as? NSArray {
                let sortedResults: NSArray = itemArray.sortedArray(using: [descriptor]) as NSArray
                for item in sortedResults {
                    self.tableData.append(TableItem(item as! NSDictionary))
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.questionTableView.reloadData()
                }
            }
        }
    }
    
    
    
    
}


extension QuestionTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // move
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! QuestionTableViewCell
        let item = tableData[indexPath.row]
        cell.setItem(item)
        cell.showsReorderControl = true
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // delete
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(tableData[indexPath.row].data);
        
    }
    
    
}

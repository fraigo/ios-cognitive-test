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
    
    var currentPosition = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionTableView.dataSource = self
        questionTableView.delegate = self
        let button = UIBarButtonItem()
        button.title = "New"
        button.target = self
        button.action = #selector(newTest)
        navigationItem.leftBarButtonItem = button
        
        loadData()
    }
    
    func loadData(){
        /** /
        let url="https://raw.githubusercontent.com/fraigo/ios-cognitive-test/master/ios-cognitive-test/questions.json"
        getJsonFromUrl(url: url, onComplete: {(data) -> Void in
            let questions = parseArray(data: data)
            self.appendItems(items: questions)
        })
        / **/
        TableItemCollection.setTable(table: questionTableView)
        let questions = NSMutableArray()
        let files = [
            "questions1",
            "questions2",
            "questions3",
            "questions4",
            "questions5"
        ]
        for file in files {
            let q1 = getJsonFromFile(name: file).shuffleData();
            let count = (Double(q1.count) / 2.0) + 1
            questions.addObjects(from: q1.subarray(with: NSRange(location: 0, length: Int(count)  )))
        }
        TableItemCollection.appendItems(items: questions)
    }
    
    @objc func newTest(){
        
        loadData()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        //questionTableView.setEditing(editing, animated: animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let viewCell = sender as! QuestionTableViewCell
        let questionView = segue.destination as! QuestionViewController
        questionView.setItem(viewCell, table: questionTableView)
    }
    
    
}


extension QuestionTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableItemCollection.count()
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // move
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! QuestionTableViewCell
        cell.setItem(indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // delete
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}


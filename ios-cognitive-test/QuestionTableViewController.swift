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
    
    var currentPosition = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionTableView.dataSource = self
        questionTableView.delegate = self
        
        navigationButtons()
        
        
        splitViewController?.delegate = self
        loadData()
    }
    
    func navigationButtons(){
        let button = UIBarButtonItem()
        button.title = "New"
        button.target = self
        button.action = #selector(reloadQuestions)
        navigationItem.leftBarButtonItem = button
        
        let button2 = UIBarButtonItem()
        button2.title = "Results"
        button2.target = self
        button2.action = #selector(viewResults)
        button2.isEnabled = false
        navigationItem.rightBarButtonItem = button2
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
    
    @objc func reloadQuestions(){
        
        let refreshAlert = UIAlertController(title: "Refresh all data", message: "All your answers will be lost.", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.loadData()
            self.updateView()
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    
    }
    
    
    @objc func viewResults(){
        ResultsViewController.show(current : self)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        //questionTableView.setEditing(editing, animated: animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateView()
    }
    
    func updateView(){
        tableView.scrollTo(position: currentPosition)
        navigationItem.rightBarButtonItem?.isEnabled = TableItemCollection.completed()
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let viewCell = sender as! QuestionTableViewCell
        currentPosition = viewCell.position
        let questionView = segue.destination as! QuestionViewController
        questionView.setItem(viewCell.position, table: questionTableView)
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


extension QuestionTableViewController : UISplitViewControllerDelegate {
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}


extension UITableView {
    
    
    func scrollTo(position: Int){
        let point = CGPoint(x: 0, y: 60.0 * CGFloat(position))
        if (position>0){
            self.setContentOffset(point, animated: true)
        }
    }
}


extension TableItemCollection {
    
    static func completed() -> Bool {
        var completed = 0
        for item in items(){
            if (item.state>0){
                completed += 1
            }
        }
        return (completed == count())
    }
}

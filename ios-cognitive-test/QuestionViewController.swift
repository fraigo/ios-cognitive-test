//
//  ViewController.swift
//  ios-cognitive-test
//
//  Created by Francisco on 2018-10-29.
//  Copyright © 2018 franciscoigor. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var optionLabel1: CogView!
    @IBOutlet weak var optionLabel2: CogView!
    @IBOutlet weak var optionLabel3: CogView!
    @IBOutlet weak var answerLabel1: CogView!
    @IBOutlet weak var answerLabel2: CogView!
    @IBOutlet weak var answerLabel3: CogView!
    @IBOutlet weak var answerLabel4: CogView!
    @IBOutlet weak var optionLabel4: CogView!
    @IBOutlet weak var section1: UIView!
    @IBOutlet weak var section2: UIView!
    @IBOutlet weak var clockLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var numberLabel: UILabel!
    
    
    private var cellItem: TableItem?
    private var cell: QuestionTableViewCell?
    private var tableView : UITableView?
    private var answer: String = ""
    
    func setItem(_ cell : QuestionTableViewCell, table: UITableView ){
        self.cell = cell
        self.cellItem = TableItemCollection.item(cell.position)
        self.tableView = table
        if ( titleLabel != nil){
            updateView();
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        addGesture(answerLabel1)
        addGesture(answerLabel2)
        addGesture(answerLabel3)
        addGesture(answerLabel4)
        updateSeconds()
        
    }
    
    func addGesture(_ label: CogView){
        let gesture = UITapGestureRecognizer()
        gesture.delegate = self
        label.addGestureRecognizer(gesture)
    }
    
    func updateView(){
        
        let optionLabels = [
            optionLabel1,
            optionLabel2,
            optionLabel3,
            optionLabel4
        ]
        let answerLabels = [
            answerLabel1,
            answerLabel2,
            answerLabel3,
            answerLabel4!
        ]
        
        
        
        if let item = cellItem {
            
            var options = [
                item.option1,
                item.option2,
                item.option3,
                item.option4
            ]
            var answers = [
                item.answer1,
                item.answer2,
                item.answer3,
                item.answer4
            ]
            
            
            titleLabel.text = item.title
            descriptionLabel.text = item.description
            answer = item.result
            numberLabel.text = "\(item.position)"
            
            
            
            // detect type
            let type = CogType.getType(item.type)
            
            section1.isHidden = (type == .Mix1 || titleLabel.text == "")
            section2.isHidden = (titleLabel.text == "")
            
            
            for index in 0...3 {
                if let label = optionLabels[index]{
                    label.content = options[index]
                    label.type = type
                    label.frame.size = CGSize(width: 100, height: 100)
                }
            }
           
            
            for index in 0...3 {
                if let label = answerLabels[index]{
                    label.content = answers[index]
                    label.type = type
                    label.tag = index
                    if (cellItem?.selectedItem == index){
                        label.backgroundColor = UIColor.yellow
                    }
                }
            }
            
            if (item.state > 0){
                view.isUserInteractionEnabled = false
            }else{
                view.isUserInteractionEnabled = true
            }
        
            
        }else{
            titleLabel.text = ""
            descriptionLabel.text = ""
            
            section1.isHidden = true
            section2.isHidden = true
            
            back()
        }
        
    }
    
    override func viewWillLayoutSubviews() {
        // change layout of stackview
        let size = UIScreen.main.bounds
        if (size.width > size.height){
            stackView.axis  = .horizontal
        }else{
            stackView.axis  = .vertical
        }
    }
    
    
    func updateSeconds(){
        if let cell = cell {
            cellItem = TableItemCollection.item(cell.position)
            clockLabel.text = "⏱ \(cellItem!.seconds)"
            if (cellItem!.state > 0){
                return;
            }
            cellItem!.seconds += 1
            TableItemCollection.update(position: cell.position, item: cellItem!)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            if self.viewIfLoaded?.window != nil {
                self.updateSeconds()
            }
       }
        
    }

    
    
}


extension QuestionViewController : UIGestureRecognizerDelegate{
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (cellItem?.state == 0){
            print("Touch")
            let view = gestureRecognizer.view as! CogView
            view.press()
            view.backgroundColor = UIColor.yellow
            if (view.content == cellItem?.result){
                cellItem?.state = 1
            }else{
                cellItem?.state = 2
            }
            cellItem!.selectedItem = view.tag
            updateView()
            TableItemCollection.update(position: (cell?.position)! , item: cellItem!)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                self.next()
            }
        }
        return true
    }
    
    
    
    func back(){
        if let FirstViewController = self.navigationController?.viewControllers.first {
            self.navigationController?.popToViewController(FirstViewController, animated: true)
        }
    }
    
    
    func next(){
        //if let FirstViewController = self.navigationController?.viewControllers.first {
            //self.navigationController?.popToViewController(FirstViewController, animated: false)
            //self.navigationController?.popViewController(animated: false)
        //}
        let index = IndexPath(row: (cell?.position)!+1, section: 0)
        print("Index \(index)")
        if let viewCell = tableView?.cellForRow(at: index){
            let newView = storyboard!.instantiateViewController(withIdentifier: "QuestionViewController") as! QuestionViewController
            newView.setItem(viewCell as! QuestionTableViewCell, table: tableView!)
            self.navigationController?.pushViewController(newView, animated: true)
            if var viewControllers = navigationController?.viewControllers {
                viewControllers.remove(at: viewControllers.count-2)
                navigationController?.viewControllers = viewControllers
            }
        }
    }
    
}

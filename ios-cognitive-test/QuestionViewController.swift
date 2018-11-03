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
    @IBOutlet weak var stack1: UIStackView!
    @IBOutlet weak var section1: UIView!
    @IBOutlet weak var section2: UIView!
    private var cellItem: TableItem?
    private var cell: QuestionTableViewCell?
    private var answer: String = ""
    
    func setItem(_ cell : QuestionTableViewCell, item: inout TableItem ){
        self.cellItem = item
        self.cell = cell
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
        
        if let cell = cellItem {
            
            var options = [
                cell.option1,
                cell.option2,
                cell.option3,
                cell.option4
            ]
            var answers = [
                cell.answer1,
                cell.answer2,
                cell.answer3,
                cell.answer4
            ]
            
            
            titleLabel.text = cell.title
            descriptionLabel.text = cell.description
            answer = cell.result
            
            // detect type
            let type = CogType.getType(cell.type)
            
            for index in 0...3 {
                if let label = optionLabels[index]{
                    label.content = options[index]
                    label.type = type
                    label.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 0.8, alpha: 1.0)
                }
            }
           
            section1.isHidden = (type == .Mix1)
            
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
            
        }else{
            titleLabel.text = ""
            descriptionLabel.text = ""
            //questionData.text = ""
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
                cell!.cellItem?.state = 1
            }else{
                cell!.cellItem?.state = 2
            }
            cell?.backgroundColor = UIColor.lightGray
            cell!.cellItem!.selectedItem = view.tag
            //cell?.isUserInteractionEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                self.back()
            }
        }
        return true
    }
    
    func back(){
        if let FirstViewController = self.navigationController?.viewControllers.first {
            self.navigationController?.popToViewController(FirstViewController, animated: true)
        }
    }
    
}

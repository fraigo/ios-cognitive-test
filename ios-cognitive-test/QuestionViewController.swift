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
    private var cellItem: TableItem?;
    private var answer: String = ""
    
    func setItem(_ item : TableItem){
        self.cellItem = item;
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
        if let cell = cellItem {
            titleLabel.text = cell.title
            descriptionLabel.text = cell.description
            //questionData.text = cell.data.descriptionInStringsFileFormat
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
            // shuffle answers
            answer = cell.answer1
            answers.shuffle()
            
            optionLabel1.content = options[0]
            optionLabel2.content = options[1]
            optionLabel3.content = options[2]
            optionLabel4.content = options[3]
            
            answerLabel1.content = answers[0]
            answerLabel2.content = answers[1]
            answerLabel3.content = answers[2]
            answerLabel4.content = answers[3]
            
            var type : CogView.CogType = .Plain
            if (cell.type == "digit"){
                type = .Digit
            }
            if (cell.type == "arrow"){
                type = .Arrow
            }
            optionLabel1.type = .Digit
            optionLabel2.type = .Digit
            optionLabel3.type = .Digit
            optionLabel4.type = .Digit
            answerLabel1.type = .Digit
            answerLabel2.type = .Digit
            answerLabel3.type = .Digit
            answerLabel4.type = .Digit
        }else{
            titleLabel.text = ""
            descriptionLabel.text = ""
            //questionData.text = ""
        }
    
        
      
    }

    
}


extension QuestionViewController : UIGestureRecognizerDelegate{
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        print("Touch")
        let view = gestureRecognizer.view as! CogView
        print(view.content, cellItem?.answer1)
        view.press()
        return true
    }
    
}

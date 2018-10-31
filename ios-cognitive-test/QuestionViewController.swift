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
    //@IBOutlet weak var questionData: UILabel!
    private var cellItem: TableItem?;
    
    func setItem(_ item : TableItem){
        self.cellItem = item;
        if ( titleLabel != nil){
            updateView();
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    func updateView(){
        if let cell = cellItem {
            titleLabel.text = cell.title
            descriptionLabel.text = cell.description
            //questionData.text = cell.data.descriptionInStringsFileFormat
            optionLabel1.content = cell.option1
            optionLabel2.content = cell.option2
            optionLabel3.content = cell.option3
            optionLabel4.content = cell.option4
            answerLabel1.content = cell.answer1
            answerLabel2.content = cell.answer2
            answerLabel3.content = cell.answer3
            answerLabel4.content = cell.answer4
            
            print(cell.data)
        }else{
            titleLabel.text = ""
            descriptionLabel.text = ""
            //questionData.text = ""
        }
    
        
      
    }

    
}


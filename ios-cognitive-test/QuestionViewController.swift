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
            optionLabel1.text = cell.option1
            print(cell.data)
        }else{
            titleLabel.text = ""
            descriptionLabel.text = ""
            //questionData.text = ""
        }
    
        
      
    }

    
}


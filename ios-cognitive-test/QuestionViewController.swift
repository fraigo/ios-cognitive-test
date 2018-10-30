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
    private var cellItem: TableItem?;
    
    func setItem(_ item : TableItem){
        self.cellItem = item;
        if ( titleLabel == nil){
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
            print(cell.data)
        }else{
            titleLabel.text = ""
        }
        
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


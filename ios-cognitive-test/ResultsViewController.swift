//
//  ResultsViewController.swift
//  ios-cognitive-test
//
//  Created by Francisco on 2018-11-06.
//  Copyright © 2018 franciscoigor. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var bestTimeLabel: UILabel!
    @IBOutlet weak var worstTimeLabel: UILabel!
    @IBOutlet weak var totalPointsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var totalTime = 0
        var bestTime = 1000
        var worstTime = 0
        var totalPoints = 0

        // Do any additional setup after loading the view.
        for item in TableItemCollection.items(){
            totalTime += item.seconds
            bestTime = min(bestTime, item.seconds)
            worstTime = max(worstTime, item.seconds)
            if (item.state == 1){
                totalPoints += 1
            }
            
        }
        
        totalTimeLabel.text = "\(totalTime) seconds"
        bestTimeLabel.text = "\(bestTime) seconds"
        worstTimeLabel.text = "\(worstTime) seconds"
        
        totalPointsLabel.text = "\(totalPoints) points"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    static func show(current: UIViewController){
        let newView = current.storyboard?.instantiateViewController(withIdentifier: "TestResults") as! ResultsViewController
        current.navigationController?.pushViewController(newView, animated: true)
    }
    

}

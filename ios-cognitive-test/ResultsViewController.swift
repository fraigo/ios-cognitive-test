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
    @IBOutlet weak var correctAnswersLabel: UILabel!
    @IBOutlet weak var totalPointsLabel: UILabel!
    
    var totalTime = 0.0
    var bestTime = 1000.0
    var worstTime = 0.0
    var totalPoints = 0.0
    var totalOk = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        for item in TableItemCollection.items(){
            totalTime += Double(item.seconds)
            bestTime = min(bestTime, Double(item.seconds))
            worstTime = max(worstTime, Double(item.seconds))
            if (item.state == 1){
                totalOk += 1
                var questionPoints = Double(item.points)
                
                if (item.seconds>5){
                    questionPoints -= 1
                }
                if (item.seconds>10){
                    questionPoints -= 3
                }
                if (item.seconds>20){
                    questionPoints -= 3
                }
                if (item.seconds>30 || questionPoints < 0){
                    questionPoints = 0
                }
                totalPoints += questionPoints
            }
            
        }
        animateResults(step: 0.0)
        
    
        
    }
    
    func animateResults(step: Double){
        totalTimeLabel.text = "\(Int(totalTime * step)) seconds"
        bestTimeLabel.text = "\(Int(bestTime * step)) seconds"
        worstTimeLabel.text = "\(Int(worstTime * step)) seconds"
        
        correctAnswersLabel.text = "\(Int(totalOk * step)) answers"
        totalPointsLabel.text = "\(Int(totalPoints * step)) points"
        if (step>=1.0){
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.animateResults(step: step + 0.1 )
        }
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

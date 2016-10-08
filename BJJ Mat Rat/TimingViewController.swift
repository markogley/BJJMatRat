//
//  TimingViewController.swift
//  BJJ Mat Rat
//
//  Created by Mark Ogley on 2016-09-19.
//  Copyright © 2016 Mark Ogley. All rights reserved.
//

import UIKit
import CoreData

class TimingViewController: UIViewController {
    
    //outlets
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var exerciseTypeLabel: UILabel!
    @IBOutlet weak var restSegmentControl: UISegmentedControl!
    
    
    //passed Properties
    var listOfExercises : [String]?
    var nameOfExerciseProgram: String?
    var managedContext: NSManagedObjectContext!
    var sentBy: String?
    var partner: Bool?
    
    //properties
    var timeInSeconds: Int = 15
    var restInSeconds: Int = 5
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateTimeLabel()
        
        print("name = \(nameOfExerciseProgram)")
        
        
        if let name = nameOfExerciseProgram {
            exerciseTypeLabel.text = name

        }
        
    }
    
    func updateTimeLabel() {
        
        
        let minsCounter = (timeInSeconds / 60) % 60
        let secondsCounter = timeInSeconds % 60
        
        timeLabel.text = String(format: "%02i:%02i", minsCounter,secondsCounter)
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func plusButtonPressed(_ sender: UIButton) {
        
        if timeInSeconds < 60 {
            
        timeInSeconds = timeInSeconds + 15
        updateTimeLabel()
        
        }
        
    }
    
    
    @IBAction func minusButtonPressed(_ sender: UIButton) {
        
        if timeInSeconds > 15 {
            
            timeInSeconds = timeInSeconds - 15
            
            updateTimeLabel()
        }
        
    }
    
    
    @IBAction func restTimeChosen(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
            
        case 0:
            restInSeconds = 5
        case 1:
            restInSeconds = 10
        case 2:
            restInSeconds = 15
        default:
            restInSeconds = 5
        
        }
        
        
    }
    
    
    
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
         let destVC = segue.destination as! DisplayExerciseViewController
        
         destVC.workoutCounter = timeInSeconds
         destVC.restCounter = restInSeconds
         destVC.typeOfWorkout = nameOfExerciseProgram
         destVC.managedContext = managedContext
         destVC.sentBy = sentBy
        
        
    }
 

}

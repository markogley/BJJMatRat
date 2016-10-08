//
//  ViewController.swift
//  BJJ Mat Rat
//
//  Created by Mark Ogley on 2016-09-09.
//  Copyright © 2016 Mark Ogley. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController{
    
    @IBOutlet weak var stretchingImageView: UIImageView!
    @IBOutlet weak var selfDrillImageView: UIImageView!
    @IBOutlet weak var partnerDrillImageView: UIImageView!
    
    
    @IBOutlet var stretchingTapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var selfDrillTapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var partnerDrillTapGestureRecognizer: UITapGestureRecognizer!
    
    //passing this property to nextviewcontroller view prepareForSegue, repeat as needed
    var managedContext: NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let mc = managedContext {
            
            print("This the managedContext\(mc)")
        }else {
            
            print("Nothing being pased")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setupDataForTableView(_ sender: UITapGestureRecognizer) {
        
        print("Test")
        performSegue(withIdentifier: "ExerciseTableViewSegue", sender: sender)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destVC = segue.destination as! ExerciseListViewController
        
        if (sender! as AnyObject).view == stretchingImageView {
            
            print("PrepareFrSegue Launched")
            
            
            destVC.workoutChoiceArray = ["Upper Body", "Lower Body", "Full Body", "BJJ Specific"]
            print(" Sender = \(sender!)")
            destVC.sentBy = "Stretch"
            
            
        }else if (sender! as AnyObject).view == selfDrillImageView || (sender! as AnyObject).view == partnerDrillImageView {
            
            
            print("prepare for segue Launched 2")
            
            destVC.workoutChoiceArray = ["Basics", "Intermediate", "Advanced"]
            destVC.sentBy = "Drill"
            destVC.partner = true
            
        }
        
        destVC.managedContext = managedContext
        
        
    }
    
    
    

}

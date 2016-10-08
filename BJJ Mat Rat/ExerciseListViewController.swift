//
//  ExerciseListViewController.swift
//  BJJ Mat Rat
//
//  Created by Mark Ogley on 2016-09-09.
//  Copyright © 2016 Mark Ogley. All rights reserved.
//

import UIKit
import CoreData

class ExerciseListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    //top layout
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var topLabelView: UILabel!
    @IBOutlet weak var topView: UIView!
    
    //passed properties
    var workoutChoiceArray: [String]?
    var sentBy: String?
    var managedContext: NSManagedObjectContext!
    var partner: Bool?
    
    //properties
    var titleForCellTapped: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       // if section == 0 {
            
           // return 1
            
        //} else if section == 1 {
        
        return workoutChoiceArray!.count
        
        //}
        //return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        
        cell.textLabel?.text = workoutChoiceArray![(indexPath as NSIndexPath).row]
        
        
        
        return cell
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if sentBy! == "Stretch" {
        
        return "Choose Your Type of Stretching"
        
    }else if sentBy! == "Drill"{
    
        return "Choose Your Drill"
    
        }else {
            
            return "Nothing"
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        titleForCellTapped = workoutChoiceArray![(indexPath as NSIndexPath).row]
        
        if let name = titleForCellTapped {
        print("\(name)")
        }
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destVC = segue.destination as! TimingViewController
        
        let indexPath : IndexPath? = tableView.indexPathForSelectedRow
        
        titleForCellTapped = workoutChoiceArray![(indexPath?.row)!]
        
        if sentBy == "Stretch" {
            
            titleForCellTapped = titleForCellTapped! + " Stretching"
            
        }else {
            
            if partner! {
            
            titleForCellTapped = titleForCellTapped! + "Partner Drills"
            
            }else {
                
                titleForCellTapped = titleForCellTapped! + "Self Drills"
                
            }
        }
        
        destVC.nameOfExerciseProgram = titleForCellTapped
        destVC.managedContext = managedContext
        destVC.sentBy = sentBy
            
        
        
    }
    
    
    
}

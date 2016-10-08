//
//  DisplayExerciseViewController.swift
//  BJJ Mat Rat
//
//  Created by Mark Ogley on 2016-09-13.
//  Copyright © 2016 Mark Ogley. All rights reserved.
//

import UIKit
import CoreData


class DisplayExerciseViewController: UIViewController {
    
    //storyboard properties
    @IBOutlet weak var displayExerciseImageView: UIImageView!
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var exerciseDescriptionLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var pausePlayButton: UIButton!
    
    
    //custom progressview
    @IBOutlet weak var circleProgressView: CircleProgressView!
    
    //CoreData
    var managedContext: NSManagedObjectContext!

    
    //passed from previous ViewController
    var workoutCounter: Int?
    var restCounter: Int?
    var typeOfWorkout: String?
    var sentBy: String?
    var partner: Bool?
    
    //ViewController specific properties
    var buttonStatusPlaying: Bool = true
    var workout: Bool = false
    var timer: Timer = Timer()
    var updatedCounter: Int!
    var listOfExerciseNames: Array<String> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //if let unwrappedCounter = workoutCounter {
            //updatedCounter = unwrappedCounter
        //}
        
        
        setUpCounter()
        insertData()
        getNamesOfExecises()
        //accessData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        timer.invalidate()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
    }
    
    
    func updateTimer() {
        
        if updatedCounter > 0 {
            
            updatedCounter = updatedCounter - 1
        
            let minsCounter = (updatedCounter / 60) % 60
            let secondsCounter = updatedCounter % 60
        
            timerLabel.text = String(format: "%02i:%02i", minsCounter,secondsCounter)
            
            if workout {
            
            updateProgressView(updatedCounter: updatedCounter, originalCounter: workoutCounter!)
        
            }
            
            if !workout {
                
                updateProgressView(updatedCounter: updatedCounter, originalCounter: restCounter!)
                
            }
            
        } else {
            
        
        timer.invalidate()
        workout = !workout
        setUpCounter()
        
        }
        
    }
    
    func updateProgressView(updatedCounter: Int, originalCounter: Int) {
        
        print("Progress = \(Float(Float(updatedCounter) / Float(originalCounter)) * 100)")
        
        let decimalProgress : Double = ((Double(updatedCounter) / Double(originalCounter)) * 100.0) / 100.0
        
        circleProgressView.progress = Double(decimalProgress)
        
    }
    
    @IBAction func pausePlayButtonPressed(_ sender: UIButton) {
        
        if buttonStatusPlaying == true {
            
            timer.invalidate()
            
            buttonStatusPlaying = false
            
            self.pausePlayButton.setBackgroundImage(UIImage(named: "Play"), for: .normal)
            
            print("BarButtonPressed: \(buttonStatusPlaying) playing status")
            
        } else  if buttonStatusPlaying == false {
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            
            buttonStatusPlaying = true
            print("BarButtonPressed: \(buttonStatusPlaying) playing status")
            
            self.pausePlayButton.setBackgroundImage(UIImage(named: "Pause"), for: .normal)
            
        }

    }
    
    func setUpCounter() {
        
        if workout {
            
            if let unwrappedCounter = workoutCounter {
                
                updatedCounter = unwrappedCounter
                accessData()
                print("Workingout")
                
            }
            
        }else if !workout {
            
            if let unwrappedCounter = restCounter {
                
                updatedCounter = unwrappedCounter
                print("Resting")
            }
            
        }
        
        fireTimer()
        
        
    }

    
    func fireTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    
    func accessData() {
        
        
        var request: NSFetchRequest<NSFetchRequestResult>? = nil
        
        switch sentBy! {
            
        case "Stretch":
            if #available(iOS 10.0, *) {
                request = Stretch.fetchRequest()
            } else {
                // Fallback on earlier versions
            }
        case "Drill":
            if #available(iOS 10.0, *) {
                request = Drill.fetchRequest()
            } else {
                // Fallback on earlier versions
            }
            
        default:
            print("Could not access CoreData")
        }
        
        let exercise = listOfExerciseNames[0]
        
        print("The exercise name is: \(exercise)")
        
        request?.predicate = NSPredicate(format: "name == %@", exercise)
        
        switch sentBy! {
        
            case "Stretch":
                
                do{
                    let results = try managedContext.fetch(request!) as! [Stretch]
            
                    populateExerciseView(exercise: results.first!)
                    print("The results are: \(results)")
            
                }catch let error as NSError {
            
                    print("Could not fetch \(error.localizedDescription)")
            
                }
            
            case "Drill":
                do{
                    let results = try managedContext.fetch(request!) as! [Drill]
                    
                    populateExerciseView(exercise: results.first!)
                    print("The results are: \(results)")
                    
                }catch let error as NSError {
                    
                    print("Could not fetch \(error.localizedDescription)")
                    
            }
            
        default:
            print("Could not populate")
        }
        
    }
    
    func populateExerciseView(exercise: AnyObject){
        
        exerciseNameLabel.text = exercise.name
        
        
        if listOfExerciseNames.count > 0 {
        
            listOfExerciseNames.remove(at: 0)
        
        }else {
            
            print("Finished")
        }
        
    }
    
    
    //CoreData Info
    func insertData() {
        
        let fetchRequest: NSFetchRequest<Stretch> = Stretch.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "name != nil")
        
        do{
            let count = try managedContext.count(for: fetchRequest)
            
            if count > 0 { return }
            print("Count is :\(count)")
    
        }catch let error as NSError {
            
           print("\(error.localizedDescription)")
            
        }
        
        var plistToLoad: String?
        
        switch sentBy! {
            
            case "Stretch":
                plistToLoad = "\(sentBy!)ingList"
                print("\(plistToLoad!)")
            case "Self":
                plistToLoad = "\(sentBy!)List"
                print("\(plistToLoad!)")
            case "Partner":
                plistToLoad = "\(sentBy!)List"
                print("\(plistToLoad!)")
            default:
                print("Nothing Sent")
            
        }
        
        let path = Bundle.main.path(forResource: plistToLoad!, ofType: "plist")
        
        let dataArray = NSArray(contentsOfFile: path!)
        
        
        for dict in dataArray! {
            
            let entity = NSEntityDescription.entity(forEntityName: sentBy!, in: managedContext)
            
            let stDict = dict as! NSDictionary
            
            switch sentBy! {
            
                case "Stretch":
                    let stretch = Stretch(entity: entity!, insertInto: managedContext)
                
                    stretch.name = stDict["name"] as? String
                    stretch.detail = stDict["detail"] as? String
                    stretch.body = stDict["body"] as? String
                    stretch.skipped = (stDict["skipped"] as? NSNumber)!
                    stretch.sides = (stDict["sides"] as? NSNumber)!
                
                
                case "Drill":
                    let drill = Drill(entity: entity!, insertInto: managedContext)
                
                   drill.name = stDict["name"] as? String
                   drill.detail = stDict["detail"] as? String
                   drill.skipped = (stDict["skipped"] as? NSNumber)!
                   drill.partner = (stDict["partner"] as? NSNumber)!
                   drill.type = stDict["type"] as? String
                
                default:
                     print("Could not load any Data")
            }
       
        }
                
    }
    
    func getNamesOfExecises() {
        
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: sentBy!)
        
        let entityDesc = NSEntityDescription.entity(forEntityName: sentBy!, in: managedContext)
        request.entity = entityDesc
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        if sentBy! == "Stretch"{
        
        do {
            
            let nameList = try managedContext.fetch(request) as! [Stretch]
            
            for item in nameList {
                
                if let name = item.value(forKey: "name") {
                    
                    listOfExerciseNames.append(name as! String)
                }
                
            }
            
        }catch {
            let fetchError = error as NSError
            print("\(fetchError)")
            
            }
        }else if sentBy! == "Drill" {
            
            do {
                
                let nameList = try managedContext.fetch(request) as! [Drill]
                
                for item in nameList {
                    
                    if let name = item.value(forKey: "name") {
                        
                        listOfExerciseNames.append(name as! String)
                    }
                    
                }
                
            }catch {
                let fetchError = error as NSError
                print("\(fetchError)")
                
            }

        }
        
        print("\(listOfExerciseNames)")

    }
    

}


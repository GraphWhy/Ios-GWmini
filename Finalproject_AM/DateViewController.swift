//
//  DateViewController.swift
//  Finalproject_AM
//
//  Created by Alexander Truong McNulty on 6/15/18.
//  Copyright © 2018 Alexander Truong McNulty. All rights reserved.
//

import UIKit
import CoreData

class DateViewController: UIViewController, NSFetchedResultsControllerDelegate {
    var fetchTimeResultsController : NSFetchedResultsController<TimeMO>!
    var appDelegate = (UIApplication.shared.delegate as? AppDelegate)
    
    @IBOutlet var dateKeeper: UIDatePicker!
    var time : [TimeMO]?
    var date: Date = Date()
    func save(){
        time = []
        let fetchRequest : NSFetchRequest<TimeMO> = TimeMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "dateCurrent", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let context = appDelegate?.persistentContainer.viewContext
        fetchTimeResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context!, sectionNameKeyPath: nil, cacheName: nil)
        fetchTimeResultsController.delegate = self
        do {
            try fetchTimeResultsController.performFetch()
            if let fetchedObjects = fetchTimeResultsController.fetchedObjects {
                time = fetchedObjects
            }
        } catch {
            print(error)
        }
        date = self.dateKeeper.date
        if time! == []{
            let newTime = TimeMO(context: (appDelegate?.persistentContainer.viewContext)!)
            newTime.dateCurrent = date
            appDelegate?.saveContext()
        } else {
            time![0].dateCurrent = date
        }
        appDelegate?.saveContext()
    }
    @IBAction func update(_ sender: UIDatePicker) {
        save()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        dateKeeper?.datePickerMode = .date
        dateKeeper?.backgroundColor = .white
        dateKeeper?.maximumDate = Date()
        dateKeeper?.setValue(UIColor.blue, forKeyPath: "textColor")
        // Do any additional setup after loading the view.
        save()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

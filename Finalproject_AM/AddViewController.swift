//
//  AddViewController.swift
//  Finalproject_AM
//
//  Created by Alexander Truong McNulty on 6/13/18.
//  Copyright © 2018 Alexander Truong McNulty. All rights reserved.
//

import UIKit
import CoreData


class AddViewController: UIViewController{
    var fetchResultsController : NSFetchedResultsController<QuestionMO>!
    
    let appDelegate = (UIApplication.shared.delegate as? AppDelegate)

    var Questions : [QuestionMO]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        option1.isUserInteractionEnabled = false
        option2.isUserInteractionEnabled = false
        // Do any additional setup after loading the view.
        
        Questions = []
        let fetchRequest : NSFetchRequest<QuestionMO> = QuestionMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "prompt", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let context = appDelegate?.persistentContainer.viewContext
        fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context!, sectionNameKeyPath: nil, cacheName: nil)
        //trouble!!!
        fetchResultsController.delegate = self as? NSFetchedResultsControllerDelegate
        do {
            try fetchResultsController.performFetch()
            if let fetchedObjects = fetchResultsController.fetchedObjects {
                Questions = fetchedObjects
            }
        } catch {
            print(error)
        }
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

    @IBOutlet var promptF: UITextField!
    var newQuestion : QuestionMO!
    //var answer : AnswersMO!
    @IBAction func createButton(_ sender: Any) {
        if self.promptF?.text == "" {
            let promptAlert = UIAlertController(title: "Please enter a daily question.", message: "How about: Did you have a pleseant conversation", preferredStyle: UIAlertControllerStyle.alert)
            promptAlert.addAction(UIAlertAction(title:"ok", style: UIAlertActionStyle.default, handler:nil))
            self.present(promptAlert, animated: true, completion: nil)
        } else {
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                newQuestion = QuestionMO(context: appDelegate.persistentContainer.viewContext)
                
                //let strr : String? = promptF?.text
                newQuestion?.prompt = promptF.text!
                newQuestion?.expanded = true
                newQuestion?.questionOrder = Int32((Questions?.count)!)
                appDelegate.saveContext()
            }
        }
        self.dismiss(animated: true, completion: nil)

    }
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var option1: UITextField!
    @IBOutlet weak var option2: UITextField!
}

//
//  TableViewController.swift
//  Finalproject_AM
//
//  Created by Alexander McNulty on 6/7/18.
//  Copyright © 2018 Alexander McNulty. All rights reserved.
//



import UIKit
import CoreData




class TableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    var fetchResultsController : NSFetchedResultsController<QuestionMO>!
    var fetchTimeResultsController : NSFetchedResultsController<TimeMO>!
    
    let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
    
    /*
     var Questions = [
     Question(prompt: "Have you been mostly happy?", expanded: true),
     Question(prompt: "Are you looking forward to tomrrow?", expanded: true),
     Question(prompt: "Have you accomplished enough today?", expanded: true),
     Question(prompt: "Have you exersized?", expanded: true),
     Question(prompt: "Have you taken your vitamins?", expanded: true),
     Question(prompt: "Have you cussed/cursed?", expanded: true)
     ]
     */
    
    var Questions : [QuestionMO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        getTime()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getTime()
        
        let fetchRequest : NSFetchRequest<QuestionMO> = QuestionMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "prompt", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let context = appDelegate?.persistentContainer.viewContext
        fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context!, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultsController.delegate = self
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
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Questions.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "questionCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell
        // Configure the cell...
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none

        
        cell.questionLabel?.text = Questions[indexPath.row].prompt
        return cell
    }
    // code from tutorial
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if Questions[indexPath.row].expanded {
        } else {
            Questions[indexPath.row].expanded = true
        }
        
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    var lastAnsweredArr: [AnswerMO]!
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        getTime()
        var importantDate : Date = (time.last?.dateCurrent)!
        
        if Questions[indexPath.row].expanded {
            return 220
        }
        //MAKING A (what i would consider) SERIOUS BOTTLE NECK
        lastAnsweredArr = Questions[indexPath.row].answers?.allObjects as! [AnswerMO]
        for answer:AnswerMO in lastAnsweredArr! {
            let dddate = answer.date
            let order = Calendar.current.compare(dddate!, to: importantDate, toGranularity: .day)
            if order == .orderedSame {
                if Questions[indexPath.row].expanded != false{
                    Questions[indexPath.row].expanded = false
                    tableView.beginUpdates()
                    tableView.endUpdates()
                }
                return 85
            }
        }
        return 220
    }
    
    var newAnswer : AnswerMO!
    @IBAction func yesVote(_ sender: UIButton) {
        var superview = sender.superview
        while let view = superview, !(view is UITableViewCell) {
            superview = view.superview
        }
        guard let cell = superview as? UITableViewCell else {
            print("button is not contained in a table view cell")
            return
        }
        guard let indexPath = tableView.indexPath(for: cell) else {
            print("failed to get index path for cell containing button")
            return
        }
        // Got the index path for the cell that contains the button
        print("Yes button is in row \(indexPath.row)")
        vote(answer: 1, indexPath: indexPath)
    }
    @IBAction func noVote(_ sender: UIButton) {
        var superview = sender.superview
        while let view = superview, !(view is UITableViewCell) {
            superview = view.superview
        }
        guard let cell = superview as? UITableViewCell else {
            print("button is not contained in a table view cell")
            return
        }
        guard let indexPath = tableView.indexPath(for: cell) else {
            print("failed to get index path for cell containing button")
            return
        }
        print("No button is in row \(indexPath.row)")
        vote(answer: 0, indexPath: indexPath)
    }
    
    
    
    
    //let dateGetter: DateViewController =  DateViewController(nibName: nil, bundle: nil)
    var time: [TimeMO] = []
    func getTime() {
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
    }
    
    
    
    //var dateGetter: DateViewController = DateViewController(nibName: nil, bundle: nil)
    func vote(answer: Int, indexPath: IndexPath) {
        
        getTime()
        
        
        newAnswer = AnswerMO(context: (appDelegate?.persistentContainer.viewContext)!)
        newAnswer?.answer = Int16(answer)
        print(time.last?.dateCurrent as Any)
        newAnswer?.date = time.last?.dateCurrent
        Questions[indexPath.row].addToAnswers(newAnswer)
        Questions[indexPath.row].expanded = false
        
        appDelegate?.saveContext()
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    var deletedId : Int = 0
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let context = appDelegate?.persistentContainer.viewContext
            
            let itemToDelete = self.fetchResultsController.object(at: indexPath)
            deletedId = Int(itemToDelete.questionOrder)
            context?.delete(itemToDelete)
            appDelegate?.saveContext()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    
    //if segue.identifier == "AddQuestion" {
    //    let addVC = segue.destination as! AddViewController
    //    addVC.newPrompt = addData
    //    addData(newItem: addVC.newQuestion)
    //}
    //}
    //func addData(newPrompt : String) {
    //    let newItem = Question(prompt: newPrompt, expanded: true)
    //    Questions.append(newItem)
    //}
    
    
    
    
    // FETCH INFORMATION FROM COREDATA
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
                tableView.reloadData()
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadData()
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
                tableView.reloadData()
            }
        default:
            tableView.reloadData()
        }
        if let fetchedObjects = controller.fetchedObjects {
            if fetchedObjects.filter({ $0.isKind(of: TimeMO.self)}).count != 0 {
                time = fetchedObjects.filter() { $0.isKind(of: TimeMO.self)} as! [TimeMO]
            }
            if fetchedObjects.filter({ $0.isKind(of: QuestionMO.self)}).count != 0  {
                Questions = fetchedObjects.filter() { $0.isKind(of: QuestionMO.self)} as! [QuestionMO]
                
                /*if deletedId != 0 {
                    let context = appDelegate?.persistentContainer.viewContext
                    for i in 0..<Questions.count{
                        if Questions[i].questionOrder < deletedId {
                            Questions[i].questionOrder = Int32(deletedId)
                            deletedId = deletedId + 1
                        }
                    }
                    appDelegate?.saveContext()
                    deletedId = 0
                }
                 */
            }
            //Questions = fetchedObjects as! [QuestionMO]
        }
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
}


//if fetchedObjects.count == (time.count + 1){
//   time = fetchedObjects as! [TimeMO]
//}
//if fetchedObjects.count != (Questions.count + 1){
//    Questions = fetchedObjects as! [QuestionMO]
//}

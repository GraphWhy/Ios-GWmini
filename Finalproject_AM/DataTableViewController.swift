//
//  DataTableViewController.swift
//  Finalproject_AM
//
//  Created by Alexander Truong McNulty on 6/14/18.
//  Copyright © 2018 Alexander Truong McNulty. All rights reserved.
//
import UIKit
import CoreData



class DataTableViewController: UITableViewController,  NSFetchedResultsControllerDelegate  {
    var fetchResultsController : NSFetchedResultsController<QuestionMO>!
    let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
    var jMax : Int = 0
    var lastJ = 0
    var doneBefore = 0
    var shouldBeDone = 0
    var lastJMax = 0
    var Questions : [QuestionMO] = []
    var aString = Set<String>()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        createKey()

        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        jMax = 0

        createKey()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return keyList.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let questionKey = keyList[section]
        if let questionValue = sectionDict[questionKey] {
            return 1
        } else {
            return 0
        }
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keyList[section]
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if jMax  != 0 {
            return CGFloat(50 + (9 * jMax))
        }
        return 50
    }
    
    @IBOutlet weak var keyCell: UIView!
    
    
    var a = 0
    var b = 0
    var xRect = 5
    var yRect = 10
    var wRect = 8
    var hRect = 8
    var i = 0
    var color = [#colorLiteral(red: 0.7159002205, green: 0.7519180853, blue: 1, alpha: 1),#colorLiteral(red: 0.4880080041, green: 0.4273793394, blue: 0.9386941386, alpha: 1),#colorLiteral(red: 0.2945601255, green: 0.5465806749, blue: 0.9386941386, alpha: 1), #colorLiteral(red: 0.44840756, green: 0.798639889, blue: 0.8748178433, alpha: 1), #colorLiteral(red: 0.5741740892, green: 0.8748178433, blue: 0.5414004639, alpha: 1),  #colorLiteral(red: 0.389306744, green: 0.9335127915, blue: 0.7395909751, alpha: 1),   #colorLiteral(red: 0.3095545338, green: 0.5655764249, blue: 0.2324836445, alpha: 1), #colorLiteral(red: 0.606016352, green: 0.9048421637, blue: 0.6626235875, alpha: 1), #colorLiteral(red: 0.758913188, green: 0.9048421637, blue: 0.5555342065, alpha: 1), #colorLiteral(red: 0.9048421637, green: 0.888654018, blue: 0.1948644217, alpha: 1), #colorLiteral(red: 0.9346050127, green: 0.7796793077, blue: 0.1454421835, alpha: 1), #colorLiteral(red: 0.9670843909, green: 0.7241435207, blue: 0.3248169758, alpha: 1), #colorLiteral(red: 0.9670843909, green: 0.6777772679, blue: 0.5210557656, alpha: 1), #colorLiteral(red: 0.9670843909, green: 0.6951637315, blue: 0.6609211794, alpha: 1), #colorLiteral(red: 0.9670843909, green: 0.6725604544, blue: 0.7310534835, alpha: 1), #colorLiteral(red: 1, green: 0.8040505628, blue: 0.8774504553, alpha: 1), #colorLiteral(red: 0.9859373539, green: 0.8916180043, blue: 1, alpha: 1), #colorLiteral(red: 0.7264629015, green: 0.7435494548, blue: 1, alpha: 1)]
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cellIdentifier  = "dataCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DataTableViewCell
        
        for subview in cell.contentView.subviews {
            if let view = subview as? UIView {
                view.removeFromSuperview()
            }
        }
        var er = 0
 //       for keyShiz in keyCell.subviews {
 //           er = er + 1
  //          if er > 7 {
  //              if let view = keyShiz as? UIView {
   //                 view.removeFromSuperview()
  //              }
  //          }
  //      }
        
        let currentKey = keyList[indexPath.section]
        //var newAnswer : [AnswerMO] = []
        
        
        if let keyValue = sectionDict[currentKey] {
            
            //cell.label1.text = String(describing: keyValue[indexPath.row].date)
            //cell.label2.text = String(describing: keyValue[indexPath.row].answer)
            print(keyValue[indexPath.row].answer)
            //let answerArr = keyValue[indexPath.row].date
            //for obj in answerArr! {
            //   newAnswer.append(obj as! AnswerMO)
            //}
            //var answerText : String = ""
            //let temparr:[String] = []
            var dd : Date!
            let p = Date()
            var j : Int
            var pday = calendar.component(.day, from: p)
            var pyear = calendar.component(.year, from: p)
            var pmonth = calendar.component(.month, from: p)

            
            xRect = 5
            yRect = 14
            wRect = 8
            hRect = 8
            for i in 1..<32 {
                for jj in 1..<(jMax+1) {
                    let vwSq4 = UIView()
                    vwSq4.backgroundColor = #colorLiteral(red: 0.9067869364, green: 0.9327910194, blue: 0.941183614, alpha: 1)
                    vwSq4.frame = CGRect(x: xRect+(i*9), y: yRect+(9*jj), width: wRect, height: hRect)
                    cell.addSubview(vwSq4)
                }
            }

            if lastJMax == jMax{
            } else{
                shouldBeDone = shouldBeDone + Questions.count
                lastJMax = jMax
            }
            var jArr = Set<String>()

            for value in keyValue {
                var rrr = String((value.question?.prompt)!)
                if jArr.count == 0 {
                    jArr.insert(String(rrr))
                }
                var insertionResult2 = jArr.insert(String(rrr))
                if insertionResult2.inserted {
                }
                j = jArr.count


                xRect = 5
                yRect = 14
                wRect = 8
                hRect = 8
                
                dd = value.date
                pday =  calendar.component(.day, from: dd!)
                pyear = calendar.component(.year, from: dd!)
                pmonth = calendar.component(.month, from: dd!)
                xRect = xRect + (9 * Int(pday))
                let vwSq = UIView()
                vwSq.backgroundColor = color[j]
                if value.answer == 0 {
                    vwSq.frame = CGRect(x: xRect+2, y: yRect+(9*j)+2, width: wRect-4, height: hRect-4)
                } else if value.answer == 1 {
                    vwSq.frame = CGRect(x: xRect, y: yRect+(9*j), width: wRect, height: hRect)
                }
                cell.addSubview(vwSq)
                
                xRect = 5
                yRect = 14
                wRect = 8
                hRect = 8
                //set up keycell
                //if j > lastJ && j < Questions.count+1 && doneBefore < shouldBeDone{
                if  j < Questions.count+1 && doneBefore < shouldBeDone{
                    keyCell.frame = CGRect(x:0 , y:0, width:self.view.frame.width, height:135 + self.view.frame.height * 0.027 * CGFloat(jMax))
                    let vwSq2 = UIView()
                    vwSq2.backgroundColor = color[j]
                    vwSq2.frame = CGRect(x: 30, y: 119+16*j, width: Int(Double(wRect) * 1.7), height: Int(Double(hRect)*1.7))
                    keyCell.addSubview(vwSq2)
                    //set labels for the key colors
                    let keytext =  UILabel(frame: CGRect(x: 90, y: 119+(16*j), width: 300, height: Int(Double(hRect)*1.7)))
                    keytext.text = value.question?.prompt
                    print(String(describing: value.question?.prompt))
                    keytext.font = UIFont.systemFont(ofSize: 14)
                    var insertionResults = aString.insert((value.question?.prompt)!)
                    if insertionResults.inserted {
                        doneBefore = doneBefore + 1
                        keyCell.addSubview(keytext)

                    }
                }
                lastJ = j
                
                xRect = 5
                yRect = 14
                wRect = 8
                hRect = 8
            }
            
            //let r = calendar.range(of: .day, in: .month, for: dd!)!
            //let kDays = r.count
            //let dateFormatter = DateFormatter()
            //print("the number of days is ... \(kDays)")
            //let months = dateFormatter.shortMonthSymbols
            //let monthSymbol = months![pmonth-1] // month - from your date components
            
            //print(monthSymbol)
            
            //let string = monthSymbol + String(describing: pyear) + " 1st - " + String(kDays) + "st"

            //vwSq = UIView()
            //vwSq.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            //let newyRect = yRect + (9 * (jMax + 2))
            //vwSq.frame = CGRect(x: xRect, y: newyRect, width: wRect, height: hRect)
            //cell.addSubview(vwSq)
            
            xRect = 5
            yRect = 14
            wRect = 8
            hRect = 8
            i = i+1
            var check = 0
            if check != indexPath.section{
                i = 0
                check = indexPath.section
            }
            cell.selectionStyle = UITableViewCellSelectionStyle.none
        }
        
        return cell
    }
    /*// Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }*/
    /*// Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }*/
    /*// Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }*/
    /*// Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }*/
    /*// MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }*/
    
    let calendar = NSCalendar.current
    var date = NSDate()
    //let components = NSCalendar.current.components(CalendarUnitMonth, fromDate: date)
    var Answers : [AnswerMO] = []
    var keyList = [String]()
    var sectionDict = [String: [AnswerMO]]()
    func createKey(){
        lastJ = 0

        jMax=0
        Answers = []
        Questions = []
        keyList = []
        a = 0
        b = 0
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
        print(Questions)
        
        keyList = [String]()
        sectionDict = [String: [AnswerMO]]()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let minute:TimeInterval = 60.0
        let hour:TimeInterval = 60.0 * minute
        //let day:TimeInterval = 24 * hour

        let calendar = Calendar.current
        for question in Questions {
            
            jMax = jMax + 1
            for answer in question.answers!{
                let currentAnswer = answer as! AnswerMO
                let dd = currentAnswer.date
                if dd != nil {
                    let year = calendar.component(.year, from: dd!)
                    let month = calendar.component(.month, from: dd!)
                    //_ day = calendar.component(.day, from: dd!)
                    let p = Date()
                    let pyear = calendar.component(.year, from: p)
                    let pmonth = calendar.component(.month, from: p)
                    //let pday = calendar.component(.day, from: p)
                    //_ dateFormatter: DateFormatter = DateFormatter()
                    
                    let months = dateFormatter.monthSymbols
                    let monthSymbol = months![month-1] // month - from your date components
                    
                    let r = calendar.range(of: .day, in: .month, for: dd!)!
                    let kDays = r.count
                    
                    print(monthSymbol)
                    let orderNum = 0 + (pmonth + (pyear*12)) - (month + (year*12))
                    let letters = ["1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
                    
                    let string = letters[orderNum] + ":     " + monthSymbol + ", " + String(describing: year) + ": 1st - " + String(kDays) + "st"
                    
                    if month == pmonth || year == pyear {
                        print("standard")
                        print(string)
                        let cKey = string
                        if var valueArr = sectionDict[String(cKey)] {
                            valueArr.append(currentAnswer)
                            sectionDict[cKey] = valueArr
                        } else {
                            sectionDict[cKey] = [currentAnswer]
                        }
                    } else if month != pmonth || year != pyear {
                        let cKey = string
                        if var valueArr = sectionDict[String(cKey)] {
                            valueArr.append(currentAnswer)
                            sectionDict[cKey] = valueArr
                        } else {
                            sectionDict[cKey] = [currentAnswer]
                        }
                    }
                }
            }
        }
        keyList = [String](sectionDict.keys)
        keyList.sort()
        tableView.reloadData()
        
    }
}

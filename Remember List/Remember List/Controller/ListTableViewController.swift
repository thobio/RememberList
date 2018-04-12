//
//  ListTableViewController.swift
//  Remember List
//
//  Created by Thobio on 10/04/18.
//  Copyright © 2018 STapps. All rights reserved.
//

import UIKit
import CoreData

var details = [Detials]()

class ListTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    //MARK: - Variable decalartion
    
    @IBOutlet weak var dayLabel: UILabel!
    var dates = NSDate()
    @IBOutlet weak var tableViews: UITableView!
    @IBOutlet weak var viewBacke: UIView!
    
    //MARK: - Main Function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViews.delegate = self
        self.tableViews.dataSource = self
        labelValue()
        NotificationCenter.default.addObserver(self, selector: #selector(self.timeChangedNotification(notification:)), name: NSNotification.Name.NSCalendarDayChanged, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getDate()
        tableViews.reloadData()
    }
    func labelValue(){
        DispatchQueue.main.async { // Correct
            self.dayLabel.text = "\(String(self.daysBetweenDates(endDate: self.dates))) \nDays Left"
        }
    }
    
    func daysBetweenDates(endDate: NSDate) -> Int
    {
        let diffInDays = Calendar.current.dateComponents([.day], from: Date(), to: endDate as Date).day
        return diffInDays!
    }
    
    // MARK: - Method get called user changed the system time manually.
    
    @objc func timeChangedNotification(notification:NSNotification){
        labelValue()
    }

    //MARK: - Converting the Date to String Formate
    
    func getDateCoreDate(getDate:Date)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let dateString = dateFormatter.string(from: getDate)
        return dateString
    }
    
    //MARK: - Core Data Get the value
    
    func getDate(){
        do
        {
            let requests:NSFetchRequest<Detials> =  Detials.fetchRequest()
            requests.predicate = NSPredicate(format: "dates == %@", dates)
            details = (try context?.fetch(requests))!
        }catch  {
            print("Fetch Failed")
        }
    }
    
    //MARK: - Item Action button

    @IBAction func BackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func AddListToCoredata(_ sender: Any) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc:AddDateViewController  = storyboard.instantiateViewController(withIdentifier: "AddList") as! AddDateViewController
        vc.dates = self.dates
        let navigationController = UINavigationController(rootViewController: vc)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

   func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return details.count
    }


     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTest", for: indexPath) as! DaysLeftTableViewCell
        let datas = details[indexPath.row]
        print(datas.comments)
        DispatchQueue.main.async {
            cell.nameLabel.text = datas.names
            cell.detailLabel.text = datas.comments
        }
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
//    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }


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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

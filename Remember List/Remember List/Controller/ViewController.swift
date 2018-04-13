//
//  ViewController.swift
//  Remember List
//
//  Created by Thobio on 09/04/18.
//  Copyright © 2018 STapps. All rights reserved.
//

import UIKit
import CoreData

var items:[Day] = []

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet weak var tabelViews: UITableView!
    var refreshControl: UIRefreshControl!
    // MARK: - View Did Load and Will Appear
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelViews.delegate = self
        tabelViews.dataSource = self
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action:#selector(refresh(sender:)), for: .valueChanged)
        tabelViews.addSubview(refreshControl)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getDate()
        tabelViews.reloadData()
    }
    @objc func refresh(sender:AnyObject) {
        tabelViews.reloadData()
        refreshControl?.endRefreshing()
    }
    
     // MARK: - Add Action Button
    
    @IBAction func AddActionButton(_ sender: Any) {
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        
        let alert = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        alert.view.addSubview(datePicker)
        
        let ok = UIAlertAction(title: "Save", style: .default) { (action) in
            self.saveTheDate(saveDate: datePicker.date)
            self.getDate()
            self.tabelViews.reloadData()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
        
    }
    
     // MARK: - Core Data Save Date
    
    func  saveTheDate(saveDate:Date){
        
        let day = Day(context: context!)
        day.dates = saveDate as NSDate
        appDelegate?.saveContext()
        self.tabelViews.reloadData()
    }

     // MARK: - Convert the Date to String
    
    func getDateCoreDate(getDate:Date)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let dateString = dateFormatter.string(from: getDate)
        return dateString
    }
    
     // MARK: - Getting the Data From coredata
    
    func getDate(){
        do
        {
            items = (try context?.fetch(Day.fetchRequest()))!
        }catch  {
            print("Fetch Failed")
        }
    }
    
     // MARK: - Table View Support
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dates = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DateListTableViewCell
        cell.dateTillAlert.text = getDateCoreDate(getDate:dates.dates! as Date)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 87.0
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
   
            let days = items[indexPath.row]
            context?.delete(days)
            appDelegate?.saveContext()
            let requests:NSFetchRequest<Detials> =  Detials.fetchRequest()
            requests.predicate = NSPredicate(format: "dates == %@", days)
            let requestdata = NSBatchDeleteRequest(fetchRequest: requests as! NSFetchRequest<NSFetchRequestResult>)
            do{
                try context?.execute(requestdata)
            }catch{
                fatalError("Failed to execute request: \(error)")
            }
            self.getDate()
            tableView.reloadData()
        }
        return [delete]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: "tabList") as! UITabBarController
        let navController = tabBarController.viewControllers![0] as! UINavigationController
        let vc = navController.topViewController as! ListTableViewController
        vc.dates = items[indexPath.row].dates!
        self.present(tabBarController, animated: true, completion: nil)
    }

}




//  



//
//  CheckedListTableViewController.swift
//  Remember List
//
//  Created by Thobio on 10/04/18.
//  Copyright © 2018 STapps. All rights reserved.
//

import UIKit
import CoreData
var checkedlist = [Detials]()
var refreshControl: UIRefreshControl!
class CheckedListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action:#selector(refresh(sender:)), for: .valueChanged)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getData()
        tableView.reloadData()
    }
    @objc func refresh(sender:AnyObject) {
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }

    func getData(){
        do
        {
            let requests:NSFetchRequest<Detials> =  Detials.fetchRequest()
            requests.predicate = NSPredicate(format: "dates == %@ AND isAdded ==%@",datesTo,true as CVarArg)
            checkedlist = (try context?.fetch(requests))!
        }catch  {
            let alert = UIAlertController(title: "Error,Try again!", message: "Sorry cant get date \(error.localizedDescription)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
            self.present(alert, animated: true, completion:nil)
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return checkedlist.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CheckedListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "checkedlist", for: indexPath) as! CheckedListTableViewCell
        let checked = checkedlist[indexPath.row]
        DispatchQueue.main.async {
            cell.nameLabel.text = checked.names
            cell.commentLabel.text = checked.comments
        }
        return cell
    }

}

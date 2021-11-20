//
//  SavedTableViewController.swift
//  NewsApiOrg
//
//  Created by Arkadijs Makarenko on 20/11/2021.
//

import UIKit
import CoreData
import SDWebImage

var itemsList = [Item]()
var managedObjectContext: NSManagedObjectContext?

class SavedTableViewController: UITableViewController {
    
  
    var firstLoad = true
    
    override func viewDidLoad() {
        tableView.reloadData()
        if firstLoad {
            firstLoad = false
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Items")
            do{
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let item = result as! Item
                    itemsList.append(item)
                }
            } catch {
                print("failed")
            }
        }
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemsList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedCell", for: indexPath) as! SavedTableViewCell
        let thisItem: Item!
        thisItem = itemsList[indexPath.row]
        cell.titleLabel.text = thisItem.newsTitle
        cell.contentLabel.text = thisItem.newsContent

        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    //Delete
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
        if editingStyle == .delete {
            
            let selectedItem = itemsList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            do {
                context.delete(selectedItem)
                try context.save()
                
            } catch {
                print("context save error")
            }
        }
    }
    

}

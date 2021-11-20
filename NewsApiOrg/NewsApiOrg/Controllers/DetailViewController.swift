//
//  DetailViewController.swift
//  NewsApiOrg
//
//  Created by Arkadijs Makarenko on 20/11/2021.
//

import UIKit
import SDWebImage
import CoreData

class DetailViewController: UIViewController {

    var managedObjectContext: NSManagedObjectContext?
    
    //var context: NSManagedObjectContext?
    
    var webUrlString = String()
    var titleString = String()
    var contentString = String()
    var newsImage = String()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = titleString
        contentTextView.text = contentString
        newsImageView.sd_setImage(with: URL(string: newsImage), placeholderImage: UIImage(named: "news.png"))
                                  
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Items", in: context)
        let newItem = Item(entity: entity!, insertInto: context)
        newItem.newsTitle = titleLabel.text!
        newItem.newsContent = contentTextView.text!
        
        do {
            try context.save()
            itemsList.append(newItem)
            print("Items list: ", itemsList)
           
        } catch {
            print("context save error")
        }
        basicAlert(title: "Save", message: "Saved")
        // navigationController?.popViewController(animated: true)

    }
    
    


    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        let destinationVC: WebViewController = segue.destination as! WebViewController
        
        destinationVC.urlString = webUrlString
        // Pass the selected object to the new view controller.
    }


}

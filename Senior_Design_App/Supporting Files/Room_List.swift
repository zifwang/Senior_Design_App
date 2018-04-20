//
//  Room_List.swift
//  Senior_Design_App
//
//  Created by Zifan Wang on 4/19/18.
//  Copyright © 2018 Zifan Wang. All rights reserved.
//

import UIKit
import CoreData

class Room_List: UITableViewController {
    
    var room = [NSManagedObject]()
    
    @IBAction func addName(_ sender: Any) {
        let alert = UIAlertController(title: "Add a New Room", message: "Enter Room Name", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action :UIAlertAction!) in
            let textField = alert.textFields![0] as UITextField
            //            self.names.append(textField.text!)
            
            //print("There are \(self.room.count) rooms")
            //print("The last room is at the position: \(self.room.count - 1).")
            
            self.saveName(text: textField.text!)
            
            let indexPath = IndexPath(row: self.room.count - 1, section: 0)
            //print("Inserting at position: \(indexPath)")
            self.tableView.insertRows(at: [indexPath], with: .automatic)
            //            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action: UIAlertAction) in
            
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        alert.addTextField { (textField: UITextField) in
            
        }
        
        present(alert, animated: true, completion: nil)

    }
    
    // Display the installation guide
    let pdf = "Installation Guide"
    @IBAction func To_Installation_Guide(_ sender: Any) {
        if let url = Bundle.main.url(forResource: pdf, withExtension: "pdf") {
            let webView = UIWebView(frame: self.view.frame)
            let urlRequest = URLRequest(url: url)
            webView.loadRequest(urlRequest as URLRequest)
            //self.view.addSubview(webView)
            let pdfVC = UIViewController()
            pdfVC.view.addSubview(webView)
            pdfVC.title = pdf
            self.navigationController?.pushViewController(pdfVC, animated: true)
        }
    }
    
    let cellIdentifier = "reuseIdentifier"
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedObectContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Room")

        do {
            let fetchedResults = try managedObectContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResults {
                room = results
                
                tableView.reloadData()
            }
            
        } catch  {
            fatalError("Fail To Get Data")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
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
        print("There are: \(room.count) rooms")
        return room.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        // Configure the cell...
        let r = room[indexPath.row]
        cell.textLabel?.text = r.value(forKey: "name") as? String
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            // TODO: Delete room
            // call data struct to save the new result
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context:NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            
            // Get position of selected item
            let pos = indexPath.row
            // Remove data from coreDataStack
            context.delete(self.room[indexPath.row])
            // Remove data from our room array
            self.room.remove(at: pos)
            do {
                try context.save()
                print("The Deleting position is: \(indexPath.row)")
                // Reload tableView
                tableView.reloadData()
                completion(true)
            } catch {
                print("Delete failed: \(error)")
                completion(false)
            }
        }
            
        action.image = #imageLiteral(resourceName: "trash")
        action.backgroundColor = .red
            
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    
    private func saveName(text: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedObectContext = appDelegate.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: "Room", in: managedObectContext)
        
        let r = NSManagedObject(entity: entity!, insertInto: managedObectContext)
        
        r.setValue(text, forKey: "name")
        
        do {
            try managedObectContext.save()
        } catch  {
            fatalError("Fail To Save Data")
        }
        
        room.append(r)
        print("\(room)")
    }
    
    // go to next panel which has room properties
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "show_room_properties", sender: tableView.cellForRow(at: indexPath))
    }
    
    
    
    
}

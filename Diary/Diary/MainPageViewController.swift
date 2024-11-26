//
//  MainPageViewController.swift
//  Diary
//
//  Created by Nithisha Sathishkumar on 9/4/24.

import UIKit
import CoreData
import SwipeCellKit

class MainPageViewController: UITableViewController {
    var entry = [Entry]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        loadEntry()
        tableView.rowHeight = 70
    }
    
    //MARK: - TableView DataSource Method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entry.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let list = entry[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "goToMind", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        
        cell.textLabel?.text = list.name
        return cell
    }
    
    //MARK: - alert method
    @IBAction func addEntries(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Today's Entry", message: "", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Entry name", style: .destructive){
            (action) in
            if let entryName = textField.text{
                let newEntry = Entry(context: self.context)
                newEntry.name = entryName
                
                self.entry.append(newEntry)
                self.saveEntry()
            }
        }
        
        action1.isEnabled = false  // Disable the action initially
        
        let action2 = UIAlertAction(title: "Back", style: .destructive){
            (action) in
            // Simply dismisses the alert, no further action needed
        }

        // Add a text field to the alert
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter Entry name"
            textField = alertTextField
                
            // Add a target to the text field to monitor changes
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: alertTextField, queue: OperationQueue.main) { (notification) in
                if let text = alertTextField.text, !text.isEmpty {
                    action1.isEnabled = true  // Enable the action if the text is not empty
                } else {
                    action1.isEnabled = false  // Keep the action disabled if the text is empty
                }
            }
        }
        
        alert.addAction(action1)
        alert.addAction(action2)
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: - Database
    func saveEntry(){
        do{
            try context.save()
        }catch{
            print("Error in saving the data \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadEntry(with request: NSFetchRequest<Entry> = Entry.fetchRequest()){
        do{
            entry = try context.fetch(request)
        }catch {
            print("Error in loading the data \(error)")
        }
    }
    
    //MARK: - Connect main page to other page
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToNewDay", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToNewDay" {
            let destinationVC = segue.destination as! NewDayViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedEntry = entry[indexPath.row]
            }
        }
    }
}

//MARK: - <#Section Heading#>
extension MainPageViewController: SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // Fetch the category to delete
            let categoryToDelete = self.entry[indexPath.row]
            
            // Delete the category from Core Data
            self.context.delete(categoryToDelete)
            
            // Remove it from the array
            self.entry.remove(at: indexPath.row)
            
            // Save the Core Data context
            do {
                try self.context.save()
            } catch {
                print("Error saving context after deletion: \(error)")
            }
            
            // Delete the row from the table view
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        // Customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
}



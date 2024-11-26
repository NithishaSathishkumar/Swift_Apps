//
//  NewDayViewController.swift
//  Diary
//
//  Created by Nithisha Sathishkumar on 9/4/24.
//

import UIKit
import CoreData

class NewDayViewController: UIViewController {
    
    @IBOutlet weak var thoughtPar: UITextView!
    
    var selectedEntry: Entry?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let entry = selectedEntry {
            loadPar(for: entry)
        }
    }
    
    @IBAction func pressedSaveButton(_ sender: UIBarButtonItem) {
        if let entry = selectedEntry {
            entry.paragraph = thoughtPar.text  // Save the text into the selected entry
                    
            savePar()
        }
    
        navigationController?.popViewController(animated: true)
    }
    
    func savePar(){
        do{
            try context.save()
        }catch{
            print("Error Paragraph not saved, \(error)")
        }
    }
    
    func loadPar(for entry: Entry){
        thoughtPar.text = entry.paragraph
    }
}

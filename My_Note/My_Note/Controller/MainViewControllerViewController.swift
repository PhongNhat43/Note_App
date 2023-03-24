//
//  ViewController.swift
//  123
//
//  Created by devsenior on 21/03/2023.
//

import UIKit
import CoreData

var items = [Notes]()
class MainViewController: UITableViewController {
    

    
    let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//   
//    }
    
   
    
//    func fetchData(){
//        do {
//            self.items = try context.fetch(Notes.fetchRequest())
//            DispatchQueue.main.async {
//                self.tableview.reloadData()
//            }
//
//        } catch {
//
//
//        }
//
//    }
//
//    @IBAction func ADD(_ sender: Any) {
//
//
//        let alert = UIAlertController(title: "++++", message: "Add your title", preferredStyle: .alert)
//        alert.addTextField()
//
//        let submitButton = UIAlertAction(title: "ADD", style: .default) { (action) in
//            // Get the textFields for the alert
//            let textfield = alert.textFields![0]
//
//            // TODO: Create a person object
//            let newTitle = Notes(context: self.context)
//            newTitle.title = textfield.text
//
//
//            // TODO: Save the data
//            do{
//                try self.context.save()
//            }catch{
//
//            }
//
//            // ToDo: Re Fetch the data
//            self.fetchData()
//
//        }
//
//        // add button
//        alert.addAction(submitButton)
//
//
//        // show alert
//        self.present(alert, animated: true, completion: nil)
//
//
//    }
    
    
    




    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UsersTableViewCell.identifier, for: indexPath) as! UsersTableViewCell
        let thisNote: Notes!
        thisNote = items[indexPath.row]
        cell.nameLbL.text = thisNote.title
        return cell
        
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
   
   
    
}

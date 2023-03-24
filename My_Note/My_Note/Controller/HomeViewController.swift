//
//  ViewController.swift
//  123
//
//  Created by devsenior on 21/03/2023.
//

import UIKit
import CoreData
class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var searcBarHome: UISearchBar!
    let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var items = [Notes]()
    
    var task: Notes?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        fetchNote()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchNote()
    }
    
    func setupTable(){
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    func fetchNote(){
        do {
            self.items =
             try context.fetch(Notes.fetchRequest())
          
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
            
        } catch {
        
        }
    }

}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UsersTableViewCell.identifier, for: indexPath) as! UsersTableViewCell
        let item = items[indexPath.row]
        cell.nameLbL.text = item.title
        cell.descLbl.text = item.desc
        cell.levelLbL.text = item.level
        cell.levelLbL.textColor = item.color
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: items[indexPath.row].createdAt!)
        cell.createAt.text = "Được tạo lúc : \(dateString)"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        task = items[indexPath.row]
        self.performSegue(withIdentifier: "editNote", sender: self)
    
//        let item = items[indexPath.row]
//        let sheet = UIAlertController(title: "Edit", message: nil, preferredStyle: .actionSheet)
//
//        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//
//        // edit
//        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { [weak self] _ in
//            let alert = UIAlertController(title: "New Item", message: "Enter something", preferredStyle: .alert)
//            alert.addTextField(configurationHandler: nil)
//            alert.addTextField(configurationHandler: nil)
//            alert.textFields?[0].text = item.title
//            alert.textFields?[1].text = item.desc
//
//            alert.addAction(UIAlertAction(title: "Save", style: .cancel, handler: {[weak self] _ in
//                guard let field = alert.textFields?[0], let newTitle = field.text, !newTitle.isEmpty,
//                      let field2 = alert.textFields?[1], let newDesc = field2.text, !newDesc.isEmpty
//                else {
//                  return
//                }
//                self?.updataData(item: item, newTitle: newTitle, newDesc: newDesc)
//        }))
//            self?.present(alert, animated: true)
//        }))
//
//        present(sheet, animated: true)
    }
   

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Create swpe action
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action,view, completionHanler) in
            
            // Which person to remove
            let deletePerson = self.items[indexPath.row]
            
            // remove the person
            self.context.delete(deletePerson)
            
            // save the data
            do{
                try self.context.save()
            }catch{
            
            }
            // re fetch
            self.fetchNote()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editNote" {
            let edits = segue.destination as! EditViewController
            edits.selectedNote = task
           
            
        }
    }
    
 

    
}

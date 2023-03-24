//
//  DetialViewController.swift
//  123
//
//  Created by devsenior on 21/03/2023.
//

import UIKit
import CoreData

class EditViewController: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var descTF: UITextField!
    
    @IBOutlet weak var pickViewEdit: UIPickerView!
    
    @IBOutlet weak var levelTF: UITextField!
    
    var selectedNote: Notes?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let levelArray = ["High", "Medium", "Low"]
    
    let colorArray = [UIColor.red, UIColor.orange, UIColor.green]
    
    var ref = 0
    
    // Data for the table
    var items = [Notes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(selectedNote != nil){
            nameTF.text = selectedNote?.title
            descTF.text = selectedNote?.desc
            levelTF.text = selectedNote?.level
            nameTF.becomeFirstResponder()
        }
        setupPickerView()

    }
    
    func setupPickerView(){
        pickViewEdit.delegate = self
        pickViewEdit.dataSource = self
    
    }
    
    func fetchData(){
        do {
            self.items = try context.fetch(Notes.fetchRequest())
            
        } catch {
        
        }
    }
    
    func updataData(item: Notes, newTitle: String, newDesc: String, newLevel: String, newColor: UIColor){
        item.title = newTitle
        item.desc = newDesc
        item.level = newLevel
        item.color = newColor
        
        do {
            try context.save()
            fetchData()
            
        }catch {
          
           }
        }
    
    @IBAction func saveBtn(_ sender: Any) {
        view.endEditing(true)
        guard let note = selectedNote ?? NSEntityDescription.insertNewObject(forEntityName: "Notes", into: context) as? Notes else {
                return
            }
            
        if let title = nameTF.text, let desc = descTF.text, let level = levelTF.text {
            let colorIndex = levelArray.firstIndex(of: level) ?? 0
            let newColor = colorArray[colorIndex]
            updataData(item: note, newTitle: title, newDesc: desc, newLevel: level, newColor: newColor
            
            )
            }
            
            // Pop EditViewController khỏi UINavigationController
            navigationController?.popViewController(animated: true)
        
//        newNote.createdAt = Date()
//
//           do {
//               try self.context.save()
//               self.navigationController?.popViewController(animated: true)
//
//           } catch {
//           }
//
        self.fetchData()
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
 

}

extension EditViewController:  UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        levelArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        levelTF.text = levelArray[row]
        levelTF.textColor = colorArray[row]
        ref = row
    }

    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attrb = NSAttributedString(string: levelArray[row], attributes: [NSAttributedString.Key.foregroundColor : colorArray[row]])
        return attrb
    }
}

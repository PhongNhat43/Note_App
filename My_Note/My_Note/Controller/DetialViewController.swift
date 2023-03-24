//
//  DetialViewController.swift
//  123
//
//  Created by devsenior on 21/03/2023.
//

import UIKit
import CoreData

class DetialViewController: UIViewController  {
    

    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var descTF: UITextField!
    
    @IBOutlet weak var pickViewDetial: UIPickerView!
    
    @IBOutlet weak var levelTF: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let levelArray = ["High", "Medium", "Low"]
    
    let colorArray = [UIColor.red, UIColor.orange, UIColor.green]
    
    var ref = 0
    
    // Data for the table
    var items = [Notes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickerView()

    }
    func setupPickerView(){
        pickViewDetial.delegate = self
        pickViewDetial.dataSource = self
    
    }
    
    func fetchData(){
        
        do {
            self.items = try context.fetch(Notes.fetchRequest())
            
        } catch {
        
        }
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        view.endEditing(true)
        if nameTF.text == ""{
          print("Enter your Title !!!!!")
            let alert = UIAlertController(title: "Error", message:"Enter your Title" , preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                // Xử lý khi người dùng chọn "OK"
            }
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            return
        }
        
        
        if descTF.text == ""{
          print("Enter your Description !!!!!")
            let alert = UIAlertController(title: "Error", message:"Enter your Description" , preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                // Xử lý khi người dùng chọn "OK"
            }
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            return
        }
        
        let newNote = Notes(context: self.context)
        newNote.title = nameTF.text
        newNote.desc = descTF.text
        newNote.level = levelTF.text
        newNote.color = colorArray[ref]
        newNote.createdAt = Date()
        
           
           do {
               try self.context.save()
               self.navigationController?.popViewController(animated: true)

                // Lấy dữ liệu từ Core Data về sau khi lưu thành công
           } catch {
               print(error) // In ra lỗi nếu có lỗi xảy ra khi lưu
           }
        
        self.fetchData()
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
 

}

extension DetialViewController:  UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        levelArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        levelTF.text = levelArray[row]
        ref = row
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attrb = NSAttributedString(string: levelArray[row], attributes: [NSAttributedString.Key.foregroundColor : colorArray[row]])
        return attrb
    }
}


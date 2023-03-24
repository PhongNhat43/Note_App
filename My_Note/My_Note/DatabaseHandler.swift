//
//  DatabaseHandler.swift
//  My_Note
//
//  Created by devsenior on 24/03/2023.
//

import Foundation
import UIKit
import CoreData

class DatabaseHandler {
    
    func saveData(Stitle: String){
        let appDe = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDe.persistentContainer.viewContext
        let titleObject = NSEntityDescription.insertNewObject(forEntityName: "Notes", into: context) as! Notes
        titleObject.title = Stitle
        do {
            try context.save()
        
        }catch {
        
            print("Error Occrued Fetching Data")
        }
    
    }
    
    func fetchSearchBarData(sText: String) -> [Notes] {
        var items = [Notes]()
        let appDe = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDe.persistentContainer.viewContext
        let predicate = NSPredicate(format: "title contains %@", sText)
        let request: NSFetchRequest = Notes.fetchRequest()
        request.predicate = predicate
        do {
            items = try (context.fetch(request))
        
        }catch {
            print("Error Fetching Data")
        }
        
        return items
    }


}

//
//  Notes+CoreDataProperties.swift
//  My_Note
//
//  Created by devsenior on 23/03/2023.
//
//

import Foundation
import CoreData
import UIKit


extension Notes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notes> {
        return NSFetchRequest<Notes>(entityName: "Notes")
    }

    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var level: String?
    @NSManaged public var color: UIColor
    @NSManaged public var order: Int16

}

extension Notes : Identifiable {

}

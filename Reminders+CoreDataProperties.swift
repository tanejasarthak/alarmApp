//
//  Reminders+CoreDataProperties.swift
//  OfflineStorage
//
//  Created by Sarthak Taneja on 22/10/21.
//
//

import Foundation
import CoreData


extension Reminders {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reminders> {
        return NSFetchRequest<Reminders>(entityName: "Reminders")
    }

    @NSManaged public var isCompleted: Bool
    @NSManaged public var title: String?
    @NSManaged public var date: Date?

}

extension Reminders : Identifiable {

}

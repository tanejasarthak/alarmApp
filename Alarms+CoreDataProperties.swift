//
//  Alarms+CoreDataProperties.swift
//  OfflineStorage
//
//  Created by Sarthak Taneja on 22/10/21.
//
//

import Foundation
import CoreData


extension Alarms {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Alarms> {
        return NSFetchRequest<Alarms>(entityName: "Alarms")
    }

    @NSManaged public var isActive: Bool
    @NSManaged public var time: Date?

}

extension Alarms : Identifiable {

}

//
//  Events+CoreDataProperties.swift
//  OfflineStorage
//
//  Created by Sarthak Taneja on 22/10/21.
//
//

import Foundation
import CoreData


extension Events {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Events> {
        return NSFetchRequest<Events>(entityName: "Events")
    }

    @NSManaged public var title: String?
    @NSManaged public var type: String?
    @NSManaged public var location: String?
    @NSManaged public var date: Date?

}

extension Events : Identifiable {

}

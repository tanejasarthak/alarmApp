//
//  EventsViewModel.swift
//  OfflineStorage
//
//  Created by Sarthak Taneja on 23/10/21.
//

import Foundation
import UIKit

protocol EventsViewModelDelegate {
    func reloadTableView()
}

class EventsViewModel {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var eventList = [Events]()
    var delegate: EventsViewModelDelegate?
    
    // MARK: - CoreData Operations
    func getAllEventsList() {
        do {
            eventList = try context.fetch(Events.fetchRequest())
        } catch {
            
        }
      //  sortEventList()
        delegate?.reloadTableView()
    }
    
    func deleteRecord(for record: Events?) {
        guard let record = record else {
            return
        }
        context.delete(record)
        do {
            try context.save()
            getAllEventsList()
        } catch {
            
        }
    }
    
    func addRecords(date: Date, title: String, location: String, type: String) {
        let item = Events(context: context)
        item.date = date
        item.title = title
        item.location = location
        item.type = type
        do {
            try context.save()
            getAllEventsList()
        } catch {
            
        }
    }
    
    func modifyRecord(record: Events?, time: Date, title: String, location: String, type: String) {
        guard let record = record else {
            return
        }
        record.date = time
        record.title = title
        record.location = location
        record.type = type
        do {
            try context.save()
            getAllEventsList()
        } catch {
            
        }
    }
    
//    func sortEventList() {
//        alarmList = alarmList.sorted { alarmOne, alarmTwo in
//            return alarmOne.time ?? Date() < alarmTwo.time ?? Date()
//        }
//    }
}


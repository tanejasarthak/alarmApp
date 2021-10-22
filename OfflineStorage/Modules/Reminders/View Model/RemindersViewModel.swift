//
//  RemindersViewModel.swift
//  OfflineStorage
//
//  Created by Sarthak Taneja on 22/10/21.
//

import Foundation
import UIKit

protocol RemindersViewModelDelegate {
    func reloadTableView()
}

class RemindersViewModel {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var remindersList = [Reminders]()
    var delegate: RemindersViewModelDelegate?
    
    
    // MARK: - CoreData Operations
    func getAllRemindersList() {
        do {
            remindersList = try context.fetch(Reminders.fetchRequest())
        } catch {
            
        }
        sortReminderList()
        delegate?.reloadTableView()
    }
    
    // Put Completed tasks at the end
    func sortReminderList() {
        remindersList = remindersList.sorted { reminderOne, reminderTwo in
            return reminderOne.isCompleted == false
        }
    }
    
    func deleteRecord(for record: Reminders?) {
        guard let record = record else {
            return
        }
        context.delete(record)
        do {
            try context.save()
            getAllRemindersList()
        } catch {
            
        }
    }
    
    func addRecords(date: Date?, title: String?) {
        guard let date = date else { return }
        let item = Reminders(context: context)
        item.date = date
        item.title = title
        item.isCompleted = false
        do {
            try context.save()
            getAllRemindersList()
        } catch {
            
        }
    }
    
    func modifyRecord(record: Reminders?, time: Date?, title: String?, isCompleted: Bool?) {
        guard let record = record else {
            return
        }
        if let time = time {
            record.date = time
        }
        if let isCompleted = isCompleted {
            record.isCompleted = isCompleted
        }
        if let title = title {
            record.title = title
        }
        do {
            try context.save()
            getAllRemindersList()
        } catch {
            
        }
    }
}


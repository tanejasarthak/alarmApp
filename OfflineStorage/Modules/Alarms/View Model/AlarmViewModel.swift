//
//  AlarmViewModel.swift
//  OfflineStorage
//
//  Created by Sarthak Taneja on 22/10/21.
//

import Foundation
import UIKit

protocol AlarmViewModelDelegate {
    func reloadTableView()
}

class AlarmViewModel {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var alarmList = [Alarms]()
    var delegate: AlarmViewModelDelegate?
    
    // MARK: - CoreData Operations
    func getAllAlarmsList() {
        do {
            alarmList = try context.fetch(Alarms.fetchRequest())
        } catch {
            
        }
        sortAlarmList()
        delegate?.reloadTableView()
    }
    
    func deleteRecord(for record: Alarms?) {
        guard let record = record else {
            return
        }
        context.delete(record)
        do {
            try context.save()
            getAllAlarmsList()
        } catch {
            
        }
    }
    
    func addRecords(date: Date?) {
        guard let date = date else { return }
        let item = Alarms(context: context)
        item.time = date
        item.isActive = true
        do {
            try context.save()
            getAllAlarmsList()
        } catch {
            
        }
    }
    
    func modifyRecord(record: Alarms, isAlarmActive: Bool) {
        record.isActive = isAlarmActive
        do {
            try context.save()
            getAllAlarmsList()
        } catch {
            
        }
    }
    
    func changeRecord(record: Alarms?, time: Date?) {
        guard let time = time, let record = record else {
            return
        }
        record.time = time
        do {
            try context.save()
            getAllAlarmsList()
        } catch {
            
        }
    }
    
    func sortAlarmList() {
        alarmList = alarmList.sorted { alarmOne, alarmTwo in
            return alarmOne.time ?? Date() < alarmTwo.time ?? Date()
        }
    }
}

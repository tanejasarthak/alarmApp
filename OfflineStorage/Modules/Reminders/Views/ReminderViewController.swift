//
//  ReminderViewController.swift
//  OfflineStorage
//
//  Created by Sarthak Taneja on 21/10/21.
//

import UIKit

class ReminderViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noReminderLabel: UILabel!
    
    // Public Properties
    var viewModel = RemindersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureTableView()
        viewModel.delegate = self
        viewModel.getAllRemindersList()
    }
    
    func configureTableView() {
        tableView.register(UINib(nibName: "ReminderTableViewCell", bundle: nil), forCellReuseIdentifier: "ReminderTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func addReminderTap() {
        pushToAddModifyView(for: .add, at: nil)
    }
    
    func pushToAddModifyView(for type: AddAlarmScreenStatus, at index: Int?) {
        let addAlarmVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddAlarmViewController") as! AddAlarmViewController
        addAlarmVC.screenType = .reminders
        addAlarmVC.screenStatus = type
        if let index = index {
            addAlarmVC.reminderRecord = viewModel.remindersList[index]
        }
        addAlarmVC.delegate = self
        self.present(addAlarmVC, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate and UITableViewDatasource
extension ReminderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.remindersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderTableViewCell", for: indexPath) as! ReminderTableViewCell
        cell.configureView(reminders: viewModel.remindersList[indexPath.row])
        cell.delegate = self
        cell.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushToAddModifyView(for: .modify, at: indexPath.row)
    }
}

// MARK: - AddRecords Delegate
extension ReminderViewController: AddRecordsDelegate {
    func deleteRecord<T>(for record: T?) {
        if let record = record as? Reminders {
            viewModel.deleteRecord(for: record)
        }
    }
    
    func addModifyRecords<T>(date: Date?, title: String?, eventType: String?, eventLocation: String?, isAdd: Bool, for record: T?) {
        if isAdd {
            viewModel.addRecords(date: date, title: title)
        } else {
            if let record = record as? Reminders {
                viewModel.modifyRecord(record: record, time: date, title: title ?? "", isCompleted: false)
            }
        }
    }
}

// MARK: - ReminderTableViewCell Delegate
extension ReminderViewController: ReminderTableViewCellDelegate {
    func markAsDoneTapped(tag: Int) {
        viewModel.modifyRecord(record: viewModel.remindersList[tag], time: nil, title: nil, isCompleted: true)
    }
}

// MARK: - ReminderViewModel Delegate
extension ReminderViewController: RemindersViewModelDelegate {
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

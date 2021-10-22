//
//  EventsViewController.swift
//  OfflineStorage
//
//  Created by Sarthak Taneja on 21/10/21.
//

import UIKit

class EventsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noEventLabel: UILabel!
    
    // Public Properties
    var eventList = [Events]()
    var viewModel = EventsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureTableView()
        viewModel.getAllEventsList()
        viewModel.delegate = self
    }
    
    func configureTableView() {
        tableView.register(UINib(nibName: "EventsTableViewCell", bundle: nil), forCellReuseIdentifier: "EventsTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func addEventTap() {
        pushToAddUpdateScreen(for: .add, with: nil)
    }
    
    func pushToAddUpdateScreen(for type: AddAlarmScreenStatus, with index: Int?) {
        let addAlarmVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddAlarmViewController") as! AddAlarmViewController
        addAlarmVC.screenType = .events
        addAlarmVC.screenStatus = type
        if let index = index {
            addAlarmVC.eventRecord = viewModel.eventList[index]
        }
        addAlarmVC.delegate = self
        self.present(addAlarmVC, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate and UITableViewDatasource
extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        noEventLabel.isHidden = !(viewModel.eventList.count == 0)
        return viewModel.eventList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventsTableViewCell", for: indexPath) as! EventsTableViewCell
        cell.configureView(record: viewModel.eventList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushToAddUpdateScreen(for: .modify, with: indexPath.row)
    }
}

// MARK: - AddRecords Delegate
extension EventsViewController: AddRecordsDelegate {
    func addModifyRecords<T>(date: Date?, title: String?, eventType: String?, eventLocation: String?, isAdd: Bool, for record: T?) {
        if isAdd {
            viewModel.addRecords(date: date ?? Date(), title: title ?? "", location: eventLocation ?? "", type: eventType ?? "")
        } else {
            if let record = record as? Events {
                viewModel.modifyRecord(record: record, time: date ?? Date(), title: title ?? "", location: eventLocation ?? "", type: eventType ?? "")
            }
        }
    }
    
    func deleteRecord<T>(for record: T?) {
        if let record = record as? Events {
            viewModel.deleteRecord(for: record)
        }
    }
}

// MARK: - EventsViewModel Delegate
extension EventsViewController: EventsViewModelDelegate {
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

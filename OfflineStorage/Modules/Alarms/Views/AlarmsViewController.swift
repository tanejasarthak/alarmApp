//
//  AlarmsViewController.swift
//  OfflineStorage
//
//  Created by Sarthak Taneja on 21/10/21.
//

import UIKit

class AlarmsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noAlarmFoundLabel: UILabel!
    
    // Public Properties
    var viewModel = AlarmViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureTableView()
        viewModel.delegate = self
        viewModel.getAllAlarmsList()
    }

    func configureTableView() {
        tableView.register(UINib(nibName: "AlarmTableViewCell", bundle: nil), forCellReuseIdentifier: "AlarmTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func addAlarmTap() {
        pushToAddRecordsScreen(for: .add, at: nil)
    }
    
    func pushToAddRecordsScreen(for type: AddAlarmScreenStatus, at row: Int?) {
        let addAlarmVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddAlarmViewController") as! AddAlarmViewController
        addAlarmVC.screenType = .alarms
        addAlarmVC.screenStatus = type
        if let row = row {
            addAlarmVC.record = viewModel.alarmList[row]
        }
        addAlarmVC.delegate = self
        self.present(addAlarmVC, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate and UITableViewDatasource
extension AlarmsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        noAlarmFoundLabel.isHidden = !(viewModel.alarmList.count == 0)
        return viewModel.alarmList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmTableViewCell", for: indexPath) as! AlarmTableViewCell
        cell.configureView(alarmDetails: viewModel.alarmList[indexPath.row])
        cell.tag = indexPath.row
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushToAddRecordsScreen(for: .modify, at: indexPath.row)
    }
}

// MARK: - AddRecords Delegate
extension AlarmsViewController: AddRecordsDelegate {
    func addModifyRecords<T>(date: Date?, title: String?, eventType: String?, eventLocation: String?, isAdd: Bool, for record: T?) {
        if isAdd {
            viewModel.addRecords(date: date)
        } else {
            if let record = record as? Alarms {
                viewModel.changeRecord(record: record, time: date)
            }
        }
    }
    
    func deleteRecord<T>(for record: T?) {
        if let record = record as? Alarms {
            viewModel.deleteRecord(for: record)
        }
    }
}

// MARK: - AlarmTableView Delegate
extension AlarmsViewController: AlarmTableViewDelegate {
    func alarmSwitchAction(isAlarmActive: Bool, at row: Int) {
        viewModel.modifyRecord(record: viewModel.alarmList[row], isAlarmActive: isAlarmActive)
    }
}

// MARK: - AlarmViewModel
extension AlarmsViewController: AlarmViewModelDelegate {
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

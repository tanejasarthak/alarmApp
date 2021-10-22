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
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var alarmList = [Alarms]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureTableView()
        getAllAlarmsList()
    }

    func configureTableView() {
        tableView.register(UINib(nibName: "AlarmTableViewCell", bundle: nil), forCellReuseIdentifier: "AlarmTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func getAllAlarmsList() {
        do {
            alarmList = try context.fetch(Alarms.fetchRequest())
        } catch {
            
        }
        sortAlarmList()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func sortAlarmList() {
        alarmList = alarmList.sorted { alarmOne, alarmTwo in
            return alarmOne.time ?? Date() < alarmTwo.time ?? Date()
        }
    }
    
    @IBAction func addAlarmTap() {
        let addAlarmVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddAlarmViewController") as! AddAlarmViewController
        addAlarmVC.screenType = .alarms
        addAlarmVC.delegate = self
        self.present(addAlarmVC, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate and UITableViewDatasource
extension AlarmsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmTableViewCell", for: indexPath) as! AlarmTableViewCell
        cell.configureView(alarmTime: alarmList[indexPath.row].time, isAlarmActive: alarmList[indexPath.row].isActive)
        cell.tag = indexPath.row
        cell.delegate = self
        return cell
    }
}

// MARK: - AddRecords Delegate
extension AlarmsViewController: AddRecordsDelegate {
    func addRecords(date: Date?, title: String?, eventType: String?, eventLocation: String?) {
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
}

// MARK: - AlarmTableView Delegate
extension AlarmsViewController: AlarmTableViewDelegate {
    func alarmSwitchAction(isAlarmActive: Bool, at row: Int) {
        alarmList[row].isActive = isAlarmActive
        do {
            try context.save()
            getAllAlarmsList()
        } catch {
            
        }
    }
}

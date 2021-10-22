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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func configureTableView() {
        tableView.register(UINib(nibName: "ReminderTableViewCell", bundle: nil), forCellReuseIdentifier: "ReminderTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func addReminderTap() {
        let addAlarmVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddAlarmViewController") as! AddAlarmViewController
        addAlarmVC.screenType = .reminders
        self.present(addAlarmVC, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate and UITableViewDatasource
extension ReminderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderTableViewCell", for: indexPath) as! ReminderTableViewCell
        return cell
    }
}

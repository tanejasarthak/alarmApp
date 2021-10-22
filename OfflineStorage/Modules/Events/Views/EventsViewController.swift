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
        tableView.register(UINib(nibName: "EventsTableViewCell", bundle: nil), forCellReuseIdentifier: "EventsTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func addEventTap() {
        let addAlarmVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddAlarmViewController") as! AddAlarmViewController
        addAlarmVC.screenType = .events
        self.present(addAlarmVC, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate and UITableViewDatasource
extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventsTableViewCell", for: indexPath) as! EventsTableViewCell
        return cell
    }
}

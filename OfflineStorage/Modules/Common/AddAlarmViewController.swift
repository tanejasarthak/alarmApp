//
//  AddAlarmViewController.swift
//  OfflineStorage
//
//  Created by Sarthak Taneja on 21/10/21.
//

import UIKit

protocol AddRecordsDelegate {
    func addRecords(date: Date?, title: String?, eventType: String?, eventLocation: String?)
    func deleteRecord(for record: Alarms?)
}

class AddAlarmViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var reminderEventTitle: UITextField!
    @IBOutlet weak var eventType: UITextField!
    @IBOutlet weak var eventLocation: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var deleteRecordButton: UIButton!
    @IBOutlet weak var backgrounView: UIView!
    
    var screenType: ScreenType?
    var screenStatus: AddAlarmScreenStatus = .add
    var record: Alarms?
    var delegate: AddRecordsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        datePicker.preferredDatePickerStyle = .wheels
        setupView()
        setupBackgroundView()
    }
    
    func setupView() {
        guard let screenType = screenType else {
            return
        }
        if screenType == .events {
            eventType.isHidden = false
            eventLocation.isHidden = false
            reminderEventTitle.isHidden = false
            reminderEventTitle.placeholder = "Event Title"
        } else if screenType == .reminders {
            reminderEventTitle.isHidden = false
        } else {
            datePicker.datePickerMode = .time
        }
        deleteRecordButton.isHidden = screenStatus != .modify
    }
    
    func setupBackgroundView() {
        backgrounView.layer.borderColor = UIColor.gray.cgColor
        backgrounView.layer.borderWidth = 1
        backgrounView.layer.cornerRadius = 4
    }
    
    @IBAction func addAlarmTapped() {
        delegate?.addRecords(date: datePicker.date, title: reminderEventTitle.text, eventType: eventType.text, eventLocation: eventLocation.text)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteButtonTap() {
        delegate?.deleteRecord(for: record)
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITextFieldsDelegate
extension AddAlarmViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
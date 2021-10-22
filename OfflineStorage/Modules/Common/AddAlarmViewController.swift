//
//  AddAlarmViewController.swift
//  OfflineStorage
//
//  Created by Sarthak Taneja on 21/10/21.
//

import UIKit

protocol AddRecordsDelegate {
    func addModifyRecords<T>(date: Date?, title: String?, eventType: String?, eventLocation: String?, isAdd: Bool, for record: T?)
    func deleteRecord<T>(for record: T?)
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
    var eventRecord: Events?
    var reminderRecord: Reminders?
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
            if screenStatus == .modify {
                prefillViewForEvents()
            }
        } else if screenType == .reminders {
            reminderEventTitle.isHidden = false
            
            if screenStatus == .modify {
                reminderEventTitle.text = reminderRecord?.title
            }
        } else {
            datePicker.datePickerMode = .time
        }
        deleteRecordButton.isHidden = screenStatus != .modify
        addButton.setTitle(screenStatus == .modify ? "Modify" : "Add", for: .normal)
    }
    
    func prefillViewForEvents() {
        reminderEventTitle.text = eventRecord?.title
        eventType.text = eventRecord?.type
        eventLocation.text = eventRecord?.location
    }
    
    func setupBackgroundView() {
        backgrounView.layer.borderColor = UIColor.gray.cgColor
        backgrounView.layer.borderWidth = 1
        backgrounView.layer.cornerRadius = 4
    }
    
    @IBAction func addAlarmTapped() {
        if screenStatus == .modify {
            if screenType == .events {
                delegate?.addModifyRecords(date: datePicker.date, title: reminderEventTitle.text, eventType: eventType.text, eventLocation: eventLocation.text, isAdd: false, for: eventRecord)
            } else if screenType == .reminders {
                delegate?.addModifyRecords(date: datePicker.date, title: reminderEventTitle.text, eventType: eventType.text, eventLocation: eventLocation.text, isAdd: false, for: reminderRecord)
            } else {
                delegate?.addModifyRecords(date: datePicker.date, title: reminderEventTitle.text, eventType: eventType.text, eventLocation: eventLocation.text, isAdd: false, for: record)
            }
            self.dismiss(animated: true, completion: nil)
            return
        }
        delegate?.addModifyRecords(date: datePicker.date, title: reminderEventTitle.text, eventType: eventType.text, eventLocation: eventLocation.text, isAdd: true, for: eventRecord)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteButtonTap() {
        if screenType == .events {
            delegate?.deleteRecord(for: eventRecord)
        } else if screenType == .reminders {
            delegate?.deleteRecord(for: reminderRecord)
        } else {
            delegate?.deleteRecord(for: record)
        }
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

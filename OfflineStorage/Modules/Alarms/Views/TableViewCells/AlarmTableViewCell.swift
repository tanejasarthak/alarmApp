//
//  AlarmTableViewCell.swift
//  OfflineStorage
//
//  Created by Sarthak Taneja on 21/10/21.
//

import UIKit

protocol AlarmTableViewDelegate {
    func alarmSwitchAction(isAlarmActive: Bool, at row: Int)
}

class AlarmTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var alarmLabel: UILabel!
    @IBOutlet weak var alarmOnOffSwitch: UISwitch!
    
    // Public Properties
    var delegate: AlarmTableViewDelegate?
    let dateFormatter = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureView(alarmTime: Date?, isAlarmActive: Bool) {
       // dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        if let alarmTime = alarmTime {
            alarmLabel.text = dateFormatter.string(from: alarmTime)
            alarmOnOffSwitch.isOn = isAlarmActive
        }
    }
    
    @IBAction func switchChangedAction(_ sender: Any) {
        delegate?.alarmSwitchAction(isAlarmActive: alarmOnOffSwitch.isOn, at: tag)
    }
}

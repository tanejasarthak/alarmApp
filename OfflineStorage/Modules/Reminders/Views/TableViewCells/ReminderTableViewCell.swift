//
//  ReminderTableViewCell.swift
//  OfflineStorage
//
//  Created by Sarthak Taneja on 21/10/21.
//

import UIKit

class ReminderTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var reminderTitleLabel: UILabel!
    @IBOutlet weak var reminderDueDateLabel: UILabel!
    @IBOutlet weak var markAsDoneBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureView(reminderTitle: String, reminderDueDate: String, isDone: Bool) {
        reminderTitleLabel.text = reminderTitle
        reminderDueDateLabel.text = reminderDueDate
    }
    
    @IBAction func markAsDoneTap(_ sender: Any) {
    }
    
}

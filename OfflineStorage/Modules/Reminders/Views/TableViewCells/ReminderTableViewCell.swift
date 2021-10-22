//
//  ReminderTableViewCell.swift
//  OfflineStorage
//
//  Created by Sarthak Taneja on 21/10/21.
//

import UIKit

protocol ReminderTableViewCellDelegate {
    func markAsDoneTapped(tag: Int)
}

class ReminderTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var reminderTitleLabel: UILabel!
    @IBOutlet weak var reminderDueDateLabel: UILabel!
    @IBOutlet weak var markAsDoneBtn: UIButton!
    
    // Public Properties
    let dateFormatter = DateFormatter()
    var delegate: ReminderTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureView(reminders: Reminders?) {
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        reminderTitleLabel.text = reminders?.title
        reminderDueDateLabel.text = dateFormatter.string(from: reminders?.date ?? Date())
        markAsDoneBtn.isEnabled = !(reminders?.isCompleted ?? false)
        markAsDoneBtn.setTitle("Mark as Done", for: .normal)
        markAsDoneBtn.setTitle("Completed", for: .disabled)
    }
    
    @IBAction func markAsDoneTap(_ sender: Any) {
        delegate?.markAsDoneTapped(tag: tag)
    }
    
}

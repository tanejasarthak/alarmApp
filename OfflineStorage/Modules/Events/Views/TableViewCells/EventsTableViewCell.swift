//
//  EventsTableViewCell.swift
//  OfflineStorage
//
//  Created by Sarthak Taneja on 21/10/21.
//

import UIKit

class EventsTableViewCell: UITableViewCell {

    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventTypeLabel: UILabel!
    @IBOutlet weak var eventLoctionLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    // Public Properties
    let dateFormatter = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureView(record: Events) {
        eventTitleLabel.text = record.title
        eventTypeLabel.text = record.type
        eventLoctionLabel.text = record.location
        
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        if let date = record.date {
            dateTimeLabel.text = dateFormatter.string(from: date)
        }
    }
}

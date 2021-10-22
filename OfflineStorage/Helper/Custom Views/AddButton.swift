//
//  AddButton.swift
//  OfflineStorage
//
//  Created by Sarthak Taneja on 21/10/21.
//

import UIKit

@IBDesignable
class AddButton: UIButton {
    
    func setButton() {
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.gray.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setButton()
    }
}

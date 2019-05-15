//
//  NoteCell.swift
//  EvoTest
//
//  Created by Anton Honcharenko on 5/14/19.
//  Copyright © 2019 Anton Honcharenko. All rights reserved.
//

import UIKit
import Foundation

class NoteCell : UITableViewCell {
    
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    func setup(model: NoteModel) {
        noteLabel.text = model.text
        if model.text.count > 100 {
            noteLabel.text = String(model.text.dropLast(model.text.count - 100))
        }
        
        let df = DateFormatter()
        df.timeStyle = .short
        timeLabel.text = df.string(from: model.date)
        df.timeStyle = .none
        df.dateStyle = .short
        dataLabel.text = df.string(from: model.date)
    }
    
    
}

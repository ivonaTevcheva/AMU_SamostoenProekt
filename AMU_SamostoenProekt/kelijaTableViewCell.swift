//
//  kelijaTableViewCell.swift
//  AMU_SamostoenProekt
//
//  Created by Ivona on 9/20/23.
//  Copyright © 2023 Ivona. All rights reserved.
//

import UIKit

class kelijaTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!

    func configure(with run: Run) {
        timeLabel.text = "\(run.time) mins"
        distanceLabel.text = "\(run.kilometers) km"
        caloriesLabel.text = "\(run.caloriesBurned) kcal"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  DoodTableViewCell.swift
//  TheApp
//
//  Created by Michael Wood on 7/11/17.
//  Copyright © 2017 Michael Wood. All rights reserved.
//

import UIKit

class DoodTableViewCell: UITableViewCell {
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var expLabel: UILabel!
    @IBOutlet weak var doodImageView: UIImageView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var alreadyRunning: Bool = false
    // var currentTick: Int = 0
    
    var limit: Int = 0
    var denominator: Float = 0.0
    var counter: Int = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)

        // Configure the view for the selected state
    }

}

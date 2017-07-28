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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)

        // Configure the view for the selected state
    }

}

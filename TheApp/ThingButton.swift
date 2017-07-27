//
//  ThingButton.swift
//  TheApp
//
//  Created by Michael Wood on 7/12/17.
//  Copyright © 2017 Michael Wood. All rights reserved.
//

import UIKit

class ThingButton: UIBarButtonItem {
    override init() {
        super.init()
        NSLog("button initted")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.title = "2/3"
    }
    
    

}

//
//  ViewController.swift
//  TheApp
//
//  Created by Michael Wood on 7/11/17.
//  Copyright © 2017 Michael Wood. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var sendButton: UIButton!

    var dood: Dood?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let dood = dood {
            detailNameLabel.text = dood.name
            detailImageView.image = dood.image
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func sendDood(_ sender: UIButton) {
        sender.isEnabled = false
        if let dood = dood {
            print("sending \(dood.name) to his doom")
            TheSocket.sharedInstance.dispatchDood(dood: dood)
        }
    }
}

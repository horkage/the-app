//
//  TableViewController.swift
//  TheApp
//
//  Created by Michael Wood on 7/11/17.
//  Copyright © 2017 Michael Wood. All rights reserved.
//

import UIKit
import os.log

class TableViewController: UITableViewController {
    
    
    static let sharedTableViewController = TableViewController()
    
    var localDoods = [Dood?]() {
        willSet(newList) {
            print("will set")
            //self.tableView.reloadData()
        }
        didSet {
            print("Did set")
            //self.tableView.reloadData()
        }
    }
    /*
    let socket = SocketIOClient(
        socketURL: URL(string: "http://192.168.0.112:9000")!,
        config: [
            .log(false),
            .forceWebsockets(true),
            .forcePolling(false),
            .secure(false),
            .path("/socket.io/"),
            .compress,
            .forceNew(true)
        ])
    */
    

    
    func getInstance() -> UITableViewController {
        return self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        for (index, dood) in localDoods.enumerated() {
            if (dood?.doodid == ViewController.stashGuy?.doodid) {
                localDoods[index] = dood
            }
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.global(qos: .background).async {
            TheSocket.sharedInstance.establishConnection(theController: self)
        }
        
        
        /*
        socket.connect()
        socket.on("acknowledgeConnection") {data, ack in
            print("connection acknowledged")
            self.socket.emit("init", "12345")
        }
        
        socket.on("serverSendsDoodList") {data, ack in
            print("The server responded with a list of doods for this client")
            
            // the raw socket data
            let jsonRawString = data[0]
            
            // convert the raw socket data to string
            let jsonString: String = (jsonRawString as? String)!
            
            // encode the string so it can be parsed
            let json = jsonString.data(using: String.Encoding.utf8, allowLossyConversion: false)
            if let temp = json {
                // "parse" the json into a swift "object" thingy
                let jsonObject = try? JSONSerialization.jsonObject(with: temp, options: JSONSerialization.ReadingOptions())
                
                // turn that object "thingy" into a proper swift array
                if let jsonEntry = jsonObject as? [[String: Any]] {
                    for dood in jsonEntry {
                        // JESUS FUCK FINALLY
                        let name = dood["name"] as! String
                        let level = dood["level"] as! Int
                        let rarity = dood["rarity"] as! Int
                        let type = dood["type"] as! String
                        let status = dood["status"] as! String
                        let doodid = dood["doodid"] as! Int
                        let experience: Int = dood["experience"] as! Int
                        let image: String?
                        image = dood["image"] as? String
                        
                        // don't instantiate image objects from nil urls
                        if (image != nil) {
                            // if image..
                            let url = URL(string: image!)
                            let imageData = try? Data(contentsOf: url!)
                            
                            if let imageData = imageData {
                                // instantiate Dood if we made it this far
                                let guy = Dood(doodid: doodid, theOwner: "12345", level: level, name: name, image: UIImage(data: imageData)!, rarity: rarity, type: type, status: status, experience: experience)
                                
                                //Dood.doods += [guy]
                                //TableViewController.sharedTableViewController.localDoods += [guy]
                                print("appending guy")
                                self.localDoods.append(guy)
                            }
                        } else {
                            // if no image..
                        }
                    }
                }
            }
            self.tableView.reloadData()
        }
        */
        

        
        



        /*
        if (localDoods.count == 0) {
            let img1 = UIImage(named: "cucumber")
            let img2 = UIImage(named: "goldman")
            let img3 = UIImage(named: "slime")
            let guy1 = Dood(doodid: 1, theOwner: "12345", level: 1, name: "cucumber", image: img1!, rarity: 0, type: "fighter", status: "idle", experience: 0)
            let guy2 = Dood(doodid: 1, theOwner: "12345", level: 1, name: "goldman", image: img2!, rarity: 0, type: "fighter", status: "idle", experience: 0)
            let guy3 = Dood(doodid: 1, theOwner: "12345", level: 1, name: "slime", image: img3!, rarity: 0, type: "fighter", status: "idle", experience: 0)
            localDoods += [guy1, guy2, guy3]
        } else {
            DispatchQueue.main.async(execute: {() -> Void in
                self.tableView.reloadData()

            })
        }
        */
        

        
        

        


        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSections thinks we have \(localDoods.count) doods")
        return localDoods.count

        //print("numberOfRowsInSections thinks we have \(localDoods.count) doods")
        //return localDoods.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "DoodTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DoodTableViewCell else {
            fatalError("table cell blew up yo.")
        }
        //let dood = localDoods[indexPath.row]
        let dood = localDoods[indexPath.row]
        cell.nameLabel.text = dood?.name
        
        let experience: Int = (dood?.experience)!
        let level: Int = (dood?.level)!
        
        cell.expLabel.text = "\(experience)"
        cell.levelLabel.text = "\(level)"
        cell.doodImageView.image = dood?.image

        
        let status: String = (dood?.status)!

        print(status)
        switch status {
        case "dead":
            cell.backgroundColor = UIColor.red
        case "complete":
            cell.backgroundColor = UIColor.green
        case "dispatched":
            cell.backgroundColor = UIColor.gray
        default:
            cell.backgroundColor = UIColor.white
        }
        /*
         if status=="dead" {
         cell.backgroundColor = UIColor.red
         } else if status=="complete" {
         cell.backgroundColor = UIColor.green
         } else if status=="dispatched" {
         cell.backgroundColor = UIColor.gray
         } else {
         cell.backgroundColor = UIColor.white
         }
         */
        
        // Configure the cell...
 
        return cell
 
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
        case "ShowDetail":
            os_log("Showing Detail", log: OSLog.default, type: .debug)
            guard let detailViewController = segue.destination as? ViewController else {
                fatalError("Unexpected segue destination: \(String(describing: segue.identifier))")
            }
            
            guard let selectedDoodCell = sender as? DoodTableViewCell else {
                fatalError("Unexpected segue sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedDoodCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            //let selectedDood = localDoods[indexPath.row]
            let selectedDood = localDoods[indexPath.row]
            detailViewController.dood = selectedDood
        default:
            fatalError("Unexpected seque identifier: \(String(describing: segue.identifier))")
        }
    }
}

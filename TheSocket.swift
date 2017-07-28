//
//  TheSocket.swift
//  TheApp
//
//  Created by Michael Wood on 7/12/17.
//  Copyright © 2017 Michael Wood. All rights reserved.
//


import UIKit

class TheSocket: NSObject {

    static let sharedInstance = TheSocket()
    static var pending: Int = 0
    static var total: Int = 0
    //static var stupidController = TableViewController()
    
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
    
    override init() {
        super.init()
    }


    func establishConnection(theController: TableViewController) {
        socket.connect()
        socket.on("acknowledgeConnection") {data, ack in
            print("connection acknowledged")
            self.socket.emit("init", (UIDevice.current.identifierForVendor?.uuidString)!)
        }
        
        // create Dood objects from socket data for this client
        socket.on("serverSendsDoodList") {data, ack in
            print("The server responded with a list of doods for this client")
            
            theController.localDoods = [Dood?]()
            
            var pendingDoods: Int = 0
            
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
                    // oh, look, an array we can finally iterate over
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
                        
                        if status == "complete" {
                            pendingDoods += 1
                        }
                        
                        // don't instantiate image objects from nil urls
                        if (image != nil) {
                            // if image..
                            let url = URL(string: image!)
                            let imageData = try? Data(contentsOf: url!)
                         
                            if let imageData = imageData {
                                // instantiate Dood if we made it this far
                                let guy = Dood(doodid: doodid, theOwner: (UIDevice.current.identifierForVendor?.uuidString)!, level: level, name: name, image: UIImage(data: imageData)!, rarity: rarity, type: type, status: status, experience: experience)
                                
                                //Dood.doods += [guy]
                                //TableViewController.sharedTableViewController.localDoods += [guy]
                                //print("appending guy")
                                //TableViewController.sharedTableViewController.localDoods.append(guy)
                                theController.localDoods.append(guy)
                                
                                
                            }
                        } else {
                            // if no image..
                        }
                    }
                }
            }
            //TableViewController.dumpDoods(doods: Dood.doods, controller: TableViewController.sharedTableViewController.getInstance() as! TableViewController)
            //TableViewController.sharedTableViewController.getInstance().tableView.reloadData()
            DispatchQueue.main.async {
                TheSocket.pending = pendingDoods
                TheSocket.total = theController.localDoods.count
                
                theController.tableView.reloadData()
                /*
                 UIApplication.shared.windows[0].rootViewController?.navigationController?.navigationBar.items?[0].rightBarButtonItem?.title = "WAT"
                 */
                // print(theController)
                theController.navigationController?.navigationBar.items?[0].rightBarButtonItem?.title = "\(TheSocket.pending)/\(TheSocket.total)"
            }
        }
        
        socket.on("dispatchComplete") { data, ack in
            print("guy came back")
            
            TheSocket.pending += 1
            
            // the raw socket data
            let jsonRawString = data[0]
            
            // convert the raw socket data to string
            let jsonString: String = (jsonRawString as? String)!
            
            // encode the string so it can be parsed
            let json = jsonString.data(using: String.Encoding.utf8, allowLossyConversion: false)
            if let temp = json {
                // "parse" the json into a swift "object" thingy
                let jsonObject = try? JSONSerialization.jsonObject(with: temp, options: JSONSerialization.ReadingOptions())
                if let jsonEntry = jsonObject as? [String: Any] {
                    let name = jsonEntry["name"] as! String
                
                    let level = jsonEntry["level"] as! Int
                    let rarity = jsonEntry["rarity"] as! Int
                    let type = jsonEntry["type"] as! String
                    let status = jsonEntry["status"] as! String
                    let doodid = jsonEntry["doodid"] as! Int
                    let experience: Int = jsonEntry["experience"] as! Int
                    let image: String?
                    image = jsonEntry["image"] as? String
                    
                    if (image != nil) {
                        // if image..
                        let url = URL(string: image!)
                        let imageData = try? Data(contentsOf: url!)
                        
                        if let imageData = imageData {
                            // instantiate Dood if we made it this far
                            let guy = Dood(doodid: doodid, theOwner: (UIDevice.current.identifierForVendor?.uuidString)!, level: level, name: name, image: UIImage(data: imageData)!, rarity: rarity, type: type, status: status, experience: experience)
                            
                            //Dood.doods += [guy]
                            //TableViewController.sharedTableViewController.localDoods += [guy]
                            //print("appending guy")
                            //TableViewController.sharedTableViewController.localDoods.append(guy)
                            /*
                            theController.localDoods.forEach { dood in
                                if (dood?.doodid == guy?.doodid) {
                                    guy = dood
                                }
                            }
                            */
                            // theController.localDoods.append(guy)
                            for (index, existingDood) in theController.localDoods.enumerated() {
                                if (existingDood?.doodid == guy?.doodid) {
                                    theController.localDoods[index] = guy
                                }
                            }
                        }
                    } else {
                        // if no image..
                    }
                
                    
                    //Optional([<TheApp.TableViewController: 0x117d09880>, <TheApp.ViewController: 0x117e1eb80>])
                    
                    if (UIApplication.shared.windows[0].rootViewController?.childViewControllers.count == 1) {
                        // must be table view
                        theController.navigationController?.navigationBar.items?[0].rightBarButtonItem?.title = "\(TheSocket.pending)/\(TheSocket.total)"
                    } else {
                        // must be detail view?
                        let viewController = UIApplication.shared.windows[0].rootViewController?.childViewControllers[1] as? ViewController
                        viewController?.detailNameLabel.text = name
                        viewController?.sendButton.isEnabled = true
                    }
                }
            }
            DispatchQueue.main.async {
                theController.tableView.reloadData()
            }
        }
    }
 
    func closeConnection() {
        print("client socket disconnecting.")
        socket.disconnect()
    }
    
    func dispatchDood(dood: Dood) {
        // TheSocket.pending -= 1
        // UIApplication.shared.windows[0].rootViewController?.navigationController?.navigationBar.items?[0].rightBarButtonItem?.title = "\(TheSocket.idle)/\(TheSocket.total)"
        
        // UIApplication.shared.windows[0].rootViewController?.navigationController?.navigationBar.items?[0].rightBarButtonItem?.title = "FART"
        
        print("dispatching \(dood.name)")
        dood.status = "dispatched"
        
        socket.emit("dispatch", "{ \"name\": \"\(dood.name)\", \"doodid\": \"\(dood.doodid)\", \"theOwner\": \"\(dood.theOwner)\", \"level\": \"\(dood.level)\", \"image\": \"\", \"rarity\": \"\(dood.rarity)\", \"type\": \"\(dood.type)\", \"status\": \"\(dood.status)\", \"experience\": \"\(dood.experience)\" }")
    }
}


//
//  Dood.swift
//  TheApp
//
//  Created by Michael Wood on 7/11/17.
//  Copyright © 2017 Michael Wood. All rights reserved.
//

import UIKit
import os.log

class Dood: NSObject {
    var doodid: Int
    var theOwner: String
    var level: Int
    var name: String
    var image: UIImage
    var imageURL: String
    var rarity: Int
    var type: String
    var status: String
    var experience: Int
    var duration: Int
    var currentTick: Int
    static var doods = [Dood?]()
    
    struct PropertyKey {
        static let doodid = "doodid"
        static let theOwner = "theOwner"
        static let level = "level"
        static let name = "name"
        static let image = "image"
        static let imageURL = "imageURL"
        static let rarity = "rarity"
        static let type = "type"
        static let status = "status"
        static let experience = "experience"
        static let duration = "duration"
        static let currentTick = "currentTick"
    }
    
    init?(doodid: Int, theOwner: String, level: Int, name: String, image: UIImage, imageURL: String, rarity: Int, type: String, status: String,  experience: Int, duration: Int, currentTick: Int) {
        
        self.doodid = doodid
        self.theOwner = theOwner
        self.level = level
        self.name = name
        self.image = image
        self.imageURL = imageURL
        self.rarity = rarity
        self.type = type
        self.status = status
        self.experience = experience
        self.duration = duration
        self.currentTick = currentTick
    }
    
    /*
    func encode(with aCoder: NSCoder) {
        aCoder.encode(doodid, forKey: PropertyKey.doodid)
        aCoder.encode(theOwner, forKey: PropertyKey.theOwner)
        aCoder.encode(level, forKey: PropertyKey.level)
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(image, forKey: PropertyKey.image)
        aCoder.encode(rarity, forKey: PropertyKey.rarity)
        aCoder.encode(created, forKey: PropertyKey.created)
        aCoder.encode(type, forKey: PropertyKey.type)
        aCoder.encode(status, forKey: PropertyKey.status)
        aCoder.encode(spoils, forKey: PropertyKey.spoils)
        aCoder.encode(missionStart, forKey: PropertyKey.missionStart)
        aCoder.encode(missionDuration, forKey: PropertyKey.missionDuration)
        aCoder.encode(experience, forKey: PropertyKey.experience)
    }
     */

    /*
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        //guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
        //    os_log("Unable to decode the name for a Dood object.", log: OSLog.default, type: .debug)
        //    return nil
        //}
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let name = aDecoder.decodeObject(forKey: PropertyKey.name)
        let doodid = aDecoder.decodeInteger(forKey: PropertyKey.doodid)
        let theOwner = aDecoder.decodeObject(forKey: PropertyKey.theOwner)
        let level = aDecoder.decodeInteger(forKey: PropertyKey.level)
        let image = aDecoder.decodeObject(forKey: PropertyKey.image)
        let rarity = aDecoder.decodeInteger(forKey: PropertyKey.rarity)
        let created = aDecoder.decodeObject(forKey: PropertyKey.created)
        let type = aDecoder.decodeObject(forKey: PropertyKey.type)
        let status = aDecoder.decodeObject(forKey: PropertyKey.status)
        let spoils = aDecoder.decodeObject(forKey: PropertyKey.spoils)
        let missionStart = aDecoder.decodeObject(forKey: PropertyKey.missionStart)
        let missionDuration = aDecoder.decodeObject(forKey: PropertyKey.missionDuration)
        let experience = aDecoder.decodeInteger(forKey: PropertyKey.experience)
        

        
        // Must call designated initializer.
        self.init(doodid: doodid, theOwner: theOwner as! String, level: level, name: name as! String, image: image as! UIImage, rarity: rarity, created: created as! Date, type: type as! String, status: status as! String, spoils: spoils as! String, missionStart: missionStart as! Date, missionDuration: missionDuration as! Date, experience: experience)
    }
    */
    

}
        

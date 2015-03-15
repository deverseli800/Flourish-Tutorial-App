//
//  Entry.swift
//  Flourish-Teaching
//
//  Created by Cesar Devers on 3/12/15.
//  Copyright (c) 2015 Cesar Devers. All rights reserved.
//

import Foundation
import CloudKit

class Entry: NSObject {
    let model: Model = Model.singleton()
    var records = [Entry]()
    var record: CKRecord!
    
    var title: String {
        get {
            return (self.record!.objectForKey("Title")) as! String
        }
        
        set(val) {
            record.setObject(val, forKey: "Title")
        }
    }
    
    var body: String {
        get {
           return (self.record!.objectForKey("Body")) as! String
        }
        
        set(val) {
            record.setObject(val, forKey: "Body")
        }
    }
    
    var mood: Int {
        get {
            return (self.record.objectForKey("Mood")) as! Int
        }
        
        set(val) {
            record.setObject(val, forKey: "Mood")
        }
    }
    
    var location: CLLocation {
        get {
            return (self.record.objectForKey("Location")) as! CLLocation
        }
        
        set (val) {
            record.setObject(val, forKey: "Location")
        }
    }
    
    init(database: CKDatabase? = nil, record: CKRecord? = nil) {
        self.record = (record != nil) ? record! : CKRecord(recordType: "Entry")
    }
    
    convenience init(title:String, body: String, mood: Int, location: CLLocation?)
    {
        self.init()
        self.title = title
        self.body = body
        self.mood = mood
        
        if let location = location {
            self.location = location
        }
    }
}

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
    var key: String
    
    var title: String? {
        get {
            return AuthHelper.decrypt(self.record!.objectForKey("Title") as! String, password: key).string
        }
        
        set(val) {
            record.setObject(AuthHelper.encrypt(val, password: key).string, forKey: "Title")
        }
    }
    
    var body: String? {
        get {
            return AuthHelper.decrypt(self.record!.objectForKey("Body") as! String, password: key).string
        }
        
        set(val) {
            record.setObject(AuthHelper.encrypt(val, password: key).string, forKey: "Body")
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
        key = AuthHelper.key
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
    
    func create(completion: (success: Bool, message: String, error: NSError?) -> ()) {
        model.privateDB.saveRecord(record, completionHandler: {
          record, error in
            dispatch_async(dispatch_get_main_queue()) {
                if error != nil {
                    completion(success: false, message: "Could not save to the cloud. Womp", error: error)
                }
                else {
                    self.record = record
                    completion(success: true, message: "Your entry was saved successfully!", error: nil)
                }
            }
        })
    }
    
    func load(predicate: NSPredicate? = nil, sort: NSSortDescriptor? = nil) {
        let predicate = predicate ?? NSPredicate(value:true)
        let sort = sort ?? NSSortDescriptor(key: "creationDate", ascending: false)
        let query = CKQuery(recordType: "Entry", predicate: predicate)
        query.sortDescriptors = [sort]
        
        model.privateDB.performQuery(query, inZoneWithID: nil, completionHandler: {
            results, error in
            if error != nil
            {
                dispatch_async(dispatch_get_main_queue()) {
                    self.model.delegate?.errorUpdating(error)
                    println("error loading: \(error)")
                    return
                }
            }
            else {
                self.records.removeAll(keepCapacity: true)
                
                for record in results {
                    let entry = Entry(record: record as? CKRecord)
                    self.records.append(entry)
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.model.delegate?.modelUpdated()
                    println("successfully loaded entries")
                    return
                }
            }
            
        })
    }
    
    func update(title: String? = nil, body: String? = nil, mood: Int? = nil, completion:(success: Bool, message: String, error: NSError?)->())
    {
        self.title = title ?? self.title
        self.body = body ?? self.body
        self.mood = mood ?? self.mood
        
        create() { success, message, error in
            completion(success: success, message: message, error: error)
        }
    }
    
    func destroy(completion: (success: Bool, message: String, error: NSError?) -> ())
    {
        model.privateDB.deleteRecordWithID(record.recordID, completionHandler: {
            record, error in
            if error != nil {
                println("ERR RECORD ID: \(self.record.recordID)")
                completion(success: false, message: "could not delete entry", error: nil)
            }
            else {
                println("DEL RECORD ID: \(self.record.recordID)")
                completion(success: true, message: "successfully deleted entry", error: nil)
            }
        })
    }
    
}

//
//  Model.swift
//  Flourish-Teaching
//
//  Created by Cesar Devers on 3/12/15.
//  Copyright (c) 2015 Cesar Devers. All rights reserved.
//

import Foundation
import CloudKit

protocol ModelDelegate
{
    func errorUpdating(error:NSError)
    func modelUpdated()
}

@objc class Model
{
    class func singleton() -> Model
    {
            return globalModelSingleton
    }
    
    var delegate: ModelDelegate?
    let container: CKContainer
    let publicDB: CKDatabase
    let privateDB: CKDatabase
    
    init()
    {
        container = CKContainer.defaultContainer()
        publicDB = container.publicCloudDatabase
        privateDB = container.privateCloudDatabase
    }
}

let globalModelSingleton = Model()

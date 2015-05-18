//
//  JournalController.swift
//  Flourish-Teaching
//
//  Created by Cesar Devers on 5/5/15.
//  Copyright (c) 2015 Cesar Devers. All rights reserved.
//

import UIKit

class JournalController: UITableViewController, ModelDelegate
{
    let entries = Entry()
    @IBOutlet weak var titleLabel: UILabel!
    
    struct Properties {
        static let entryCellIdentifier = "entryCell"
        static let segueToDetailIndentifier = "tableShowEntry"
    }

    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        entries.model.delegate = self
        entries.load()
        
        tableView.estimatedRowHeight = 220.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func errorUpdating(error:NSError) {
    }
    
    func modelUpdated() {
        tableView.reloadData()
        println("our saved entries are \(entries.records)")
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return entries.records.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(Properties.entryCellIdentifier, forIndexPath: indexPath) as! JournalEntryCell
        
        cell.entry = entries.records[indexPath.row]
        
        return cell
    }


    
}


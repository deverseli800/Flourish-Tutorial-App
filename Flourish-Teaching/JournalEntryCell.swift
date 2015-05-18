//
//  JournalEntryCell.swift
//  Flourish-Teaching
//
//  Created by Cesar Devers on 5/11/15.
//  Copyright (c) 2015 Cesar Devers. All rights reserved.
//

import UIKit

class JournalEntryCell: UITableViewCell
{
    var entry: Entry? {
        didSet {
            updateUI()
            println("we are updating")
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    func updateUI()
    {
        // Reset properties
        titleLabel?.text = nil
        bodyLabel?.text = nil
        
        if let entry = self.entry
        {
            println("\(self.entry) our entry");
            titleLabel?.text = entry.title
            bodyLabel?.text = entry.body

        }
    }
    
    }
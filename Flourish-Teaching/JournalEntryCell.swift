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
    
    //For views that contain custom content using UIKit or Core Graphics, the system calls the view’s drawRect: method. 
    override func drawRect(rect: CGRect)
    {
        if let mood = entry?.mood
        {
            // Draw bottom border
            let bottomPath = UIBezierPath()
            //The moveToPoint: method sets the starting point of the shape you want to create.
            bottomPath.moveToPoint(CGPoint(x: 0, y: contentView.bounds.height))
            //you create the lines of the shape using the addLineToPoint: method
            bottomPath.addLineToPoint(CGPoint(x: contentView.bounds.width, y: contentView.bounds.height))
            
            
            
            let borderBottom = CAShapeLayer()
            // The path defining the shape to be rendered. Animatable.
            borderBottom.path = bottomPath.CGPath
            // Specifies the line width of the shape’s path
            borderBottom.lineWidth = 1.0
            // The color used to stroke the shape’s path.
            borderBottom.strokeColor = UIColor(rgba: "#dad5cd").CGColor
            // stacking the layer in the z index, from CA layer
            borderBottom.zPosition = 2
            // add layer
            contentView.layer.addSublayer(borderBottom)
            
           
        }
    }

    
    }
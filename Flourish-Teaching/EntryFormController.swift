//
//  EntryFormController.swift
//  Flourish-Teaching
//
//  Created by Cesar Devers on 3/8/15.
//  Copyright (c) 2015 Cesar Devers. All rights reserved.
//

import UIKit

class EntryFormController: UIViewController {
    
    let picker = UIImageView(image:UIImage(named: "picker"))
    let feelings = [
        ["title": "the best", "color" : "#8647b7"],
        ["title": "really good", "color" : "#4870b7"],
        ["title": "okay", "color" : "#45a85a"],
        ["title": "meh", "color" : "#a8a23f"],
        ["title": "not so great", "color" : "#c6802e"],
        ["title": "the worst", "color" : "#b05050"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        picker.frame = CGRect(x:45, y:160, width:286, height: 291)
        picker.alpha = 0
        picker.hidden = true
        picker.userInteractionEnabled = true
        
        var offset = 21
        
        for (index, feeling) in enumerate(feelings) {
            let button = UIButton()
            button.frame = CGRect(x:13, y:offset, width: 260, height:43)
            button.setTitle(feeling["title"]!, forState: .Normal)
            button.setTitleColor(UIColor(rgba: feeling["color"]!), forState: .Normal)
            picker.addSubview(button)
            offset += 44
        }
        
        
        view.addSubview(picker)
    }
    
    func openPicker() {
        self.picker.hidden = false
        
        UIView.animateWithDuration(
            0.3,
            animations: {
                self.picker.frame = CGRect(x: 45, y: 180, width: 286, height: 291)
                self.picker.alpha = 1
            },
            completion: {finished in
                
            }
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


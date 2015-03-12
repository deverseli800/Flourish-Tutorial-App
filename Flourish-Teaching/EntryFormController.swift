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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


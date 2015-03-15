//
//  EntryFormController.swift
//  Flourish-Teaching
//
//  Created by Cesar Devers on 3/8/15.
//  Copyright (c) 2015 Cesar Devers. All rights reserved.
//

import UIKit
import CoreLocation

class EntryFormController: UIViewController, CLLocationManagerDelegate {
    let picker = UIImageView(image:UIImage(named: "picker"))
    let feelings = [
        ["title": "the best", "color" : "#8647b7"],
        ["title": "really good", "color" : "#4870b7"],
        ["title": "okay", "color" : "#45a85a"],
        ["title": "meh", "color" : "#a8a23f"],
        ["title": "not so great", "color" : "#c6802e"],
        ["title": "the worst", "color" : "#b05050"]
    ]
    var locationManager : CLLocationManager!
    var currentLocation : CLLocation?
    
    @IBAction func togglePicker(sender: AnyObject) {
        picker.hidden ? openPicker() : closePicker()
    }
    @IBAction func setMood(sender: AnyObject) {
        feelingButton.tag = sender.tag
        feelingButton.setTitle(sender.currentTitle, forState: .Normal)
        feelingButton.setTitleColor(sender.titleColorForState(.Normal), forState: .Normal)
        
        closePicker()
    }
    
    @IBOutlet weak var feelingButton: UIButton!
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var bodyInput: UITextView!
    
    @IBAction func saveForm(sender: AnyObject) {
        let entry = Entry(title:titleInput.text, body:bodyInput.text, mood: feelingButton.tag, location: currentLocation)
        
        entry.create() {
            success, message, error in
            //Reset and clear the form if saved
            if success {
                println("success!", message)
                self.titleInput = nil
                self.feelingButton.setTitle("select", forState: .Normal)
                self.feelingButton.setTitleColor(UIColor(rgba:"#3687FF"), forState: .Normal)
                self.bodyInput.text = nil
            }
            else {
                println(error)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        picker.frame = CGRect(x:45, y:160, width:286, height: 291)
        picker.alpha = 0
        picker.hidden = true
        picker.userInteractionEnabled = true
        setupLocationManager()
        
        var offset = 21
        
        for (index, feeling) in enumerate(feelings) {
            let button = UIButton()
            button.frame = CGRect(x:13, y:offset, width: 260, height:43)
            button.tag = index
            button.setTitle(feeling["title"]!, forState: .Normal)
            button.setTitleColor(UIColor(rgba: feeling["color"]!), forState: .Normal)
            button.addTarget(self, action: "setMood:", forControlEvents: .TouchUpInside)
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
    
    func closePicker() {
        UIView.animateWithDuration(0.3,
            animations: {
                self.picker.frame = CGRect(x: 45, y: 160, width: 286, height: 291)
                self.picker.alpha = 0
            },
            completion: { finished in
                if (finished) {
                    self.picker.hidden = true
                }
            }
        )
    }
    
    func setupLocationManager()
    {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .NotDetermined :
            manager.requestWhenInUseAuthorization()
            println("prompt th euser to enable location services")
            
        case .Denied:
            println("prompt the user to re-enable location services in settings")
        
        case .AuthorizedWhenInUse :
            println("authorized when in used")
            
        default:
            println("other status")
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        currentLocation = (locations.last as! CLLocation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


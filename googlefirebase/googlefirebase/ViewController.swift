//
//  ViewController.swift
//  googlefirebase
//
//  Created by Muhammad Raza on 17/04/2015.
//  Copyright (c) 2015 Muhammad Raza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let geofireRef = Firebase(url: "https://sweltering-fire-8481.firebaseio.com/")
        let geoFire = GeoFire(firebaseRef: geofireRef)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


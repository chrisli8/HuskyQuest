//
//  ViewController.swift
//  HuskyQuest
//
//  Created by Chris Li on 5/23/17.
//  Copyright © 2017 Chris Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var data = AppData.shared

    @IBOutlet weak var loadBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if !data.characterCreated {
            loadBtn.isHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    /*@IBAction func newBtnPressed(_ sender: Any) {
        data.reset()
    }*/

    
    @IBAction func loadBtnPressed(_ sender: UIButton) {
        
        // Load previously created character
        // else disable button
        
//        data.characterCreated = true;
//        data.personalDescription["Name"] = "Default"
//        data.personalDescription["Gender"] = "Default"
//        data.personalDescription["Age"] = "Default"
//        data.personalDescription["Ethnicity"] = "Default"
//        
//        for (key, _) in data.stats {
//            data.stats[key] = 10
//        }
    }

}


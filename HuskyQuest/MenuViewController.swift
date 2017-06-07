//
//  MenuViewController.swift
//  HuskyQuest
//
//  Created by Chris Li on 6/5/17.
//  Copyright © 2017 Chris Li. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    @IBOutlet weak var learnNotification: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        learnNotification.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        learnNotification.isHidden = true
        if AppData.shared.experience > 0 {
            learnNotification.isHidden = false
        }
        learnNotification.layer.cornerRadius = 20
        learnNotification.layer.masksToBounds = true
        learnNotification.text = String(Int(AppData.shared.experience as Double))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

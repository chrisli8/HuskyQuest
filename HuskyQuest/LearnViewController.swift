//
//  LearnViewController.swift
//  HuskyQuest
//
//  Created by Chris Li on 6/5/17.
//  Copyright © 2017 Chris Li. All rights reserved.
//

import UIKit

class LearnViewController: UIViewController {
    @IBOutlet weak var charismaProgress: UIProgressView!
    @IBOutlet weak var understandingProgress: UIProgressView!
    @IBOutlet weak var creativityProgress: UIProgressView!
    @IBOutlet weak var charismaUpBtn: UIButton!
    @IBOutlet weak var understandingUpBtn: UIButton!
    @IBOutlet weak var creativityUpBtn: UIButton!
    @IBOutlet weak var diligenceUpBtn: UIButton!
    @IBOutlet weak var diligenceProgress: UIProgressView!
    @IBOutlet weak var experienceLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

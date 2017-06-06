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
    @IBOutlet weak var diligenceLabel: UILabel!
    @IBOutlet weak var creativityLabel: UILabel!
    @IBOutlet weak var understandingLabel: UILabel!
    @IBOutlet weak var charismaLabel: UILabel!

    var data = AppData.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        experienceLabel.text = String(data.experience)
        data.experience = data.experience + 1 // Counters update tick
        updateExperience()
        updateProgress()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    // MARK: - Helper Methods
    
    // enables and diables stat-up buttons when experence is 0
    // deincrements experience by one
    func updateExperience() {
        data.experience = data.experience - 1
        if data.experience <= 0 {
            diligenceUpBtn.isHidden = true
            creativityUpBtn.isHidden = true
            understandingUpBtn.isHidden = true
            charismaUpBtn.isHidden = true
        } else {
            diligenceUpBtn.isHidden = false
            creativityUpBtn.isHidden = false
            understandingUpBtn.isHidden = false
            charismaUpBtn.isHidden = false
        }
        checkStatMax()
        experienceLabel.text = String(data.experience)
    }
    
    func checkStatMax() {
        if data.stats["Diligence"]! >= 25 {
            diligenceUpBtn.isHidden = true
        }
        if data.stats["Creativity"]! >= 25 {
            creativityUpBtn.isHidden = true
        }
        if data.stats["Understanding"]! >= 25 {
            understandingUpBtn.isHidden = true
        }
        if data.stats["Charisma"]! >= 25 {
            charismaUpBtn.isHidden = true
        }
    }
    
    // redraws progress bars based on
    func updateProgress() {
        // Set Stats
        diligenceLabel.text = String(describing: data.stats["Diligence"]!)
        creativityLabel.text = String(describing: data.stats["Creativity"]!)
        understandingLabel.text = String(describing: data.stats["Understanding"]!)
        charismaLabel.text = String(describing: data.stats["Charisma"]!)
        
        diligenceProgress.setProgress(Float(AppData.shared.stats["Diligence"]!) / 25.0, animated: false)
        creativityProgress.setProgress(Float(AppData.shared.stats["Creativity"]!) / 25.0, animated: false)
        understandingProgress.setProgress(Float(AppData.shared.stats["Understanding"]!) / 25.0, animated: false)
        charismaProgress.setProgress(Float(AppData.shared.stats["Charisma"]!) / 25.0, animated: false)
    }
    
    // MARK: - Actions
    
    @IBAction func diligenceUpPressed(_ sender: Any) {
        data.stats["Diligence"] = data.stats["Diligence"]! + 1
        updateProgress()
        updateExperience()
    }
    
    @IBAction func creativityUpPressed(_ sender: Any) {
        data.stats["Creativity"] = data.stats["Creativity"]! + 1
        updateProgress()
        updateExperience()
    }
    
    @IBAction func understandingUpPressed(_ sender: Any) {
        data.stats["Understanding"] = data.stats["Understanding"]! + 1
        updateProgress()
        updateExperience()
    }
    
    @IBAction func charismaUpPressed(_ sender: Any) {
        data.stats["Charisma"] = data.stats["Charisma"]! + 1
        updateProgress()
        updateExperience()
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

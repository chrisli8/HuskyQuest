//
//  CharacterSummaryViewController.swift
//  HuskyQuest
//
//  Created by Chris Li on 6/4/17.
//  Copyright © 2017 Chris Li. All rights reserved.
//

import UIKit

class CharacterSummaryViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var ethnicityLabel: UILabel!

    @IBOutlet weak var progressDiligence: UIProgressView!
    @IBOutlet weak var progressCreativity: UIProgressView!
    @IBOutlet weak var progressUnderstanding: UIProgressView!
    @IBOutlet weak var progressCharisma: UIProgressView!
    
    @IBOutlet weak var randomFacts: UILabel!
    var facts = ["basketball", "swimming", "water polo",
                 "badminton", "tennis", "track and field"]
    
    @IBOutlet weak var GPA: UILabel!
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    // 0-25 for each stat value
    // 30-40 starting total stats total

    @IBOutlet weak var majorLabel: UILabel!
    
    let DEBUG = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if AppData.shared.characterCreated {
            btnBack.isHidden = true
            btnNext.isHidden = true
        }
        
        // Set data
        nameLabel.text = AppData.shared.personalDescription["Name"]
        genderLabel.text = AppData.shared.personalDescription["Gender"]
        ageLabel.text = AppData.shared.personalDescription["Age"]
        ethnicityLabel.text = AppData.shared.personalDescription["Ethnicity"]
        
        // For animation
        progressDiligence.setProgress(Float(0), animated: true)
        progressCreativity.setProgress(Float(0), animated: true)
        progressUnderstanding.setProgress(Float(0), animated: true)
        progressCharisma.setProgress(Float(0), animated: true)
        
        // Set Stats
        progressDiligence.setProgress(Float(AppData.shared.stats["Diligence"]!) / 25.0, animated: true)
        progressCreativity.setProgress(Float(AppData.shared.stats["Creativity"]!) / 25.0, animated: true)
        progressUnderstanding.setProgress(Float(AppData.shared.stats["Understanding"]!) / 25.0, animated: true)
        progressCharisma.setProgress(Float(AppData.shared.stats["Charisma"]!) / 25.0, animated: true)
        
        majorLabel.text = AppData.shared.characterMajor
        
        let rand = Int(arc4random_uniform(5))
        
        let sport1 = facts[rand]
        randomFacts.text = randomFacts.text! + sport1
        
        let rand2 = Int(arc4random_uniform(4 - 2)) + 2
        
        let num = NSString(format: "%.2f", Double((CGFloat(rand2) + CGFloat(Float(arc4random()) / Float(UINT32_MAX)))))
        
        GPA.text = GPA.text! + String(describing: num)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    // set's character created as true when next button is pres
    @IBAction func onNextPressed(_ sender: Any) {
        AppData.shared.characterCreated = true
    }
    
    // MARK: - Helper Methods
    
    // MARK: - Segue
    
    // sets data to singleton when progressing
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Reset story so new user can experience what's going on
    }
    */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

}

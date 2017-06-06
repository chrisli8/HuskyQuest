//
//  StoryViewController.swift
//  HuskyQuest
//
//  Created by studentuser on 6/1/17.
//  Copyright © 2017 Chris Li. All rights reserved.
//

import UIKit
import Alamofire

class StoryViewController: UIViewController {

    @IBOutlet weak var StoryTextBox: UITextView!
    @IBOutlet weak var Choice1Button: UIButton!
    @IBOutlet weak var Choice2Button: UIButton!
    @IBOutlet weak var Choice3Button: UIButton!
    @IBOutlet weak var experienceLabel: UILabel!
    
    var choices:[[String:Any]] = []
    var currTreeName = "main"
    var data = AppData.shared
    
    var timer = Timer()
    var progressBarTimer = Timer()
    var progressNum : Float = 0.0
    var progressIncrement = Timer()

    @IBOutlet weak var ProgressBar: UIProgressView!
    
    override func viewDidLoad() {
        turnPage()
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        ProgressBar.progress = 0
        timerReset()
    }
    
    func timerReset(){
        timer.invalidate()
        progressBarTimer.invalidate()
        progressIncrement.invalidate()
        if data.auto == true{
            timer = Timer.scheduledTimer(timeInterval: data.autoTimer, target: self, selector: #selector(self.autoClick), userInfo: nil, repeats: true);
            progressBarTimer = Timer.scheduledTimer(timeInterval: data.autoTimer/2, target: self, selector: #selector(self.showProgress), userInfo: nil, repeats: true);
            progressNum = 0
            ProgressBar.progress = 0
        }
    }
    
    func showProgress(){
        progressIncrement = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.incrementProgress), userInfo: nil, repeats: true);
    }
    
    func incrementProgress(){
        progressNum = progressNum + Float(data.autoTimer/10)
        ProgressBar.progress = progressNum
        
    }
    func autoClick(){
        let buttonArray = [Choice1Button, Choice2Button, Choice3Button]
        let randomButtonID = Int(arc4random_uniform(UInt32(choices.count - 1)))
        choiceClick(buttonArray[randomButtonID]!)
    }
    
    
    @IBAction func choiceClick(_ sender: UIButton) {
        timer.invalidate()
        data.experience += 0.5
        
        //Updates what was picked
        var pickedChoice : [String:Any] = [:]
        if sender.tag == 1 {
            pickedChoice = self.choices[0]
        } else if sender.tag == 2{
            pickedChoice = self.choices[1]
        } else {
            pickedChoice = self.choices[2]
        }
        if (pickedChoice["title"] as! String != "Continue") {
            data.history = "\(data.history) \n\nYou chose \(pickedChoice["title"] as! String)" + "\n\n"
        } else {
            data.history = "\(data.history) \n\n"
        }
        
        //StatChanges
        if pickedChoice["increase"] != nil {
            var currentStat = data.stats[pickedChoice["increase"] as! String]!
            currentStat += 1
            data.stats[pickedChoice["increase"] as! String] = currentStat
        }
        if pickedChoice["decrease"] != nil {
            var currentStat = data.stats[pickedChoice["decrease"] as! String]!
            currentStat += 1
            data.stats[pickedChoice["decrease"] as! String] = currentStat
        }
        
        //Tree Swap Support
        if pickedChoice["changeTree"] != nil {
            currTreeName = pickedChoice["changeTree"] as! String
        }
        
        // Checks for pass/fail finals at the end, otherwise updates index normally
        let choiceTitle = pickedChoice["title"] as! String
        let chosenIndex = pickedChoice["page"] as! Int
        if choiceTitle == "Take finals" {
            if compareStats() == false {
                // failing exam is index 13 instead of 14 so minus one
                data.bookmarkIndex[currTreeName] = chosenIndex - 1
            } else {
                data.bookmarkIndex[currTreeName] = chosenIndex
            }
        } else {
            //updates index on the tree based off the attribute attached the choice
            data.bookmarkIndex[currTreeName] = chosenIndex
        }
        
        timerReset()
        turnPage()
        data.history = "\(data.history) \(data.currTree[data.bookmarkIndex[currTreeName]!]["text"] as! String) "
        
        
    }
    
    // compares the stats in the passFinals array to the char stats
    // passFinals stats are determined by the major user chooses
    func compareStats() -> Bool {
        let major = data.characterMajor
        var reqs : [String : Int] = [:]
        if major == "CSE" {
            reqs = data.passFinals[0]
        } else if major == "INFO" {
            reqs = data.passFinals[1]
        } else if major == "HCDE" {
            reqs = data.passFinals[2]
        }
        let reqArrays = Array(reqs.keys)
        for req in reqArrays {
            if data.stats[req]! < reqs[req]! {
                return false
            }
        }
        return true
    }
    
    func back(sender:UIBarButtonItem){
        timer.invalidate()
        _ = navigationController?.popViewController(animated: true)
    }
    
    func turnPage(){
        
        //Updates story text box and hides/unhides choices based on existence
        StoryTextBox.text = data.currTree[data.bookmarkIndex[currTreeName]!]["text"] as! String
        self.experienceLabel.text = String(data.experience)
        self.choices = data.currTree[data.bookmarkIndex[currTreeName]!]["choices"] as! [[String:Any]]
        self.Choice1Button.setTitle(self.choices[0]["title"] as? String, for: UIControlState.normal)
        self.Choice2Button.isHidden = true
        self.Choice3Button.isHidden = true
        if self.choices.count > 1{
            self.Choice2Button.isHidden = false
            var Random = Int(arc4random_uniform(100))
            self.Choice2Button.setTitle(self.choices[1]["title"] as? String, for: UIControlState.normal)
            if self.choices[1]["modifier"] != nil {
                Random += data.stats[self.choices[1]["modifier"] as! String]! * 4
            }
            if self.choices[1]["chance"] != nil && Random <= self.choices[1]["chance"] as! Int{
                self.Choice2Button.isHidden = true
            }
            if self.choices.count > 2{
                self.Choice3Button.isHidden = false
                Random = Int(arc4random_uniform(100))
                self.Choice3Button.setTitle(self.choices[2]["title"] as? String, for: UIControlState.normal)
                
                if self.choices[2]["modifier"] != nil {
                    Random += data.stats[self.choices[2]["modifier"] as! String]! * 4
                }
                if self.choices[2]["chance"] != nil && Random <= self.choices[2]["chance"] as! Int{
                    self.Choice3Button.isHidden = true
                }
            }
            
        }
        
    }
    
    
}

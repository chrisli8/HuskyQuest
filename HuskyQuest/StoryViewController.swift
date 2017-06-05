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
    
    var choices:[[String:Any]] = []
    var currTreeName = "main"
    var data = AppData.shared

    override func viewDidLoad() {
        turnPage()
    }
    
    @IBAction func choiceClick(_ sender: UIButton) {
        
        //Updates what was picked
        var pickedChoice : [String:Any] = [:]
        if sender.tag == 1 {
            pickedChoice = self.choices[0]
        } else if sender.tag == 2{
            pickedChoice = self.choices[1]
        } else {
            pickedChoice = self.choices[2]
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
        //updates index on the tree based off the attribute attached the choice
        if "\(String(describing: pickedChoice["response"]))" != "current" {
            data.bookmarkIndex[currTreeName] = pickedChoice["response"] as? Int
        }
        
        turnPage()
        
    }
    
    func turnPage(){
        
        //Updates story text box and hides/unhides choices based on existence
        StoryTextBox.text = data.currTree[data.bookmarkIndex[currTreeName]!]["text"] as! String
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

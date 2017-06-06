//
//  AppData.swift
//  HuskyQuest
//
//  Created by Chris Li on 6/4/17.
//  Copyright © 2017 Chris Li. All rights reserved.
//

import UIKit
import Alamofire


class AppData: NSObject {
    static let shared = AppData()
    
    var url = URL(string:"https://students.washington.edu/kpham97/Story.JSON")
    
    
    //Array holding all the data
    var jsonArray:[[String:Any]] = []
    
    //Current Tree that the game is in
    var currTree:[[String:Any]] = []
    
    //Story so far
    var history = "You've arrived to the University of Washington, and begin moving your belongings into the dorm. Your new roommate is already there. You look around and notice they haven't unpacked yet."
    
    var experience = 0.0
    
    //Bookmark storage for jumping between trees in the story
    var bookmarkIndex = [
    "main" : 0,
    "filler" : 0,
    "subtreenamehere" : 0
    ]
    
    // To get character's major
    var characterMajor = "CSE" // Defaults to CSE in case the user doesn't choose
    
    // To check if character has been created
    var characterCreated = false
    
    // Data that doesn't affect the game
    var personalDescription: [String: String] = [
        "Name" : "",
        "Gender" : "",
        "Age" : "",
        "Ethnicity": "",
        "Personality": ""
    ]
    
    // Statistics for character
    var stats: [String: Int] = [
        "RR": 5, //Roommate relationship CHANGE in JSON
        "H" : 10, //Health CHANGE IN JSON
        "Diligence": 0,
        "Creativity": 0,
        "Understanding": 0,
        "Charisma": 0
    ]
    
    // Map of personality labels to their descriptions
    let personalityMap: [String: String] = [
        // Analysts
        "INTJ" : "Imaginative and strategic thinkers, with a plan for everything.",
        "INTP" : "Innovative inventors with an unquenchable thirst for knowledge.",
        "ENTJ" : "Bold, imaginative and strong-willed leaders, always finding a way – or making one.",
        "ENTP" : "Smart and curious thinkers who cannot resist an intellectual challenge.",

        // Diplomats
        "INFJ" : "Quiet and mystical, yet very inspiring and tireless idealists.",
        "INFP" : "Poetic, kind and altruistic people, always eager to help a good cause.",
        "ENFJ" : "Charismatic and inspiring leaders, able to mesmerize their listeners.",
        "ENFP" : "Enthusiastic, creative and sociable free spirits, who can always find a reason to smile.",

        // Sentinels
        "ISTJ" : "Practical and fact-minded individuals, whose reliability cannot be doubted.",
        "ISFJ" : "Very dedicated and warm protectors, always ready to defend their loved ones.",
        "ESTJ" : "Excellent administrators, unsurpassed at managing things – or people.",
        "ESFJ" : "Extraordinarily caring, social and popular people, always eager to help.",

        // Explorers
        "ISTP" : "Bold and practical experimenters, masters of all kinds of tools.",
        "ISFP" : "Flexible and charming artists, always ready to explore and experience something new.",
        "ESTP" : "Smart, energetic and very perceptive people, who truly enjoy living on the edge.",
        "ESFP" : "Spontaneous, energetic and enthusiastic people – life is never boring around them."
    ]
    
    let passFinals: [[String: Int]] = [
        // CSE requirements
        ["Diligence": 20, "Creativity": 10, "Understanding": 20, "Charisma": 10],
        // INFO requirements
        ["Diligence": 15, "Creativity": 15, "Understanding": 15, "Charisma": 15],
        // HCDE requirements
        ["Diligence": 10, "Creativity": 20, "Understanding": 10, "Charisma": 20]
    ]

    let defaults = UserDefaults.standard
    
    var auto : Bool = true
    var saveTimer : Double = 10
    var autoTimer : Double = 10
    
    var timer = Timer()
    
    override init(){
        super.init()
        //Loads the default file destination for the story.json file
        let destination: DownloadRequest.DownloadFileDestination = {_, _ in
            
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("story.json")
            
            return(fileURL, [.createIntermediateDirectories])
        }
        
        characterCreated = defaults.value(forKey: "characterCreated") != nil
        timer = Timer.scheduledTimer(timeInterval: saveTimer, target: self, selector: #selector(self.saveData), userInfo: nil, repeats: true)
        
        if defaults.value(forKey: "auto") as? String == "no" {
            auto = false
        }
        
        if defaults.value(forKey: "autotimer") != nil {
            autoTimer = Double(defaults.value(forKey: "autotimer") as! String)!
        
        }
        
        if defaults.value(forKey: "savetimer") != nil {
            saveTimer = Double(defaults.value(forKey: "savetimer") as! String)!
            
        }
        
        if characterCreated{
            history = defaults.value(forKey: "history") as! String
            bookmarkIndex = defaults.value(forKey: "bookmarkIndex") as! [String : Int]
            stats = defaults.value(forKey: "stats") as! [String : Int]
            personalDescription = defaults.value(forKey: "personalDescription") as! [String : String]
            characterMajor = defaults.value(forKey: "characterMajor") as! String
            history = defaults.value(forKey:"history") as! String
            experience = defaults.value(forKey: "experience") as! Double
        }
        
        
        //downloads and and loads json file
        Alamofire.download(url!, method: .get, to: destination).responseJSON{response in
            print(response.result)
            debugPrint(response)
            self.loadJSON()
            if self.currTree.count == 0 {
                self.currTree = self.jsonArray[1]["tree" ] as! [[String : Any]]
            }
        }
        

    }
    
    func reset(){
        
        history = "You've arrived to the University of Washington, and begin moving your belongings into the dorm. Your new roommate is already there. You look around and notice they haven't unpacked yet."
        
        experience = 0.0
        
        bookmarkIndex = [
            "main" : 0,
            "filler" : 0,
            "subtreenamehere" : 0
        ]
        
        characterMajor = "CSE" // Defaults to CSE in case the user doesn't choose
        
        characterCreated = false
        
        personalDescription = [
            "Name" : "",
            "Gender" : "",
            "Age" : "",
            "Ethnicity": "",
            "Personality": ""
        ]
        
        stats = [
            "RR": 5, //Roommate relationship CHANGE in JSON
            "H" : 10, //Health CHANGE IN JSON
            "Diligence": 0,
            "Creativity": 0,
            "Understanding": 0,
            "Charisma": 0
        ]
        saveData()
        
    }
    
    func saveData(){
        
        defaults.setValue(history, forKey: "history")
        defaults.setValue(bookmarkIndex, forKey: "bookmarkIndex")
        defaults.setValue(stats, forKey: "stats")
        defaults.setValue(personalDescription, forKey: "personalDescription")
        defaults.setValue(characterMajor, forKey: "characterMajor")
        defaults.setValue("charactermade", forKey: "characterCreated")
        defaults.setValue(experience, forKey: "experience")
        
    }
    
    func loadJSON() {
        let content = NSData(contentsOf: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("story.json"))
        
        if content != nil{
            do{
                self.jsonArray = try JSONSerialization.jsonObject(with: content! as Data, options: []) as! [[String:Any]]
            } catch {
                print("ERROR ERROR FILE NOT FOUND")
            }
        }
    }
    
    func applicationDidEnterBackground(_ application: UIApplication){
        saveData()
        
    }
    
    func applicationWillTerminate(_application : UIApplication){
        saveData()
    }
}




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
    var history = ""
    
    var experience = 0
    
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
    
    override init(){
        super.init()
        
        //Loads the default file destination for the story.json file
        let destination: DownloadRequest.DownloadFileDestination = {_, _ in
            
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("story.json")
            
            return(fileURL, [.createIntermediateDirectories])
        }
        
        //downloads and and loads json file
        Alamofire.download(url!, method: .get, to: destination).responseJSON{response in
            print(response.result)
            self.loadJSON()
        }
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
        self.currTree = self.jsonArray[1]["tree"] as! [[String:Any]]
        
    }
    
}

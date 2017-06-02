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
    
    
    var url = URL(string:"https://students.washington.edu/kpham97/Story.JSON")
    var jsonArray:[[String:Any]] = []
    var currTree:[[String:Any]] = []
    var choices:[[String:Any]] = []

    override func viewDidLoad() {
        
        let destination: DownloadRequest.DownloadFileDestination = {_, _ in
        
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("story.json")
            
            return(fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        Alamofire.download(url!, method: .get, to: destination).responseJSON{response in
            debugPrint(response)
            if let JSON = response.result.value{
                print("JSON: \(JSON)")
            }

            let content = NSData(contentsOf: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("story.json"))
            
            if content != nil{
                do{
                    self.jsonArray = try JSONSerialization.jsonObject(with: content! as Data, options: []) as! [[String:Any]]
                } catch {
                    print("ERROR ERROR FILE NOT FOUND")
                }
            }
            
            print(self.jsonArray[1]["tree"]!)
            self.currTree = self.jsonArray[1]["tree"] as! [[String:Any]]
            self.StoryTextBox.text = self.currTree[0]["text"]! as! String
            self.choices = self.currTree[0]["choices"] as! [[String:Any]]
            
            self.Choice1Button.setTitle(self.choices[0]["title"] as! String, for: UIControlState.normal)
            if self.choices.count > 2{
                self.Choice2Button.setTitle(self.choices[2]["title"] as! String, for: UIControlState.normal)
                
                if self.choices.count > 3{
                    self.Choice3Button.setTitle(self.choices[3]["title"] as! String, for: UIControlState.normal)
                }
            }
            
            
            
        }
    }
    
    
}

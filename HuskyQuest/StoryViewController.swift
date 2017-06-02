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
            
            var jsonArray:[[String:Any]] = []
            let content = NSData(contentsOf: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("story.json"))
            
            if content != nil{
                do{
                    jsonArray = try JSONSerialization.jsonObject(with: content! as Data, options: []) as! [[String:Any]]
                } catch {
                    print("ERROR ERROR FILE NOT FOUND")
                }
            }
            print(jsonArray[1]["treetype"]!)
            
            
        }
    }
    
    
}

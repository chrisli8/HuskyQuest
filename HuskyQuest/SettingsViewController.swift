//
//  SettingsViewController.swift
//  HuskyQuest
//
//  Created by studentuser on 6/5/17.
//  Copyright © 2017 Chris Li. All rights reserved.
//

import UIKit
import Alamofire

class SettingsViewController: UIViewController {

    @IBOutlet weak var updateButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func UpdateClick(_ sender: Any) {
        //Loads the default file destination for the story.json file
        let destination: DownloadRequest.DownloadFileDestination = {_, _ in
            
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("story.json")
            
            return(fileURL, [.removePreviousFile,.createIntermediateDirectories])
        }
        
        //downloads and and loads json file
        Alamofire.download(AppData.shared.url!, method: .get, to: destination).responseJSON{response in
            print(response.result)
        }
        
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

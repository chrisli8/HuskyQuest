//
//  data.defaultsViewController.swift
//  HuskyQuest
//
//  Created by studentuser on 6/5/17.
//  Copyright © 2017 Chris Li. All rights reserved.
//

import UIKit
import Alamofire

class SettingsViewController: UIViewController {
    
    var data = AppData.shared
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var autoButton: UIButton!
    @IBOutlet weak var AutoTimerText: UITextField!
    @IBOutlet weak var SaveRefreshTimer: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if data.defaults.value(forKey: "autotimer") != nil {
            AutoTimerText.text = (data.defaults.value(forKey: "autotimer") as! String)
        }
        if data.defaults.value(forKey: "savetimer") != nil {
            SaveRefreshTimer.text = (data.defaults.value(forKey: "savetimer") as! String)
        }
        
        if data.auto == false {
            autoButton.setTitle("Auto Disabled", for: UIControlState.normal)
            autoButton.backgroundColor = UIColor.gray
            data.defaults.setValue("no", forKey: "auto")
        }
        
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

    @IBAction func SaveEditted(_ sender: Any) {
        if Double(SaveRefreshTimer.text!) != nil {
            data.defaults.setValue(SaveRefreshTimer.text, forKey: "savetimer")
        }
    }

    @IBAction func TimerEditted(_ sender: Any) {
        if Double(AutoTimerText.text!) != nil {
            data.defaults.setValue(AutoTimerText.text, forKey: "autotimer")
        }
    }
    @IBAction func autoPressed(_ sender: Any) {
        data.auto = !data.auto
        if autoButton.titleLabel!.text == "Auto Enabled" {
            autoButton.setTitle("Auto Disabled", for: UIControlState.normal)
            autoButton.backgroundColor = UIColor.gray
            data.defaults.setValue("no", forKey: "auto")
        } else {
            autoButton.setTitle("Auto Enabled", for: UIControlState.normal)
            data.defaults.setValue("yes", forKey: "auto")
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

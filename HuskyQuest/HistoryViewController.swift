//
//  HistoryViewController.swift
//  HuskyQuest
//
//  Created by studentuser on 6/4/17.
//  Copyright © 2017 Chris Li. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    var historyData = AppData.shared.history
    
    @IBOutlet weak var textBox: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if historyData != "" {
            textBox.text = historyData
        } else {
            textBox.text = "Nothing has occurred in the story"
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        historyData = AppData.shared.history
        if historyData != "" {
            textBox.text = historyData
        } else {
            textBox.text = "Nothing has occurred in the story"
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

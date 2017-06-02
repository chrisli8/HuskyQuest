//
//  CharacterCreationViewController.swift
//  HuskyQuest
//
//  Created by Chris Li on 6/2/17.
//  Copyright © 2017 Chris Li. All rights reserved.
//

import UIKit

class CharacterCreationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        removePartialCurlTap();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // removes gesture for poping view and returning to main screen
    private func removePartialCurlTap() {
        if let gestures = (self.view.gestureRecognizers) {
            for gesture in gestures {
                self.view.removeGestureRecognizer(gesture)
            }
        }
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

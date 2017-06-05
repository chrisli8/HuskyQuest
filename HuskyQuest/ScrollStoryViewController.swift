//
//  ScrollStoryViewController.swift
//  HuskyQuest
//
//  Created by Chris Li on 6/4/17.
//  Copyright © 2017 Chris Li. All rights reserved.
//

import UIKit

class ScrollStoryViewController: UIViewController {
    @IBOutlet weak var story: UITextView!
    @IBOutlet weak var timerProgress: UIProgressView!
    
    // Timer fields
    var seconds = 60 // how long before time end
    var timer = Timer()
    var isTimerRunning = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        story.text = "60"
        
        self.timerProgress.layer.cornerRadius = 5.0
        self.timerProgress.clipsToBounds = true
        
        // first animation
//        self.timerProgress.progress = Float(0.0)
//        UIView.animate(withDuration: 5, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
//            self.timerProgress.setProgress(1.0, animated: true)
//        })
        
        animateInfinitelyWithDelay()
        
        // start timer
        // timer = Timer.scheduledTimer(timeInterval: 5, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Helper Methods
    
    func updateTimer() {
        // Stop timer when
        if seconds == 0 {
            timer.invalidate()
            story.text = story.text + "\nStory is over :("
        } else {
            seconds -= 5     //decrement(count down)the seconds.
            story.text = story.text + "\n" + "\(seconds)"
            
            // Make choice here
        }
    }
    
    func animateInfinitelyWithDelay() {
        self.timerProgress.progress = Float(0.0)
        NSLog("animation playing")
        UIView.animate(withDuration: 5, delay: 5, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
            self.timerProgress.setProgress(1.0, animated: true)
        }, completion: { (finished) in
            self.animateInfinitelyWithDelay()
        })
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

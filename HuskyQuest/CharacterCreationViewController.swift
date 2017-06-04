//
//  CharacterCreationViewController.swift
//  HuskyQuest
//
//  Created by Chris Li on 6/2/17.
//  Copyright © 2017 Chris Li. All rights reserved.
//

import UIKit

class CharacterCreationViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var characterPicker: UIPickerView!
    
    @IBOutlet weak var personalityLabel: UILabel!
    
    @IBOutlet weak var personalityDescription: UITextView!
    
    // Data source based on personality test
    var pickerDataSource = [["Introversion", "Extraversion"], ["Intuition", "Sensing"], ["Thinking", "Feeling"], ["Judging", "Perceiving"]];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        characterPicker.delegate = self;
        characterPicker.dataSource = self;
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
    
    // MARK: - picker delegate code
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[component][row]
    }
    
    // React to picker view select
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Convert to character array
        var personality = self.personalityLabel.text! as String
        var chars = Array(personality.characters)
        
        let choice = (pickerDataSource[component][row] as String).uppercased()
        let secondChar = choice.index(choice.startIndex, offsetBy: 1)
        let firstChar = choice.index(choice.startIndex, offsetBy: 0)
        // for intuition case
        if component == 1 && row == 0 {
            chars[component] = choice[secondChar]
        } else {
            chars[component] = choice[firstChar]
        }
        
        let label = String(chars)
        
        self.personalityLabel.text = label
        self.personalityDescription.text = AppData.shared.personalityMap[label]
    }
    
    // Takes in a personality label E.G. (ENFP) and returns a description of that type
    func getPersonalityDescription(personalityLabel: String) {
        
    }
    
    // Change font size of items in pickerview
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label: UILabel
        if let view = view as? UILabel { label = view }
        else { label = UILabel() }
        
        label.text = pickerDataSource[component][row]
        label.textAlignment = .center
        label.font = UIFont(name: "Montserrat", size: 16)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        
        return label
        
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

//
//  CharacterCreationViewController.swift
//  HuskyQuest
//
//  Created by Chris Li on 6/2/17.
//  Copyright © 2017 Chris Li. All rights reserved.
//

import UIKit

class CharacterCreationViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var characterPicker: UIPickerView!
    
    @IBOutlet weak var personalityLabel: UILabel!
    
    //@IBOutlet weak var personalityDescription: UITextView!
    @IBOutlet weak var personalityDescription: UILabel!
    
    @IBOutlet weak var nameLabel: UITextField!
    
    @IBOutlet weak var genderLabel: UITextField!
    
    @IBOutlet weak var ageLabel: UITextField!
    
    @IBOutlet weak var ethnicityLabel: UITextField!
    
    @IBOutlet weak var majorSegment: UISegmentedControl!
    
    // Data source based on personality test
    var pickerDataSource = [["Introversion", "Extraversion"], ["Intuition", "Sensing"], ["Thinking", "Feeling"], ["Judging", "Perceiving"]];
    var data = AppData.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        characterPicker.delegate = self;
        characterPicker.dataSource = self;
        loadPastData();
        // Do any additional setup after loading the view.
        self.nameLabel.delegate = self
        self.genderLabel.delegate = self
        self.ageLabel.delegate = self
        self.ethnicityLabel.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        removePartialCurlTap();
        data.characterCreated = false
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
    
    // MARK: - Helper Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    // if the map has data, populate the fields with those values so users can
    // have persiting data when they want to go back
    func loadPastData() {
        if AppData.shared.personalDescription["Name"] != "" {
            nameLabel.text = AppData.shared.personalDescription["Name"]
        }
        if AppData.shared.personalDescription["Gender"] != "" {
            genderLabel.text = AppData.shared.personalDescription["Gender"]
        }
        if AppData.shared.personalDescription["Age"] != "" {
            ageLabel.text = AppData.shared.personalDescription["Age"]
        }
        if AppData.shared.personalDescription["Ethnicity"] != "" {
            ethnicityLabel.text = AppData.shared.personalDescription["Ethnicity"]
        }
        AppData.shared.characterMajor = "CSE"
    }
    
    // Sets stats based on personality type
    func setStats(personality: String) {
        if personality != "" {
            // Analysts
            if personality == "INTJ" || personality == "INTP" ||
                personality == "ENTJ" || personality == "ENTP" {
                AppData.shared.stats["Creativity"] = 10
                AppData.shared.stats["Diligence"] = 15
                AppData.shared.stats["Understanding"] = 15
                AppData.shared.stats["Charisma"] = 0
                // Diplomats
            } else if personality == "INFJ" || personality == "INFP" ||
                personality == "ENFJ" || personality == "ENFP" {
                AppData.shared.stats["Creativity"] = 15
                AppData.shared.stats["Diligence"] = 0
                AppData.shared.stats["Understanding"] = 10
                AppData.shared.stats["Charisma"] = 15
                // Sentinels
            } else if personality == "ISTJ" || personality == "ISFJ" ||
                personality == "ESTJ" || personality == "ESFJ" {
                AppData.shared.stats["Creativity"] = 0
                AppData.shared.stats["Diligence"] = 15
                AppData.shared.stats["Understanding"] = 15
                AppData.shared.stats["Charisma"] = 10
                // Explorers
            } else if personality == "ISTP" || personality == "ISFP" ||
                personality == "ESTP" || personality == "ESFP" {
                AppData.shared.stats["Creativity"] = 15
                AppData.shared.stats["Diligence"] = 10
                AppData.shared.stats["Understanding"] = 0
                AppData.shared.stats["Charisma"] = 15
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
    
    // MARK: - Actions
    
    @IBAction func onMajorChange(_ sender: UISegmentedControl) {
        AppData.shared.characterMajor = sender.titleForSegment(at: majorSegment.selectedSegmentIndex)!
    }
    
    // MARK: - Segue
    
    // sets data to singleton when progressing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        AppData.shared.personalDescription["Name"] = nameLabel.text
        AppData.shared.personalDescription["Gender"] = genderLabel.text
        AppData.shared.personalDescription["Age"] = ageLabel.text
        AppData.shared.personalDescription["Ethnicity"] = ethnicityLabel.text
        AppData.shared.personalDescription["Personality"] = personalityLabel.text
        setStats(personality: AppData.shared.personalDescription["Personality"]!)
    }
    
    // prevents user from progressing if they haven't set their name, gender, age, ethnicity
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if identifier == "toCreateSummary" && (nameLabel.text!.isEmpty || genderLabel.text!.isEmpty || ageLabel.text!.isEmpty || ethnicityLabel.text!.isEmpty) {
            
            // Put up alert dialog
            let alertController = UIAlertController(title: "Incomplete Data", message: "Tell us about yourself", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
                // ...
            }
            alertController.addAction(cancelAction)
            
            // Other code for "ok"
//            let OKAction = UIAlertAction(title: "OK", style: .default) { action in
//                // ...
//            }
//            alertController.addAction(OKAction)
//            
            self.present(alertController, animated: true) {
                // ...
            }
            
            return false
        }
        return true
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

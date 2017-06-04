//
//  PersonalityData.swift
//  HuskyQuest
//
//  Created by Chris Li on 6/2/17.
//  Copyright © 2017 Chris Li. All rights reserved.
//


// CURRENTLY UNUSED: Making a seperate delegate class for picker is a bad choice
// becuase the picker should interacte with the view controller.

import UIKit

class PersonalityData: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // Data source based on personality test
    var pickerDataSource = [["Introversion", "Extraversion"], ["Intuition", "Sensing"], ["Thinking", "Feeling"], ["Judging", "Perceiving"]];
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    // React to picker view select
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

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

}

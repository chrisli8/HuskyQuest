//
//  PersonalityData.swift
//  HuskyQuest
//
//  Created by Chris Li on 6/2/17.
//  Copyright © 2017 Chris Li. All rights reserved.
//

import UIKit

class PersonalityData: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var pickerDataSource = [["I", "E"], ["N", "S"], ["T", "F"], ["J", "P"]];
    
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

}

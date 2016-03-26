//
//  VJDatePicker.swift
//  VJDatePicker
//
//  Created by Vinay Jain on 3/24/16.
//  Copyright © 2016 Vinay Jain. All rights reserved.
//

import UIKit

public enum VJDatePickerType : String {
    case Default
    case YearOnly
    case MonthOnly
    case DateOnly
    case YearMonth
    case MonthDate
}
@IBDesignable
class VJDatePicker: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBInspectable var Type: Int?
    
    var maxElements = Int(INT16_MAX)
    var days : Array<Int>{
        return [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
    }
    
    let months = ["January","February","March","April","May","June","July","August","September","October","November","December"]
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit(){
        delegate = self
        showsSelectionIndicator = true
        
        let currentMonth = 11
        let currentDate = 25
        let half = maxElements / 2
        let selectedMonth = half + (months.count - (half % months.count)) + currentMonth
        
        let selectedDate = half + (days.count - (half % days.count)) + currentDate
        selectRow(selectedDate - 1, inComponent: 1, animated: false)
        selectRow(selectedMonth - 1, inComponent: 0, animated: false)
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component{
        case 0:
            return months[row % months.count]
        case 1:
            return String(days[row % days.count])
        default:
            return ""
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(INT16_MAX)
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
}

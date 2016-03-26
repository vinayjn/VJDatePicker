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
    case DayOnly
    case MonthOnly
    case YearOnly
    case YearMonth
    case MonthDay
}

public class VJDateComponents {
    
    var day : Int!
    var month : Int!
    var year : Int!
    
    // The default initializer sets components from
    // current system date
    
    init(){
        let calendar = NSCalendar.currentCalendar()
        let todayComponents = calendar.components([.Day,.Month,.Year], fromDate: NSDate())
        self.day = todayComponents.day
        self.month = todayComponents.month
        self.year = todayComponents.year
    }
    
    init(day : Int, month : Int, year : Int){
        self.day = day
        self.month = month
        self.year = year
    }
}

class VJDatePicker: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var initialComponents : VJDateComponents?
    
    var minimumYearValue : Int!
    var maximumYearValue : Int!
    
    private var selectedComponents : VJDateComponents{
        return self.selectedComponents
    }
    
    var datePickerType: VJDatePickerType = .Default{
        didSet{
            reloadAllComponents()
        }
    }
    
    private var maxElements = Int(INT16_MAX)
    
    private var days : Array<Int>{
        var dayArray = Array<Int>()
        for day in 1...31{
            dayArray.append(day)
        }
        return dayArray
    }
    private let months = ["January","February","March","April","May","June","July","August","September","October","November","December"]
    
    private var years : Array<Int>{
        var yearArray = Array<Int>()
        var minYear : Int = 1970
        var maxYear : Int = 2016
        if let _ = minimumYearValue{
            minYear = minimumYearValue!
        }
        if let _ = maximumYearValue{
            maxYear = maximumYearValue!
        }
        for year in minYear...maxYear{
            yearArray.append(year)
        }
        return yearArray
    }
   
    convenience init(type: VJDatePickerType, minYear : Int, maxYear : Int){
        self.init()
        minimumYearValue = minYear
        maximumYearValue = maxYear
        datePickerType = type
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit(){
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
    
    //MARK:- UIPickerView Delegates & DataSource
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch component{
        case 0:
            return months[row % months.count]
        case 1:
            return String(days[row % days.count])
        case 2:
            return String(years[row])
        default:
            return ""
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        // For giving infinite scrolling
        switch component{
        case 0:
            return Int(INT16_MAX)
        case 1:
            return Int(INT16_MAX)
        case 2:
            return years.count
        default:
            return 0
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return getNumberOfComponentsForDatePickerType(datePickerType)
    }
    
    //MARK:- Convenience Methods 
    
    private func selectInitialValuesForDatePickerType(type: VJDatePickerType?){
        if initialComponents == nil {
            initialComponents = VJDateComponents()
        }
        
        let half = maxElements / 2
        let selectedMonth = half + (months.count - (half % months.count)) + initialComponents.month!
        let selectedDate = half + (days.count - (half % days.count)) + initialComponents.day!
        let selectedYear = years.indexOf(initialComponents.year!)
        selectRow(selectedDate - 1, inComponent: 1, animated: false)
        selectRow(selectedMonth - 1, inComponent: 0, animated: false)
        selectRow(selectedYear!, inComponent: 2, animated: false)
    }
    
    private func getNumberOfComponentsForDatePickerType(type : VJDatePickerType?)->Int{
        
        var pickerType : VJDatePickerType = .Default
        if let _ = type{
            pickerType = type!
        }
        switch pickerType{
        case .Default:
            return 3
        case .MonthDay,.YearMonth:
            return 2
        case .DayOnly,.MonthOnly,.YearOnly:
            return 1
        }
    }
    
}

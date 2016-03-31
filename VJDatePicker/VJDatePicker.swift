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
    
    var initialComponents : VJDateComponents!
    
    var minimumYearValue : Int!
    var maximumYearValue : Int!
    
    private var selectedComponents : VJDateComponents{
        return self.selectedComponents
    }
    
    var datePickerType: VJDatePickerType! = .Default
    
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
        for year in minimumYearValue...maximumYearValue{
            yearArray.append(year)
        }
        return yearArray
    }
    
    private var rows : [Int]!
    
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
        if minimumYearValue == nil{
            minimumYearValue = 1900
        }
        if maximumYearValue == nil{
            maximumYearValue = 2037
        }
        if datePickerType == nil {
            datePickerType = .Default
        }
        showsSelectionIndicator = true
        prepareRowsForVJDatePickerType(datePickerType)
        selectInitialValuesForDatePickerType(datePickerType)
    }
    
    //MARK:- UIPickerView Delegates & DataSource
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if isDayComponent(component){
            return String(days[row % days.count])
        }
        if isMonthComponent(component){
            return months[row % months.count]
        }
        if isYearComponent(component){
            return String(years[row])
        }
        return ""
    }
    
    func isDayComponent(component : Int)->Bool{
        switch datePickerType!{
        case .Default,.MonthDay:
            if component == 1 {
                return true
            }
        case .DayOnly:
            if component == 0 {
                return true
            }
        default :
            return false
        }
        return false
    }
    
    func isMonthComponent(component : Int)->Bool{
        switch datePickerType!{
        case .Default,.MonthDay,.MonthOnly:
            if component == 0 {
                return true
            }
        case .YearMonth:
            if component == 1 {
                return true
            }
        default :
            return false
        }
        return false
    }
    
    func isYearComponent(component : Int)->Bool{
        switch datePickerType! {
        case .Default:
            if component == 2 {
                return true
            }
        case .YearMonth,.YearOnly:
            if component == 0 {
                return true
            }
        default :
            return false
        }
        return false
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rows[component]
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
    
    private func getNumberOfComponentsForDatePickerType(var type : VJDatePickerType?)->Int{
        
        if type == nil{
            type = .Default
        }
        switch type!{
        case .Default:
            return 3
        case .MonthDay,.YearMonth:
            return 2
        case .DayOnly,.MonthOnly,.YearOnly:
            return 1
        }
    }
    
    func prepareRowsForVJDatePickerType(type : VJDatePickerType){
        switch type{
        case .Default:
            rows = [Int(INT16_MAX),Int(INT16_MAX),years.count]
            break
        case .DayOnly:
            rows = [Int(INT16_MAX)]
            break
        case .MonthOnly:
            rows = [Int(INT16_MAX)]
            break
        case .YearOnly:
            rows = [years.count]
            break
        case .YearMonth:
            rows = [years.count,Int(INT16_MAX)]
            break
        case .MonthDay:
            rows = [Int(INT16_MAX),Int(INT16_MAX)]
            break
        }
    }
    
}

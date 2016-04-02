//
//  ViewController.swift
//  VJDatePicker
//
//  Created by Vinay Jain on 3/24/16.
//  Copyright © 2016 Vinay Jain. All rights reserved.
//

import UIKit

class ViewController: UIViewController, VJDatePickerDelegate {
    var picker : VJDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        picker = VJDatePicker()
        view.addSubview(picker)
        picker.frame = CGRectMake(0, 0, 320, 200)
        picker.center = view.center
        picker.datePickerDelegate = self
    }
    
    @IBAction func changedDatePicker(sender: UIButton) {
        
        let type = VJDatePickerType(rawValue: (sender.titleLabel?.text)!)
        picker.datePickerType = type
    }
    
    func dateComponentsDidChange(dateComponents: VJDateComponents) {
        print(dateComponents)
    }
    
}


# VJDatePicker

A `UIPickerView` subclass which removes the limitations of `iOS` default `UIDatePicker`.

![Demo](https://raw.githubusercontent.com/vinayjn/VJDatePicker/master/images/screen.gif)


## Available types 

    enum VJDatePickerType : String {
        case all
        case dayOnly
        case monthOnly
        case yearOnly
        case yearMonth
        case monthDay
    }

## Usage

    let picker = VJDatePicker()

or 

    let picker = VJDatePicker(type: .monthOnly, minYear: 1900, maxYear: 2037)
    picker.datePickerType = .yearMonth
    picker.frame = CGRectMake(0, 300, 320, 200)
    picker.datePickerDelegate = self

Conform to `VJDatePickerDelegate` and implement the delegate method : 

    func dateComponentsDidChange(dateComponents: VJDateComponents) {
        //    print(dateComponents)
    }
    
## Requirements

- Swift 5
- Xcode 10.2 +

## License

Available under the MIT license. See the [LICENSE](https://github.com/vinayjn/VJDatePicker/blob/master/LICENSE) file for more info.

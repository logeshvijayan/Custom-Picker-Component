//
//  ViewController.swift
//  Picker Component
//
//  Created by logesh on 1/5/19.
//  Copyright © 2019 logesh. All rights reserved.
//

import UIKit

//MARK: - Class
class ViewController: UIViewController,DataPickerViewDelegate {
    func didCancel() {
        print("function has been cancelled")
    }
    
    func didSave(selectedValue: [[Any]]) {
        print(selectedValue)
    }
    
    
    
    //MARK; - Outlets and Properties
    @IBOutlet weak var pickerView : DataPickerView!
    var monthArray : [Int:Any] = [:]
    var yearArray : [Int:Any] = [:]
    var testAray: [Int:Any] = [1:"logesh" , 2: "Siva", 3 : "Ranjith" , 4 : "Bala" ,5 : "JR"]
    var ZoneArray: [Int:Any] = [1:"AM" , 2: "PM"]

    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.dataSetupforPicker()
        
    }

  
    
    
    //MARK: - Public FUnction
    func dataSetupforPicker()  {
        self.loadMonthsData()
        self.loadYearData()
        pickerView.setupData(dictionary: [monthArray,yearArray], title: "Data Picker")
    }

    func loadMonthsData()
    {
        var month = 0
        for _ in 1...12
        {
            month += 1
            monthArray.updateValue(DateFormatter().monthSymbols[month-1].capitalized, forKey: month)

        }
    }
    
    func loadYearData()
    {
        if yearArray.count == 0
        {
            var year = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.year, from: NSDate() as Date)
            for _ in 1...20
            {
                yearArray.updateValue(year, forKey: year)
                year += 1
            }
        }
    }
    
    
}


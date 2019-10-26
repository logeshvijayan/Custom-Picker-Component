//
//  DataPickerView.swift
//  Picker Component
//
//  Created by logesh on 1/5/19.
//  Copyright © 2019 logesh. All rights reserved.
//

import UIKit

protocol DataPickerViewDelegate:class {
    func didCancel()
    func didSave(selectedValue : [[Any]])
}

//  MARK: - Class
class DataPickerView:UIView{
    
    //  MARK: - Outlets
    @IBOutlet weak var contentView:UIView!
    @IBOutlet weak var pickerView:UIPickerView!
    @IBOutlet weak var cancelButton:UIButton!
    @IBOutlet weak var saveButton:UIButton!
    @IBOutlet var titleLabel: UILabel!
    
    //  MARK: - Public Properties
    weak var delegate:DataPickerViewDelegate!
    
    
    //  MARK: - Private Properties
    private var sourceDictionary = [[Int:Any]]()
    private var selectedDictionary = [[Any]]()
    private var sortedSourceValues = [[Any]]()
    private var selectedValues = [Any]()
    
    //  MARK: - Life Cycle
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.initScreen()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initScreen()
    }
    
    //  MARK: - Private Methods
    private func initScreen()
    {
        self.setupContentView()
        self.setupNavigation()
        self.setupPickerView()
    }
    
    private func setupContentView()
    {
          Bundle.main.loadNibNamed("DataPickerView", owner: self, options: nil)
          self.contentView.frame = self.bounds
          self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
          self.addSubview(contentView)
    }
    
    private func setupPickerView() {
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
    }
    
    private func setupNavigation() {
       
    }
    
    //  MARK: - Public Methods
    func setupData(dictionary : [[Int:Any]], title : String)
    {
        self.sourceDictionary = dictionary
        self.titleLabel.text = title
        for dictionary in 0...(sourceDictionary.count-1)
        {
            sortedSourceValues.append(self.sortDictionatyValues(sourceArray: sourceDictionary[dictionary]))
        }
    }
    
    
    private func sortDictionatyValues(sourceArray : [Int:Any]) -> [Any]
    {
        self.selectedValues = []
        for (_,value) in Array(sourceArray).sorted(by: {$0.0 < $1.0})
        {
            self.selectedValues.append(value)
        }
        return self.selectedValues
    }
    
    private func getKeyValue(forselectedValue value : String ,fromDictionary sourceDictionary : [Int :Any]) -> Any
    {
        for elements in sourceDictionary
        {
            if "\(value)" == "\(elements.value)"
            {
                return elements.key
            }
        }
        return (Any).self
    }    
}

//MARK: - Extension
extension DataPickerView : UIPickerViewDataSource,UIPickerViewDelegate
{
    // Mark: UIPicker Delegate / Data Source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return sourceDictionary.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return "\(sortedSourceValues[component][row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return sourceDictionary[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44.0
    }
    
    //  MARK: - Private Methods
    @IBAction func saveSelection()
    {
        selectedDictionary.removeAll()
        for index in 0...sourceDictionary.count-1
        {
            self.selectedValues = []
            selectedValues.append (self.sortedSourceValues[index][pickerView.selectedRow(inComponent: index)])
            selectedValues.append(self.getKeyValue(forselectedValue: "\(selectedValues[0])" , fromDictionary: sourceDictionary[index]))
            self.selectedDictionary.append(selectedValues)
        }
        self.delegate?.didSave(selectedValue: selectedDictionary)
    }
    
    @IBAction func cancelSelection()
    {
        self.delegate?.didCancel()
    }
    
}


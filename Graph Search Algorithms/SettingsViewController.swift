//
//  SettingsViewController.swift
//  Graph Search Algorithms
//
//  Created by Robert Canton on 2016-02-02.
//  Copyright © 2016 Robert Canton. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource
{
    var gridDelegate:GridProtocol?
    var pickerData: [String] = ["Manhattan", "Euclidean"]
    var changesMade = false
    var tempOrder = [Direction]()
    
    @IBOutlet weak var sizeSlider: UISlider!
    @IBOutlet weak var hPicker: UIPickerView!
    @IBOutlet weak var numberSwitch: UISwitch!
    @IBOutlet weak var goalSwitch: UISwitch!
    @IBOutlet weak var startSwitch: UISwitch!
    @IBOutlet weak var bothSwitch: UISwitch!
    
    @IBAction func handleDone(sender:UIBarButtonItem!)
    {
        if changesMade
        {
            let refreshAlert = UIAlertController(title: "Erase changes?", message: "All of your setting changes will be lost.", preferredStyle: UIAlertControllerStyle.Alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action: UIAlertAction!) in
                self.dismissViewControllerAnimated(true, completion: nil)
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
            
            presentViewController(refreshAlert, animated: true, completion: nil)
        }
        else
        {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func handleSave(sender:UIBarButtonItem!)
    {
        if changesMade
        {
            let refreshAlert = UIAlertController(title: "Make changes?", message: "Changing settings will erase the grid.", preferredStyle: UIAlertControllerStyle.Alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action: UIAlertAction!) in
                self.doSave()
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
            
            presentViewController(refreshAlert, animated: true, completion: nil)
        }
        else
        {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        
    }
    
    func doSave()
    {
        UserSettings.cellSizeDecimal = Double(sizeSlider.value)
        UserSettings.measurementType = hPicker.selectedRowInComponent(0)
        UserSettings.showNumberLabel = numberSwitch.on
        UserSettings.showGoalDistanceLabel = goalSwitch.on
        UserSettings.showStartDistanceLabel = startSwitch.on
        UserSettings.showBothDistanceLabel = bothSwitch.on
        
        if tempOrder.count == 4 {
            UserSettings.order = tempOrder
        }
        
        gridDelegate?.refresh()
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    @IBAction func handleSizeSlider(sender:UISlider!)
    {
        changesMade = true
    }
    @IBAction func handleNumberLabel(sender:UISwitch!)
    {
        changesMade = true
    }
    @IBAction func handleGoalLabel(sender:UISwitch!)
    {
        changesMade = true
    }
    @IBAction func handleStartLabel(sender:UISwitch!)
    {
        changesMade = true
    }
    @IBAction func handleBothLabel(sender:UISwitch!)
    {
        changesMade = true
    }
    
    @IBOutlet weak var orderLabel:UILabel!
    @IBOutlet weak var topBtn:UIBarButtonItem!
    @IBOutlet weak var rightBtn:UIBarButtonItem!
    @IBOutlet weak var bottomBtn:UIBarButtonItem!
    @IBOutlet weak var leftBtn:UIBarButtonItem!

    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        sizeSlider.value = Float(UserSettings.cellSizeDecimal)
        hPicker.selectRow(UserSettings.measurementType, inComponent: 0, animated: false)
        numberSwitch.setOn(UserSettings.showNumberLabel, animated: false)
        goalSwitch.setOn(UserSettings.showGoalDistanceLabel, animated: false)
        startSwitch.setOn(UserSettings.showStartDistanceLabel, animated: false)
        bothSwitch.setOn(UserSettings.showBothDistanceLabel, animated: false)
        changesMade = false
        
        topBtn.enabled = true
        rightBtn.enabled = true
        bottomBtn.enabled = true
        leftBtn.enabled = true
        tempOrder = []
        
        populateOrderLabel(UserSettings.order)
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        changesMade = true
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    
    
    @IBAction func handleTopBtn(sender:UIBarButtonItem!)
    {
        changesMade = true
        sender.enabled = false
        tempOrder.append(Direction.Top)
        populateOrderLabel(tempOrder)
    }
    @IBAction func handleRightBtn(sender:UIBarButtonItem!)
    {
        changesMade = true
        sender.enabled = false
        tempOrder.append(Direction.Right)
        populateOrderLabel(tempOrder)
    }
    @IBAction func handleBottomBtn(sender:UIBarButtonItem!)
    {
        changesMade = true
        sender.enabled = false
        tempOrder.append(Direction.Bottom)
        populateOrderLabel(tempOrder)
    }
    @IBAction func handleLeftBtn(sender:UIBarButtonItem!)
    {
        changesMade = true
        sender.enabled = false
        tempOrder.append(Direction.Left)
        populateOrderLabel(tempOrder)
    }
    
    func populateOrderLabel(order:[Direction])
    {
        orderLabel.text = ""
        for i in 0 ... order.count - 1
        {
            let dir = order[i]
            var dirStr = ""
            switch dir
            {
            case .Top:
                dirStr = "Top"
                break
            case .Right:
                dirStr = "Right"
                break
            case .Bottom:
                dirStr = "Bottom"
                break
            case .Left:
                dirStr = "Left"
                break
            }
            var str = " \(dirStr),"
            if i == order.count - 1
            {
                str = " \(dirStr)"
            }
            orderLabel.text?.appendContentsOf(str)
        }
    }
    
    @IBAction func handleEmailRequest(sender:UIBarButtonItem!)
    {
        let email = "robshanecanton@gmail.com"
        let url = NSURL(string: "mailto:\(email)")
        UIApplication.sharedApplication().openURL(url!)
    }
    @IBAction func handleWebRequest(sender:UIBarButtonItem!)
    {
        let url  = NSURL(string: "http://www.rcanton.com"); // Change the URL with your URL Scheme
        if UIApplication.sharedApplication().canOpenURL(url!) == true
        {
            UIApplication.sharedApplication().openURL(url!)
        }
    }
    @IBAction func handleLinkedInRequest(sender:UIBarButtonItem!)
    {
        let url  = NSURL(string: "https://ca.linkedin.com/in/rcanton"); // Change the URL with your URL Scheme
        if UIApplication.sharedApplication().canOpenURL(url!) == true
        {
            UIApplication.sharedApplication().openURL(url!)
        }
    }
    @IBAction func handleGitHubRequest(sender:UIBarButtonItem!)
    {
        let url  = NSURL(string: "https://github.com/RobCanton"); // Change the URL with your URL Scheme
        if UIApplication.sharedApplication().canOpenURL(url!) == true
        {
            UIApplication.sharedApplication().openURL(url!)
        }
    }
    
    @IBAction func handleLinkButton(sender:UIButton!)
    {
        let url  = NSURL(string: sender.titleLabel!.text!); // Change the URL with your URL Scheme
        if UIApplication.sharedApplication().canOpenURL(url!) == true
        {
            UIApplication.sharedApplication().openURL(url!)
        }
    }
    
    

    
    
 
}

 

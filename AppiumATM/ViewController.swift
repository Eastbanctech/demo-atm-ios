//
//  ViewController.swift
//  AppiumATM
//
//  Created by Kirill Butin on 2/3/15.
//  Copyright (c) 2015 EastBanc Technologies. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var accountTypePicker: UIPickerView!
    @IBOutlet weak var amount: UITextField!
    
    var balance: [Int]!
    var accounts: [String]!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        accountTypePicker.delegate = self
        accountTypePicker.dataSource = self
        accounts = ["Checking account", "Savings account"]
        balance = [5000, 100]
        balanceLabel.text =  String(balance[0])
    }

    
    @IBAction func getCashPressed(sender: AnyObject) {
        if (amount.text.toInt() == nil) {  return } // just ignore if nothing in the amount field
        
        let currentBallance = balance[accountTypePicker.selectedRowInComponent(0)] - amount.text.toInt()!
        
        if (currentBallance >= 0){
            balance[accountTypePicker.selectedRowInComponent(0)] = currentBallance
            balanceLabel.text = String(currentBallance)
            
            var alert = UIAlertController(title: nil, message: "Please take your money from the dispenser", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }else{
            var alert = UIAlertController(title: "Error", message: "Insufficient funds", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Destructive, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        amount.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return accounts[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        balanceLabel.text = String(balance[row])
    }

    
}


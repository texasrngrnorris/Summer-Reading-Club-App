//
//  ViewController.swift
//  Summer Reading Club App
//
//  Created by Alex Boris on 4/8/19.
//  Copyright © 2019 Sachem Public Library. All rights reserved.
//

import UIKit

var patronArray = [Patron]()
class ViewController: UIViewController {

    
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var registerSwitch: UISwitch!
    var registered : String = "Is not registered for the Summer Reading Program"
    @IBAction func buttonClicked(_ sender: Any) {
        if registerSwitch.isOn {
            registered = "Is registered for the Summer Reading Program"
            registerSwitch.setOn(true, animated:true)
        }
        else {
            registered = "Is not registered for the Summer Reading Program"
            registerSwitch.setOn(false, animated:true)
        }
    }
    
    @objc func timeLabel()
    {
        let dateLabel = Date()
        let labelOutput = DateFormatter()
        labelOutput.locale = Locale(identifier:"en_US")
        labelOutput.dateFormat = "h:mm:ss a"
        currentTimeLabel.text = labelOutput.string(from: dateLabel)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.timeLabel), userInfo: nil, repeats: true)
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    @IBAction func loginAttempt(_ sender: Any) {
        
        if validate(value: phoneNumber.text!) == false
        {
            let alertController = UIAlertController(title: "Invalid Phone!", message: "Value must be a valid phone number (123-456-7890).",preferredStyle: UIAlertController.Style.alert)
            
            alertController.addAction(UIAlertAction(title:"OK",style: UIAlertAction.Style.default,handler:nil))
            
            self.present(alertController,animated: true, completion: nil)
        }
    
            
        else
        {
        patronArray = Patron.loadPatronsFromDefaults()
        let date = Date()
        let timeOutput = DateFormatter()
        let dateOutputFormat = DateFormatter()
        let totalDate = DateFormatter()
        dateOutputFormat.locale = Locale(identifier: "en_US")
        timeOutput.locale = Locale(identifier:"en_US")
        dateOutputFormat.dateFormat = "EEEE,MMMM dd"
        timeOutput.dateFormat = "h:mm:ss a"
        totalDate.dateFormat = "EEEE, MMMM dd, YYYY h:mm:ss a"
        let tempFirst = firstName.text
        let tempLast = lastName.text
        let tempPhone = phoneNumber.text
        //Make sure string isnt empty or whitepaces
        if tempFirst?.replacingOccurrences(of: " ", with: "") != "" && tempLast?.replacingOccurrences(of: " ", with: "") != "" && tempPhone?.replacingOccurrences(of: " ", with: "") != ""
            {
                let patron = Patron(firstName: firstName.text!, lastName: lastName.text!, phoneNumber: phoneNumber.text!, isRegistered: registered.self, signInTime: totalDate.string(from: date))
            patronArray.append(patron)
            firstName.text = ""
            lastName.text = ""
            phoneNumber.text = ""
            registerSwitch.setOn(false, animated: true)
            Patron.savePatronsToDefaults()
            print(patronArray.count)
            
            let alertController = UIAlertController(title: "Successfully Registered!", message: "Thank you, "+patron.firstName!+" "+patron.lastName!,preferredStyle: UIAlertController.Style.alert)
            
            alertController.addAction(UIAlertAction(title:"OK",style: UIAlertAction.Style.default,handler:nil))
            
            self.present(alertController,animated: true, completion: nil)
            
            }
        else
            {
            let alertController = UIAlertController(title: "Login Failure!", message: "First Name,Last Name AND phone number must be filled out.",preferredStyle: UIAlertController.Style.alert)
            
            alertController.addAction(UIAlertAction(title:"OK",style: UIAlertAction.Style.default,handler:nil))
            
            self.present(alertController,animated: true, completion: nil)
            
            }
        
        }
    }
}

//Date Builder
extension Date
{
    func toTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm:ss a"
        return dateFormatter.string(from: self)
    }
}

func validate(value: String) -> Bool {
    let PHONE_REGEX = "^\\d{3}-?\\d{3}-?\\d{4}$"
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
    let result =  phoneTest.evaluate(with: value)
    return result
}

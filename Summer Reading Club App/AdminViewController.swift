//
//  AdminViewController.swift
//  DesTeenation Signin
//
//  Created by Sachem Library on 6/28/17.
//  Copyright © 2017 Sachem Library. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class AdminViewController : UIViewController, UITextFieldDelegate, MFMailComposeViewControllerDelegate{
    

    
    let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    let file = "sessionData.csv" //csv file to write to
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    @IBAction func exportLogins(_ sender: Any)
    {
        
        let path = dir?.appendingPathComponent(file)
        let data = writeSessionDataToString()
        
        //writing
        do {
            try data.write(to: path!, atomically: false, encoding: String.Encoding.utf8)
        }
        catch {/* error handling here */}
        
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        }
        else{
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            
            // Configure the fields of the interface.
            composeVC.setToRecipients(["christine.latham@sachemlibrary.org"])
            composeVC.setSubject("Patron Raffle Entries")
            composeVC.setMessageBody("Patorn raffle entries CSV file is attached.", isHTML: false)
            let fileLocationForLoad = URL(fileURLWithPath: file, relativeTo: dir)
            let fileData =  NSData(contentsOf: fileLocationForLoad)
            composeVC.addAttachmentData(fileData! as Data, mimeType: "csv", fileName: "RaffleEntries.csv")
            
            
            // Present the view controller modally.
            self.present(composeVC, animated: true, completion: nil)
        }
    }
    
    func writeSessionDataToString() -> String{
        //loop to access each teen
        var fileData = ""
        for patron in patronArray{
            fileData += patron.firstName!
            fileData += "   "
            fileData += patron.lastName!
            fileData += "   "
            fileData += patron.phoneNumber!
            fileData += "   "
            fileData += patron.isRegistered
            fileData += "   "
            fileData += patron.signInTime!
            fileData = fileData + "\n"
        }
        return fileData
    }
    
    @IBAction func selectRandomPatron(){
        var winners = ""
        if patronArray.count == 0
        {
            let alertController = UIAlertController(title: "Warning!", message: "There have been no entries, a winner cannot be selected",preferredStyle: UIAlertController.Style.alert)
            
            alertController.addAction(UIAlertAction(title:"OK",style: UIAlertAction.Style.default,handler:nil))
            
            self.present(alertController,animated: true, completion: nil)
        }
        else
        {
            let tempWinner = patronArray.randomElement()
            winners += tempWinner!.firstName!
            winners += "\n"
            winners += tempWinner!.lastName!
            winners += "\n"
            winners += tempWinner!.phoneNumber!
            winners += "\n"
            let alertController = UIAlertController(title: "Winner found!", message: "The winner is: " + winners,preferredStyle: UIAlertController.Style.alert)
            
            alertController.addAction(UIAlertAction(title:"OK",style: UIAlertAction.Style.default,handler:nil))
            
            self.present(alertController,animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result {
        case .cancelled:
            break
        case .saved:
            break
        case .sent:
            break
        case .failed:
            break
            
        @unknown default: break
            
        }
        
        controller.dismiss(animated: true, completion: nil)            }
    
    
    
    //Delete Registration Data
    @IBAction func deleteLogins(_ sender: Any) {
        let alertController = UIAlertController(title: "Delete all registration data?", message: "Are you sure?",preferredStyle: UIAlertController.Style.alert)
        
        
        alertController.addAction(UIAlertAction(title: "YES", style: .default, handler: { (action: UIAlertAction!) in
            patronArray.removeAll()
            Patron.savePatronsToDefaults()
        }))
        alertController.addAction(UIAlertAction(title: "NO", style: .default, handler: { (action: UIAlertAction!) in
            Patron.savePatronsToDefaults()
        }))
        self.present(alertController,animated: true, completion: nil)
    }
    
    
}

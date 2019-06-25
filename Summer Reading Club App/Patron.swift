//
//  ViewController.swift
//  Summer Reading Club App
//
//  Created by Alex Boris on 4/8/19.
//  Copyright © 2019 Sachem Public Library. All rights reserved.
//

import Foundation
import os.log


class Patron : NSObject,NSCoding

{
    //Declare Values
    var firstName : String?
    var lastName  : String?
    var phoneNumber : String?
    var isRegistered: String
    var signInTime : String?
    
    //Init values
    init(firstName: String, lastName: String, phoneNumber: String, isRegistered: String, signInTime: String){
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.isRegistered = isRegistered
        self.signInTime = signInTime
    }
    
    //Decode Data from Defaults
    required init?(coder aDecoder: NSCoder)
    {
        self.firstName = aDecoder.decodeObject(forKey: "firstName") as? String ?? ""
        self.lastName = aDecoder.decodeObject(forKey: "lastName") as? String ?? ""
        self.phoneNumber = aDecoder.decodeObject(forKey: "phoneNumber") as? String ?? ""
        self.isRegistered = aDecoder.decodeObject(forKey: "isRegistered") as? String ?? ""
        self.signInTime = aDecoder.decodeObject(forKey: "signInTime") as? String ?? ""
    }
    
    //Encode Data
    func encode(with aCoder: NSCoder) {
        aCoder.encode(firstName, forKey: "firstName")
        aCoder.encode(lastName, forKey: "lastName")
        aCoder.encode(phoneNumber, forKey: "phoneNumber")
        aCoder.encode(isRegistered, forKey: "isRegistered")
        aCoder.encode(signInTime,forKey: "signInTime")
    }
    
    //Load encoded data
    class func loadPatronsFromDefaults() -> [Patron]
    {
        guard let data = UserDefaults.standard.data(forKey: "patron"),
            let loadedPatronsFromDefaults = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as? [Patron]
            else{
                return []
        }
        return loadedPatronsFromDefaults

    }
    
    //Save encoded data
    class func savePatronsToDefaults()
    {
        let userDefaults = UserDefaults.standard
        
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: patronArray)
        userDefaults.set(encodedData, forKey: "patron")
        userDefaults.synchronize()
    }
    
}

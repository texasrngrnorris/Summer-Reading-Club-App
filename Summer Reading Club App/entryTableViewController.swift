//
//  LoginTableViewController.swift
//  DesTeenation Signin
//
//  Created by Sachem Library on 6/28/17.
//  Copyright © 2017 Sachem Library. All rights reserved.
//

import Foundation
import UIKit

class entryTableViewController : UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    let tableData = Patron.loadPatronsFromDefaults()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell()
        cell.textLabel?.text = (tableData[indexPath.item].firstName)! + " " + (tableData[indexPath.item].lastName)! + " " + (tableData[indexPath.item].phoneNumber)! + " " + (tableData[indexPath.item].isRegistered) + " " + (tableData[indexPath.item].signInTime)!
        return cell
    }
    
    
}

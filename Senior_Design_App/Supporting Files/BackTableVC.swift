//
//  BackTableVc.swift
//  Senior_Design_App
//
//  Created by Zifan Wang on 4/20/18.
//  Copyright © 2018 Zifan Wang. All rights reserved.
//

import Foundation

class BackTableVC: UITableViewController {
    var TableArray = [String]()
    
    override func viewDidLoad() {
        TableArray = ["Temperature","Humidity","Illumination Level","Human Activation","Light Controller"]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "propertiesCell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = TableArray[indexPath.row]
        
        return cell
    }
}

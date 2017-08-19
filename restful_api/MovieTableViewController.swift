//
//  MovieTableViewController.swift
//  restful_api
//
//  Created by railsbridge on 8/19/17.
//  Copyright © 2017 railsbridge. All rights reserved.
//

import UIKit

class MovieTableViewController : UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("view loaded")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieTableViewCell
        
        cell.titleLabel.text = "I am movie #\(indexPath.row)"

        //cell.textLabel?.text = "I am cell \(indexPath.row)"
        
        return cell
    }
}

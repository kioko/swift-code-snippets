//
//  ViewController.swift
//  PullToRefresh
//
//  Created by Kioko on 03/04/2016.
//  Copyright © 2016 Thomas Kioko. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var alphabet = ["A","B","C","D","E","F","G","H","I"]
    
    override func viewDidLoad() {
        
        //Pull to refresh
        let refreshControl = UIRefreshControl()
        
        //Call sortArray when pull to refresh is started
        refreshControl.addTarget(self, action: #selector(ViewController.sortArray), forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return alphabet.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = alphabet[indexPath.row]
        return cell
    }
    
    func sortArray() {
        let sortedAlphabet = alphabet.reverse()
        
        for (index, element) in sortedAlphabet.enumerate() {
            alphabet[index] = element
        }
        
        //Reload the data in the table view.
        tableView.reloadData()
        
        //end refresh action
        refreshControl?.endRefreshing()
    }
    
    
}



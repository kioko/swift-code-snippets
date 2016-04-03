//
//  ViewController.swift
//  TableViewSearch
//
//  Created by Kioko on 03/04/2016.
//  Copyright © 2016 Thomas Kioko. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift

class ViewController: UITableViewController, UISearchResultsUpdating {
    
    let tableData = ["Tripple 9","Dead Pool","Ice Age","Point Break", "Heist", "Batman vs Superman",
                     "Captain America", "Mad Max", "Civil War", "Minions", "Ant Man", "Big Hero",
                     "Avengers", "X-Men", "Fury", "Thor", "Pixels", "Maze Runner",
                     "Man Of Steel", "Pitch Perfect", "Martix", "American Sniper", "Iron Man",
                     "Mall Cop", "Hangover", "Terminator", "Interstellar"]
    
    var filteredTableData = [String]()
    
    //Search Controller
    var resultSearchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            //Style searchbar
            controller.searchBar.barTintColor = UIColor(rgba: "#ff9900")
        
            //Add the searchBar as a header to the tableView
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        // Reload the table
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // 1
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 2
        if (self.resultSearchController.active) {
            return self.filteredTableData.count
        }
        else {
            return self.tableData.count
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        // 3
        if (self.resultSearchController.active) {
            cell.textLabel?.text = filteredTableData[indexPath.row]
            
            return cell
        }
        else {
            cell.textLabel?.text = tableData[indexPath.row]
            
            return cell
        }
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        filteredTableData.removeAll(keepCapacity: false)
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (tableData as NSArray).filteredArrayUsingPredicate(searchPredicate)
        filteredTableData = array as! [String]
        
        self.tableView.reloadData()
    }
    
    
}


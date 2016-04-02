//
//  TableViewController.swift
//  LocationDemo
//
//  This class loads uses saved places in a table view.
//
//
//  Created by Kioko on 02/04/2016.
//  Copyright © 2016 Thomas Kioko. All rights reserved.
//

import UIKit

//Declare a dictionary array to hold latitude, longitude and description.
var places = [Dictionary<String,String>()]

var activePlace = -1

class TableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Check if places is empty. If true, set a default location
        if places.count == 1 {
            //Add data to the TableView
            places.removeAtIndex(0)
            places.append(["name":"Taj Mahal","lat":"27.175277","lon":"78.042128"])
        }
    }
    
    //Reload the table.
    override func viewDidAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return places.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        //Set the name of the textView to the name value in the dictionary
        cell.textLabel?.text =  places[indexPath.row]["name"]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        //Set the active place to the selected item on the table view
        activePlace = indexPath.row
        return indexPath
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //This will allow us to center the mapview when the user adds a new location.
        if segue.identifier == "newPlace" {
            activePlace = -1
        }
    }
    
}


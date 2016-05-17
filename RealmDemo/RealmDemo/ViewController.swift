//
//  ViewController.swift
//  RealmDemo
//
//  Created by Kioko on 16/05/2016.
//  Copyright © 2016 Thomas Kioko. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class ViewController: UITableViewController {
    
    
    let realm = try! Realm()
    lazy var todos: Results<ToDoItem> = { self.realm.objects(ToDoItem) }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "CellIdentifier")
        
        //If count == 0 the database is empty
        if todos.count == 0 {
            
            //Start a Realm transaction
            try! realm.write() {
                
                //Create a list of items
                let defaultCategories = ["Buy Milk", "Update Code", "Send Email", "Download Movies", "Buy tickets" ]
                
                //loop through the list creating a new instance and adding it to the DB
                for todoItem in defaultCategories {
                    let newTodoItem = ToDoItem()
                    newTodoItem.name = todoItem
                    self.realm.add(newTodoItem)
                }
            }
            
            //Fetch all the Items
            todos = realm.objects(ToDoItem)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(todos.count)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath) as UITableViewCell
        
        let todoItem = todos[indexPath.row]
        cell.textLabel!.text = todoItem.name // [5]
        
        return cell
    }
    
    
}


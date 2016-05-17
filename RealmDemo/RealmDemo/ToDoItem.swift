//
//  ToDoItem.swift
//  RealmDemo
//
//  Created by Kioko on 16/05/2016.
//  Copyright © 2016 Thomas Kioko. All rights reserved.
//

import RealmSwift
import Realm

class ToDoItem: Object {
    /**
     * Every property that should be fetched and stored in the database also needs the dynamic keyword
     */
    dynamic var name = ""
    dynamic var finished = false
}

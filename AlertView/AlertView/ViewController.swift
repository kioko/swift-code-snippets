//
//  ViewController.swift
//  AlertView
//
//  Created by Kioko on 20/04/2016.
//  Copyright © 2016 Thomas Kioko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Add action to button. It creates an alertView when clicked.
    @IBAction func showAlertAction(sender: AnyObject) {
        let alertController = UIAlertController(title: "Swift Alert.", message:
            "Warning... Swift is awesome... ...!", preferredStyle: UIAlertControllerStyle.Alert)
        
        //Add dismiss/cancel button to the alertview
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        //present the alert dialog and show animation
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}


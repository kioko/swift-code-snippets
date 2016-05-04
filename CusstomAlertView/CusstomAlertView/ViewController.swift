//
//  ViewController.swift
//  CusstomAlertView
//
//  Created by Kioko on 04/05/2016.
//  Copyright © 2016 Thomas Kioko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var usernameTextField: UITextField?
    var passwordTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Button Action
    @IBAction func showAlertDialog(sender: AnyObject) {
        
        let alertController = UIAlertController(
            title: "Log in",
            message: "Please enter your credentials",
            preferredStyle: UIAlertControllerStyle.Alert)
        
        //Create button action. This Action prints users input in the console.
        let loginAction = UIAlertAction(
        title: "Log in", style: UIAlertActionStyle.Default) {
            (action) -> Void in
            
            if let username = self.usernameTextField?.text {
                print(" Username = \(username)")
            } else {
                print("No Username entered")
            }
            
            if let password = self.passwordTextField?.text {
                print("Password = \(password)")
            } else {
                print("No password entered")
            }
        }
        
        //Add UserName TextField to AlertController
        alertController.addTextFieldWithConfigurationHandler {
            (txtUsername) -> Void in
            self.usernameTextField = txtUsername
            //Set placeholder text
            self.usernameTextField!.placeholder = "Enter userName"
            //Style the edit text
            let paddingView = UIView(frame: CGRectMake(15, 15, 15, self.usernameTextField!.frame.height))
            self.usernameTextField!.leftView = paddingView
        }
        
        //Add password textField to AlertController
        alertController.addTextFieldWithConfigurationHandler {
            (txtPassword) -> Void in
            self.passwordTextField = txtPassword
            self.passwordTextField!.secureTextEntry = true
            //Set placeholder text
            self.passwordTextField!.placeholder = "Enter Password"
            //Style the edit text
            let paddingView = UIView(frame: CGRectMake(15, 15, 15, self.passwordTextField!.frame.height))
            self.passwordTextField!.leftView = paddingView
        }
        
        //add action to AlertController
        alertController.addAction(loginAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
}


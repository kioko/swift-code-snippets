//
//  ViewController.swift
//  CircularImageView
//
//  Created by Kioko on 07/04/2016.
//  Copyright © 2016 Thomas Kioko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Style the profile picture
        styleProfilePucture(profileImageView)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //This method is used to style an ImageView
    func styleProfilePucture(profileImageView: UIImageView){
        
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.borderColor = UIColor.whiteColor().CGColor
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius  = CGFloat(roundf(Float(profileImageView.frame.size.width/2.3)))
        profileImageView.layer.borderWidth = 5;
        
    }

}


//
//  ViewController.swift
//  Activity Indicator
//
//  Created by Kioko on 31/03/2016.
//  Copyright © 2016 Thomas Kioko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Create and add the view to the screen.
        let progressHUD = ProgressHUD(text: "Loading ...")
        self.view.addSubview(progressHUD)
        progressHUD.layer.zPosition = 1; //Bring the view to the front
        // All done!
        
        progressHUD.show()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}



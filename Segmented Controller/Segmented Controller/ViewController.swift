//
//  ViewController.swift
//  Segmented Controller
//
//  Created by Kioko on 30/03/2016.
//  Copyright © 2016 Thomas Kioko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var segmentContoller: UISegmentedControl!
    @IBOutlet weak var topListUIView: UIView!
    @IBOutlet weak var upcomingUIView: UIView!
    @IBOutlet weak var genresUIView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topListUIView.hidden = false
        upcomingUIView.hidden = true
        genresUIView.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func segmentIndexChangedAction(sender: UISegmentedControl) {
        
        switch segmentContoller.selectedSegmentIndex{
        case 0:
            topListUIView.hidden = false
            upcomingUIView.hidden = true
            genresUIView.hidden = true
        case 1:
            topListUIView.hidden = true
            upcomingUIView.hidden = false
            genresUIView.hidden = true
        case 2:
            topListUIView.hidden = true
            upcomingUIView.hidden = true
            genresUIView.hidden = false
        default:
            break;
        
        }
    }

}


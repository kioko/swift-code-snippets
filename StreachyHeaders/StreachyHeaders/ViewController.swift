//
//  ViewController.swift
//  StreachyHeaders
//
//  Created by Kioko on 29/03/2016.
//  Copyright © 2016 Thomas Kioko. All rights reserved.
//

import UIKit

class ViewController: UITableViewController{
    
    var headerView: UIView!
    var headerMaskLayer: CAShapeLayer!
    private let kTableHeaderCutAway : CGFloat = 60
    private let kTableHeaderHeight : CGFloat = 300
    
    // create an array called items that houses NewsItem
    let items = [
        NewsItem(category: .World, summary: "Amateur Rowers Celebrate Record-Setting Atlantic Voyage"),
        NewsItem(category: .Europe, summary: "600-Year-Old Library Offers Glimpse of 'World's Mind'"),
        NewsItem(category: .Africa, summary: "Watch Cute Koala Stop Traffic Along Highway"),
        NewsItem(category: .Americas, summary: "Brussels Attacks 'Suspect' Freed Due to Lack of Evidence"),
        NewsItem(category: .MiddleEast, summary: "Hostage Standoff Ends With Hijacker Arrested"),
        NewsItem(category: .AsiaPacific, summary: "Why the Global Rent-a-Womb Industry Is Starting to Crumble"),
        NewsItem(category: .Europe, summary: "North Korea Tells Citizens To Prepare Themselves For Famine"),
        NewsItem(category: .MiddleEast, summary: "U$1bn poured so rapidly into Malaysian PM's personal bank accounts that it rang money-laundering alarms"),
        NewsItem(category: .Africa, summary: "The politicians voting to impeach Brazil's president are accused of more corruption than she is")
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.rowHeight = UITableViewAutomaticDimension
        
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        
        let effectiveHeight = kTableHeaderHeight-kTableHeaderCutAway/2
        tableView.contentInset = UIEdgeInsets(top: effectiveHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -effectiveHeight)
        
        
        headerMaskLayer = CAShapeLayer()
        headerMaskLayer.fillColor = UIColor.blackColor().CGColor
        
        headerView.layer.mask = headerMaskLayer
        
        updateHeaderView()
        
    }
    
    func updateHeaderView(){
        
        let effectiveHeight = kTableHeaderHeight-kTableHeaderCutAway/2
        var headerRect = CGRect(x: 0, y: -effectiveHeight, width: tableView.bounds.width, height: kTableHeaderHeight)
        
        if tableView.contentOffset.y < -effectiveHeight{
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y + kTableHeaderCutAway/2
        }
        
        headerView.frame = headerRect
        
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0, y: 0))
        path.addLineToPoint(CGPoint(x: headerRect.width, y: 0))
        path.addLineToPoint(CGPoint(x: headerRect.width, y: headerRect.height))
        path.addLineToPoint(CGPoint(x: 0, y: headerRect.height-kTableHeaderCutAway))
        
        headerMaskLayer?.path = path.CGPath
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderView()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //We return true in prefersStatusBarHidden() to make the status bar hidden when
    //the view controller appears on the screen:
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    //configure the table view's data source to tell the table view how to display its contents.
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    //Have the table view use the prototype table view cell with the identifier Cell from the storyboard
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! NewsItemCell
        cell.newsItem = item
        
        return cell
    }
    
}


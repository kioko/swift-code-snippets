//
//  ViewController.swift
//  CollectionViewDemo
//  
//  This view controller allows there user to search for images and displays them
//  in a collection view.
//
//  Created by Kioko on 05/04/2016.
//  Copyright © 2016 Thomas Kioko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate,  UICollectionViewDataSource, UISearchBarDelegate, FlickrApiDelegate {
    
    var pullTorefresh : UIRefreshControl!
    var progressHUD : ProgressHUD!
    
    @IBOutlet weak var cellCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    private var searches = [FlickrSearchResults]()
    lazy var apiController : FlickrApi = FlickrApi(flickrDelegate : self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.apiController.flickrDelegate = self
        
        cellCollectionView.delegate = self
        cellCollectionView.dataSource = self
        
        cellCollectionView?.alwaysBounceVertical = true
        
        //set the backGround color of the collection view
        cellCollectionView?.backgroundColor = .whiteColor()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.gestureTapInView(_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        searchBar.delegate = self
        
        //Style the searchBar place holder text.
        let searchTextField: UITextField? = searchBar.valueForKey("searchField") as? UITextField
        if searchTextField!.respondsToSelector(Selector("attributedPlaceholder")) {
            let attributeDict = [NSForegroundColorAttributeName: UIColor.whiteColor()]
            searchTextField!.attributedPlaceholder = NSAttributedString(string: "Search", attributes: attributeDict)
        }
        
        
        //Add pull to refresh to the view
        pullTorefresh = UIRefreshControl()
        pullTorefresh.addTarget(self, action: #selector(ViewController.refresh), forControlEvents: UIControlEvents.ValueChanged)
        
        //Add pullToRefresh to the collectionView
        cellCollectionView?.addSubview(pullTorefresh)
        
        // Create and add the view to the screen.
        progressHUD = ProgressHUD(text: "Loading ...")
        self.view.addSubview(progressHUD)
        progressHUD.layer.zPosition = 1; //Bring the view to the front
        progressHUD.hide()
        
    }
    
    //Called when the user clicks the search button
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        //hide the keyboard when the user clicks search
        searchBar.resignFirstResponder()
        
        progressHUD.show()
        
        //Invoke searchImbd method and pass the search query
        self.apiController.searchFlickr(searchBar.text!) {
            results, error in
            
            if error != nil {
                print("Error searching : \(error)")
            }
            
            if results != nil {
                //Clear data from the array
                self.searches.removeAll()
                
                //clear the text
                searchBar.text = ""
                
                self.searches.insert(results!, atIndex: 0)
                
                //Reload the view
                self.cellCollectionView?.reloadData()
            }
           
            //Hide the activity indicator
            self.progressHUD.hide()
        }
    }
    
    //Hide keyboard when the user taps outside
    func gestureTapInView(gesture : UITapGestureRecognizer){
        self.searchBar.resignFirstResponder()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UICollectionViewDelegateFlowLayout delegate method
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        let cellSpacing = CGFloat(1) //Define the space between each cell
        let leftRightMargin = CGFloat(0) //If defined in Interface Builder for "Section Insets"
        let numColumns = CGFloat(3) //The total number of columns you want
        
        let totalCellSpace = cellSpacing * (numColumns - 1)
        let screenWidth = UIScreen.mainScreen().bounds.width
        let width = (screenWidth - leftRightMargin - totalCellSpace) / numColumns
        let height = CGFloat(120) //whatever height you want
        
        return CGSizeMake(width, height);
    }
    
    
    //This function is called when the user pulls down the view and data is reloaded.
    func refresh(){
        //Reload the data
        self.cellCollectionView?.reloadData()
        
        //Stop the refesh action
        pullTorefresh.endRefreshing()
    }
    
    func photoForIndexPath(indexPath: NSIndexPath) -> FlickrPhoto {
        return searches[indexPath.section].searchResults[indexPath.row]
    }
    
    //Return the number of items in the array
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return searches.count
    }
    

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searches[section].searchResults.count
    }
    
    //Configure the cell.
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //1
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! PhotoCollectionViewCell
        
        //Get the item per index.
        let flickrPhoto = photoForIndexPath(indexPath)
        cell.backgroundColor = UIColor.lightGrayColor() //Set the background color of the cell
        // Load the image to the imageView.
        cell.photoImageView.image = flickrPhoto.largeImage
        
        return cell
    }
    
    
    func didFinishSearch(jsonResult: NSDictionary) {
        //TODO:: Check for the response status and return the correct response
    }
    
}



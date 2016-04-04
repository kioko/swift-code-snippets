//
//  ViewController.swift
//  JsonParsing
//
//  Created by Kioko on 04/04/2016.
//  Copyright © 2016 Thomas Kioko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ImdbApiControllerDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var backGroundView: UIView!
    
    //Lable outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tomatoeRating: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    
    lazy var apiController : ImdbApi = ImdbApi(imdbDelegate : self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.apiController.imdbDelegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.gestureTapInView(_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        searchBar.delegate = self
        
        //set backgroudn color
        self.backGroundView.backgroundColor = UIColor(red: 0.988, green: 0.725,
                                                      blue: 0.200, alpha: 1.0)
        
        self.formatLabels(true)
        
        //Style the searchBar place holder text.
        let searchTextField: UITextField? = searchBar.valueForKey("searchField") as? UITextField
        if searchTextField!.respondsToSelector(Selector("attributedPlaceholder")) {
            let attributeDict = [NSForegroundColorAttributeName: UIColor.whiteColor()]
            searchTextField!.attributedPlaceholder = NSAttributedString(string: "Enter Movie Title", attributes: attributeDict)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /**
     Format the lable, change visibility and font style
     */
    func formatLabels(firstLaunch : Bool){
        
        let labelsArray = [self.titleLabel, self.ratingLabel, self.releaseDateLabel,
                           self.plotLabel, self.tomatoeRating]
        
        if firstLaunch{
            for label in labelsArray{
                label.text = ""
            }
        }
        
        for label in labelsArray{
            label.textAlignment = .Center
            
            switch label{
            case self.titleLabel:
                label.font = UIFont(name: "Avenir Next", size: 28)
            case self.releaseDateLabel, self.ratingLabel:
                label.font = UIFont(name: "Avenir Next", size: 12)
            case self.plotLabel:
                label.font = UIFont(name: "Avenir Next", size: 18)
            case self.tomatoeRating:
                label.font = UIFont(name: "AvenirNext-UltraLight", size: 48)
                label.textColor = UIColor(red: 0.984, green: 0.256, blue: 0.184, alpha: 1.0)
            default:
                label.font = UIFont(name: "Avenir Next", size: 14)
            }
        }
    }
    
    //Called when the user clicks the search button
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        if let searchQuery = searchBar.text{
            //hide the keyboard when the user clicks search
            searchBar.resignFirstResponder()
            
            //Invoke searchImbd method and pass the search query
            self.apiController.searchIMDb(searchQuery)
            
            searchBar.text = "" //clear the text
        }
    }
    
    /**
     This method is called when the Api returns data
     @param jsonResult Query JsonOjbect
     */
    func didFinishImdbSearch(jsonResult: Dictionary<String, String>) {
        
        self.formatLabels(false)
        
        //Parse the data
        self.titleLabel.text = jsonResult["Title"]
        self.plotLabel.text = jsonResult["Plot"]
        
        if let releaseDate = jsonResult["Released"]{
            self.releaseDateLabel.text = "Release Date: " + releaseDate
        }
        
        if let rating = jsonResult["Rated"]{
            self.ratingLabel.text = "Rating: " + rating
        }
        if let posterUrl = jsonResult["Poster"]{
            self.formatImageFromUrl(posterUrl)
        }
        
        if let tomatoeMeterRating = jsonResult["tomatoMeter"]{
            self.tomatoeRating.text = tomatoeMeterRating + "%"
        }
        
    }
    
    //Hide keyboard when the user taps outside
    func gestureTapInView(gesture : UITapGestureRecognizer){
        self.searchBar.resignFirstResponder()
    }
    
    func formatImageFromUrl(imageUrl: String){
        
        let posterImageUrl = NSURL(string: imageUrl)
        
        if let posterImageUrl = posterImageUrl{
            let posterImageData = NSData(contentsOfURL: posterImageUrl)
            
            if let posterImageData = posterImageData{
                self.posterImageView.clipsToBounds = true
                //                self.posterImageView.layer.cornerRadius = 100.0
                self.posterImageView.image = UIImage(data: posterImageData)
                self.blurBackGround(self.posterImageView.image!)
            }
        }
    }
    
    /*!
     * @discussion This function uses an Image to create a blurr effect.
     * @param Image
     */
    func blurBackGround(image: UIImage){
        
        //Get the dimensions of the view
        let frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        let imageView = UIImageView(frame: frame)
        imageView.image = image
        imageView.contentMode = .ScaleAspectFit
        
        
        //Set up blurr effect
        let blurEffect = UIBlurEffect(style: .Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        let transparentWhiteView = UIView(frame: frame)
        transparentWhiteView.backgroundColor = UIColor(white: 1.0, alpha: 0.95)
        
        let viewsArray = [imageView, blurEffectView, transparentWhiteView]
        
        for index in 0..<viewsArray.count{
            if let oldView = self.view.viewWithTag(index + 1){
                oldView.removeFromSuperview()
            }
            
            let viewToInsert = viewsArray[index]
            self.view.insertSubview(viewToInsert, atIndex: index + 1)
            viewToInsert.tag = 1
        }
    }
    
}


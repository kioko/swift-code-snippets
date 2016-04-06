//
//  FlickrApi.swift
//  CollectionViewDemo
//
//  Created by Kioko on 05/04/2016.
//  Copyright © 2016 Thomas Kioko. All rights reserved.
//

import UIKit

//Flickr API Key
let apiKey = "PUT_API_KEY_HERE"

protocol FlickrApiDelegate{
    func didFinishSearch(jsonResult: NSDictionary)
}


class FlickrApi {
    
    var flickrDelegate : FlickrApiDelegate?
    
    //Flickr Image sizes
    var imageSizeOriginal : String = "o"
    var imageSizeLarge : String = "b"
    var imageSizeMedium : String = "m"
    var imageSizeLargeSquare : String = "q"
    
    init(flickrDelegate : FlickrApiDelegate){
        self.flickrDelegate = flickrDelegate
    }
    
    func searchFlickr(photoCategoryName : String, completion : (results: FlickrSearchResults?, error : NSError?) -> Void){
        
        //String all the spaces and replace them with %. This ensures the string
        //is url encoded
        let spacelessString = photoCategoryName
            .stringByAddingPercentEncodingWithAllowedCharacters(
                .URLHostAllowedCharacterSet()
        )
        
        
        if spacelessString != nil{
            
            let urlPath = flickrSearchURLForSearchTerm(photoCategoryName)
            
            let session = NSURLSession.sharedSession()
            
            if  urlPath == urlPath{
                let task = session.dataTaskWithURL(urlPath){
                    data, response, error -> Void in
                    
                    if let errorMessage = error{
                        print(errorMessage.localizedDescription)
                    }
                    
                    do{
                        let jsonResult = try NSJSONSerialization.JSONObjectWithData(
                            data!, options: NSJSONReadingOptions.MutableContainers
                            ) as? NSDictionary
                        
                        if let apiDelegate = self.flickrDelegate{
                            
                            dispatch_async(dispatch_get_main_queue()){
                                
                                //TODO:: Dismiss Dialog
                                if let jsonResult = jsonResult{
                                    
                                    let photosContainer = jsonResult["photos"] as! NSDictionary
                                    let photosReceived = photosContainer["photo"] as! [NSDictionary]
                                    
                                    //Loop through the result
                                    let flickrPhotos : [FlickrPhoto] = photosReceived.map {
                                        photoDictionary in
                                        
                                        let photoID = photoDictionary["id"] as? String ?? ""
                                        let farm = photoDictionary["farm"] as? Int ?? 0
                                        let server = photoDictionary["server"] as? String ?? ""
                                        let secret = photoDictionary["secret"] as? String ?? ""
                                        
                                        let flickrPhoto = FlickrPhoto(photoID: photoID, farm: farm, server: server, secret: secret)
                                        
                                        let imageData = NSData(contentsOfURL: flickrPhoto.flickrImageURL(self.imageSizeMedium))
                                        
                                        if let imageData = imageData{
                                            flickrPhoto.largeImage = UIImage(data: imageData)
                                        }
                                        
                                        return flickrPhoto
                                    }
                                    
                                    dispatch_async(dispatch_get_main_queue(), {
                                        //Pass the result to the json
                                        apiDelegate.didFinishSearch(jsonResult)
                                        
                                        completion(results:FlickrSearchResults(searchTerm: photoCategoryName, searchResults: flickrPhotos), error: nil)
                                    })
                                }
                            }
                        }
                    }catch{
                        //TODO:: Print the exception
                    }
                }
                task.resume()
            }
        }
    }
    
    
    private func flickrSearchURLForSearchTerm(searchTerm:String) -> NSURL {
        
        let escapedTerm = searchTerm.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
        
        let URLString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=\(escapedTerm)&per_page=30&format=json&nojsoncallback=1"
        return NSURL(string: URLString)!
    }
    
}

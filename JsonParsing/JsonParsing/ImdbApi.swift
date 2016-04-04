//
//  ImdbApi.swift
//  JsonParsing
//
//  Created by Kioko on 04/04/2016.
//  Copyright © 2016 Thomas Kioko. All rights reserved.
//

import UIKit

protocol ImdbApiControllerDelegate{
    
    func didFinishImdbSearch(jsonResult: Dictionary<String, String>)
}

class ImdbApi {
    var imdbDelegate : ImdbApiControllerDelegate?
    
    init(imdbDelegate: ImdbApiControllerDelegate){
        self.imdbDelegate = imdbDelegate
    }
    
    /*!
     * @discussion This function invoke Omdb Api and returns the search result.
     * @param Name of the movie
     */
    func searchIMDb(movieTitle: String){
        
        //String all the spaces and replace them with %. This ensures the string
        //is url encoded
        let spacelessString = movieTitle
            .stringByAddingPercentEncodingWithAllowedCharacters(
                .URLHostAllowedCharacterSet()
        )
        
        if let spacelessString = spacelessString{
            let urlPath = NSURL(string: "http://www.omdbapi.com/?t="
                + "\(spacelessString)&tomatoes=true")
            
            print(urlPath)
            
            let session = NSURLSession.sharedSession()
            
            if let urlPath = urlPath{
                let task = session.dataTaskWithURL(urlPath){
                    data, response, error -> Void in
                    
                    if let errorMessage = error{
                        print(errorMessage.localizedDescription)
                    }
                    
                    do{
                        //TODO::Show Dialog
                        let jsonResult = try NSJSONSerialization.JSONObjectWithData(
                            data!, options: NSJSONReadingOptions.MutableContainers
                            ) as? Dictionary<String, String>
                        
                        if let apiDelegate = self.imdbDelegate{
                            dispatch_async(dispatch_get_main_queue()){
                                if let jsonResult = jsonResult{
                                    //TODO:: Dismiss Dialog
                                    apiDelegate.didFinishImdbSearch(jsonResult)
                                }
                            }
                        }
                    }catch{
                        //TODO:: Print the error message
                    }
                }
                task.resume()
            }else{
                print(urlPath)
                print(spacelessString)
            }
        }else{
            print("Ohh no")
        }
        
    }
}

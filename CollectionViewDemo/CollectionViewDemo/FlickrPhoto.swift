//
//  FlickrPhoto.swift
//  CollectionViewDemo
//
//  Created by Kioko on 06/04/2016.
//  Copyright © 2016 Thomas Kioko. All rights reserved.
//

import UIKit

struct FlickrSearchResults {
    let searchTerm : String
    let searchResults : [FlickrPhoto]
}

class FlickrPhoto : Equatable {
    var thumbnail : UIImage?
    var largeImage : UIImage?
    let photoID : String
    let farm : Int
    let server : String
    let secret : String
    
    init (photoID:String,farm:Int, server:String, secret:String) {
        self.photoID = photoID
        self.farm = farm
        self.server = server
        self.secret = secret
    }
    
    func flickrImageURL(imageSize:String) -> NSURL {
        return NSURL(string: "http://farm\(farm).staticflickr.com/\(server)/\(photoID)_\(secret)_\(imageSize).jpg")!
    }
}

func == (lhs: FlickrPhoto, rhs: FlickrPhoto) -> Bool {
    return lhs.photoID == rhs.photoID
}


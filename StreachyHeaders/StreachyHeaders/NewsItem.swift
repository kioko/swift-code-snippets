//
//  NewsItem.swift
//  StreachyHeaders
//
//  Created by Kioko on 29/03/2016.
//  Copyright © 2016 Thomas Kioko. All rights reserved.
//

import Foundation
import UIKit


struct NewsItem{
    
    enum NewsCategory{
        case World
        case Americas
        case Europe
        case MiddleEast
        case Africa
        case AsiaPacific
        
        
        func toString() -> String{
            switch self {
            case .World:
                return "World"
            case .Africa:
                return "Africa"
            case .Americas:
                return "Americas"
            case .MiddleEast:
                return "MiddleEast"
            case .Europe:
                return "Europe"
            case .AsiaPacific:
                return "AsiaPacific"
            }
        }
        
        func toColor()-> UIColor{
            switch self {
            case .World:
                return UIColor(red: 0.106, green: 0.686, blue: 0.125, alpha: 1)
            case .Africa:
                return UIColor(red: 0.114, green: 0.639, blue: 0.948, alpha: 1)
            case .Americas:
                return UIColor(red: 0.322, green: 0.459, blue: 0.948, alpha: 1)
            case .MiddleEast:
                return UIColor(red: 0.502, green: 0.290, blue: 0.948, alpha: 1)
            case .Europe:
                return UIColor(red: 0.988, green: 0.271, blue: 0.282, alpha: 1)
            case .AsiaPacific:
                return UIColor(red: 0.620, green: 0.776, blue: 0.153, alpha: 1)
            }
        }
    }
    
    let category : NewsCategory
    let summary : String
}

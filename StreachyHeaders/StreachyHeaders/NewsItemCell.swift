//
//  NewsItemCell.swift
//  StreachyHeaders
//
//  Created by Kioko on 29/03/2016.
//  Copyright © 2016 Thomas Kioko. All rights reserved.
//

import UIKit

class NewsItemCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    var newsItem : NewsItem?{
        didSet{
            if let item = newsItem{
                categoryLabel.text = item.category.toString()
                categoryLabel.textColor = item.category.toColor()
                summaryLabel.text = item.summary
            }else{
                categoryLabel.text = nil
                summaryLabel.text = nil
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

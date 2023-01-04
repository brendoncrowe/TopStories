//
//  CustomCell.swift
//  TopStories
//
//  Created by Brendon Crowe on 1/3/23.
//

import UIKit

class HeadlineCell: UITableViewCell {
    
    @IBOutlet weak var headlineTitleLabel: UILabel!
    @IBOutlet weak var bylineLabel: UILabel!
    @IBOutlet weak var headlineImageView: UIImageView!
    
    // to add corner radius for the headlineImageView image, access the layer.corner radius property. This involves overriding the layoutSubviews() method
    
    override func layoutSubviews() {
        super.layoutSubviews() // super.layoutSubviews implements any parent setup code
        
        // change the cornerRadius of the imageView's layer
        headlineImageView.layer.cornerRadius = 4 // 4 is a CGFloat
    }
    
    func configureCell(for headline: NewsHeadline) {
        headlineTitleLabel.text = headline.title
        bylineLabel.text = headline.byline
    }
}

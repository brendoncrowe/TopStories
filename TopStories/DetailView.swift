//
//  DetailView.swift
//  TopStories
//
//  Created by Brendon Crowe on 1/3/23.
//

import UIKit

class DetailView: UIViewController {
    
    @IBOutlet weak var headlineImage: UIImageView!
    @IBOutlet weak var headlineAbstract: UITextView!
    @IBOutlet weak var bylineLabel: UILabel!
    
    var headline: NewsHeadline?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    
    func updateUI() {
        navigationItem.title = headline?.title
        headlineAbstract.text = headline?.abstract
        bylineLabel.text = headline?.byline
        
        // update image using superJumbo multimedia
        if let superJumboImage = headline?.superJumbo {
            ImageClient.fetchImage(for: superJumboImage.url) { [unowned self] (result) in
                switch result {
                case .failure(let error):
                    // use a ui alert controller something went wrong
                    print("error - \(error)")
                case .success(let image):
                    DispatchQueue.main.async {
                        // TODO: UIActivityIndicator() shows the user an indicator of the download progress
                        self.headlineImage.image = image
                    }
                }
            }
        }
    }
}

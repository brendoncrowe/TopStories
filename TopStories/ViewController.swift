//
//  ViewController.swift
//  TopStories
//
//  Created by Brendon Crowe on 1/2/23.
//

import UIKit

class NewsFeedController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        dump(HeadlinesData.getHeadlines())
    }


}


//
//  RedditViewController.swift
//  deviget-reddit-test
//
//  Created by Christopher Amato on 04/04/2020.
//  Copyright © 2020 Christo Apps. All rights reserved.
//

import UIKit

class RedditViewController: UIViewController {
    
    var redditDataViewModel: RedditDataViewModel!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        redditDataViewModel = RedditDataViewModel()
        
        redditDataViewModel.fetchRedditData()
        
    }
    
}


//
//  RedditViewController.swift
//  deviget-reddit-test
//
//  Created by Christopher Amato on 04/04/2020.
//  Copyright © 2020 Christo Apps. All rights reserved.
//

import UIKit

class RedditViewController: UIViewController {
    
    @IBOutlet var redditDataViewModel: RedditDataViewModel!
    @IBOutlet var redditPostTableView: UITableView!
    @IBOutlet var firstLoadSpinner: UIActivityIndicatorView!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        redditDataViewModel.fetchRedditData() { [weak self] in
            guard let unwrappedSelf = self else {
                print("\(RedditViewController.self) is nil")
                return
            }
            DispatchQueue.main.async {
                unwrappedSelf.redditPostTableView.isHidden = false
                unwrappedSelf.firstLoadSpinner.stopAnimating()
            }
        }
        
    }
    
}


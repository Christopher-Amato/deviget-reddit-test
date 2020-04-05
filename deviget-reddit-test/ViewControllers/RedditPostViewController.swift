//
//  RedditPostViewController.swift
//  deviget-reddit-test
//
//  Created by Christopher Amato on 04/04/2020.
//  Copyright © 2020 Christo Apps. All rights reserved.
//

import UIKit
import WebKit

class RedditPostViewController: UIViewController {
    
    @IBOutlet var postTitle: UILabel!
    @IBOutlet var webView: WKWebView!
    
    var redditPostViewModel: RedditPostViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
         
        guard let redditPostViewModel = redditPostViewModel else {
            print("\(RedditPostViewModel.self) is nil")
            return
        }
        postTitle.text = redditPostViewModel.title
        if let url = redditPostViewModel.url {
            webView.load(URLRequest(url: url))
        }
    }

    @IBAction func closePost() {
        dismiss(animated: true, completion: nil)
    }
    
}

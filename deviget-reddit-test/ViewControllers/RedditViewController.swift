//
//  RedditViewController.swift
//  deviget-reddit-test
//
//  Created by Christopher Amato on 04/04/2020.
//  Copyright © 2020 Christo Apps. All rights reserved.
//

import UIKit

class RedditViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        getJson()
        
    }

    func getJson() {
        guard let url = URL(string: RedditTopURLString) else {
            print("Invalid URL")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print("Response Error: \(error)")
                return
            }

            guard let data = data else {
                print("Invalid Data")
                return
            }
            print("Data: \(data)")
            
        }.resume()
    }
    
}


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
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            if let error = error {
                print("Response Error: \(error)")
                return
            }

            guard let data = data else {
                print("Invalid Data")
                return
            }
            
            guard let unwrappedSelf = self else {
                print("\(RedditViewController.self) is nil")
                return
            }
            print("JSON: \(unwrappedSelf.decodeRedditResponseData(data))")
            
        }.resume()
    }
    
    private func decodeRedditResponseData(_ redditResponseData: Data) -> RedditResponse? {
        do {
            let redditResponse = try JSONDecoder().decode(RedditResponse.self, from: redditResponseData)
            return redditResponse
        } catch let error {
            print("JSONDecoder Error: \(error)")
            return nil
        }
        
    }
    
}


//
//  RedditDataViewModel.swift
//  deviget-reddit-test
//
//  Created by Christopher Amato on 04/04/2020.
//  Copyright © 2020 Christo Apps. All rights reserved.
//

import Foundation

class RedditDataViewModel: NSObject {
    
    var redditData: RedditData?
    var dismissedPostsIds = [String]()
    var readPostsIds = [String]()
    
    func fetchRedditData(firstPage: Bool = false, callback: ProcessedRedditPostsCallback? = nil) {
        guard var urlComponents = URLComponents(string: RedditTopURLString) else {
            print("Invalid URL: \(RedditTopURLString)")
            return
        }
        urlComponents.queryItems = [ URLQueryItem(name: RedditNextParameter, value: firstPage ? "" : redditData?.after) ]
        guard let url = urlComponents.url else {
            print("Invalid URL: \(urlComponents)")
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
                print("\(RedditDataViewModel.self) is nil")
                return
            }
            unwrappedSelf.redditData = unwrappedSelf.decodeRedditResponseData(data)?.data            
            if let cb = callback {
                cb(unwrappedSelf.getRedditPostViewModels())
            }
        }.resume()
    }
    
    private func getRedditPostViewModels() -> [RedditPostViewModel] {
        guard let redditDataChildren = redditData?.children else {
            print("\(RedditData.self) is nil")
            return [RedditPostViewModel]()
        }
        var redditPostViewModels = [RedditPostViewModel]()
        for children in redditDataChildren {
            let postViewModel = RedditPostViewModel(redditPost: children.data)
            postViewModel.postRead = readPostsIds.contains(postViewModel.id)
            if !dismissedPostsIds.contains(postViewModel.id) {
                redditPostViewModels.append(postViewModel)
            }
        }
        return redditPostViewModels
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

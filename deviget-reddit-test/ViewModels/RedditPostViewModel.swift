//
//  RedditPostViewModel.swift
//  deviget-reddit-test
//
//  Created by Christopher Amato on 04/04/2020.
//  Copyright © 2020 Christo Apps. All rights reserved.
//

import Foundation

class RedditPostViewModel {
    
    private let redditPost: RedditPost
    
    var postRead = false
    
    var id: String {
        get {
            return redditPost.id
        }
    }
        
    var author: String {
        get {
            return redditPost.author
        }
    }
    
    var title: String {
        get {
            return redditPost.title
        }
    }
    
    var thumbnailURL: URL? {
        get {
            return URL(string: redditPost.thumbnail)
        }
    }
    
    var url: URL? {
        get {
            return URL(string: redditPost.url)
        }
    }
    
    var commentsCountText: String {
        get {
            return "\(redditPost.num_comments) comments"
        }
    }
    
    var dateText: String {
        get {
            return String(redditPost.created_utc)
        }
    }
    
    init(redditPost: RedditPost) {
        self.redditPost = redditPost
    }
    
}

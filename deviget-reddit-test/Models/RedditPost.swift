//
//  RedditPost.swift
//  deviget-reddit-test
//
//  Created by Christopher Amato on 04/04/2020.
//  Copyright © 2020 Christo Apps. All rights reserved.
//

import Foundation

struct RedditPost: Codable {
    
    let id: String
    let author: String
    let title: String
    let thumbnail: String
    let url: String
    let num_comments: Int
    let created_utc: TimeInterval
    
}

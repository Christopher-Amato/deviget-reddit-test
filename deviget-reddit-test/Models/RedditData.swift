//
//  RedditData.swift
//  deviget-reddit-test
//
//  Created by Christopher Amato on 04/04/2020.
//  Copyright © 2020 Christo Apps. All rights reserved.
//

struct RedditResponse: Codable {

    let data: RedditData
    
}

struct RedditData: Codable {

    struct RedditChildrenData: Codable {
        
        let data: RedditPost
        
    }

    let children: [RedditChildrenData]
    let after: String

}

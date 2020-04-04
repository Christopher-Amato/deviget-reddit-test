//
//  Constants.swift
//  deviget-reddit-test
//
//  Created by Christopher Amato on 04/04/2020.
//  Copyright © 2020 Christo Apps. All rights reserved.
//

import UIKit

//Blocks
typealias ProcessedRedditPostsCallback = ([RedditPostViewModel]) -> Void

//Numbers
let RedditPostTableViewCellHeight = CGFloat(150)

//Strings
let RedditTopURLString = "https://reddit.com/top.json"
let RedditNextParameter = "after"
let RedditPostTableViewCellIdentifier = "RedditPostTableViewCellID"

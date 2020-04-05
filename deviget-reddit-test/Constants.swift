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
typealias DismissPostTappedCallback = (RedditPostTableViewCell) -> Void

//Strings
let RedditTopURLString = "https://reddit.com/top.json"
let RedditNextParameter = "after"
let RedditPostTableViewCellIdentifier = "RedditPostTableViewCellID"
let ToRedditPostSegueIdentifier = "ToRedditPost"

//Texts (this should be in a localization file but for the sake of time it's are here)
let PullToRefreshString = "Pull to refresh"
let JustNowText = "Just Now"
let MinuteText = "minute ago"
let MinutesText = "minutes ago"
let HourText = "hour ago"
let HoursText = "hours ago"
let DayText = "day ago"
let DaysText = "days ago"
let WeekText = "week ago"
let WeeksText = "weeks ago"
let MonthText = "month ago"
let MonthsText = "months ago"
let YearText = "year ago"
let YearsText = "years ago"
let CommentsText = "comments"

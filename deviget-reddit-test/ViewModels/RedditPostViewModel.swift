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
            return "\(redditPost.num_comments) \(CommentsText)"
        }
    }
    
    var dateText: String {
        get {
            return getDateFormat(redditPost.created_utc)
        }
    }
    
    init(redditPost: RedditPost) {
        self.redditPost = redditPost
    }
    
    func getDateFormat(_ timestamp: TimeInterval) -> String {
        let now = Date()
        let timestampDifference = now.timeIntervalSince1970 - timestamp
        if timestampDifference < 60 {
            return JustNowText
        }
        if timestampDifference < (60 * 60) {
            let minutes = floor(timestampDifference / 60)
            return "\(String(format: "%.0f", minutes)) \(minutes > 1 ? MinutesText : MinuteText)"
        }
        if timestampDifference < (60 * 60 * 24) {
            let hours = floor(timestampDifference / 60 / 60)
            return "\(String(format: "%.0f", hours)) \(hours < 2 ? HourText : HoursText)"
        }
        if timestampDifference < (60 * 60 * 24 * 7) {
            let days = floor(timestampDifference / 60 / 60 / 24)
            return "\(String(format: "%.0f", days)) \(days < 2 ? DayText : DaysText)"
        }
        if timestampDifference < (60 * 60 * 24 * 30) {
            let weeks = floor(timestampDifference / 60 / 60 / 24 / 7)
            return "\(String(format: "%.0f", weeks)) \(weeks < 2 ? WeekText : WeeksText)"
        }
        if timestampDifference < (60 * 60 * 24 * 365) {
            let months = floor(timestampDifference / 60 / 60 / 24 / 30)
            return "\(String(format: "%.0f", months)) \(months < 2 ? MonthText : MonthsText)"
        }
        let years = floor(timestampDifference / 60 / 60 / 24 / 365)
        return "\(String(format: "%.0f", years)) \(years < 2 ? YearText : YearsText)"
    }
}

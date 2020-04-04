//
//  RedditPostTableViewCell.swift
//  deviget-reddit-test
//
//  Created by Christopher Amato on 04/04/2020.
//  Copyright © 2020 Christo Apps. All rights reserved.
//

import UIKit

class RedditPostTableViewCell: UITableViewCell {

    @IBOutlet var postAuthor: UILabel!
    @IBOutlet var postDate: UILabel!
    @IBOutlet var thumbnailImage: UIImageView!
    @IBOutlet var thumbnailWidth: NSLayoutConstraint!
    @IBOutlet var thumbnailSeparatorWidth: NSLayoutConstraint!
    @IBOutlet var postTitle: UILabel!
    @IBOutlet var commentCount: UILabel!
    @IBOutlet var readDotWidth: NSLayoutConstraint!
    @IBOutlet var readDotSeparatorWidth: NSLayoutConstraint!

    var redditPostViewModel: RedditPostViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureWith(redditPostViewModel: RedditPostViewModel) {
        self.redditPostViewModel = redditPostViewModel
        postAuthor.text = redditPostViewModel.author
        postDate.text = redditPostViewModel.dateText
        thumbnailImage.image = UIImage()

        postTitle.text = redditPostViewModel.title
        commentCount.text = redditPostViewModel.commentsCountText
    }
    
    @IBAction func dismissPostTapped() {
        
    }
}

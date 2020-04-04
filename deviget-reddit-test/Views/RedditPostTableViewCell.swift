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
        if let url = redditPostViewModel.thumbnailURL {
            URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                guard let unwrappedSelf = self else {
                    print("\(RedditDataViewModel.self) is nil")
                    return
                }
                if let error = error {
                    unwrappedSelf.showThumbnail(false)
                    print("Response Error: \(error)")
                    return
                }
                guard let data = data else {
                    unwrappedSelf.showThumbnail(false)
                    print("Invalid Data")
                    return
                }
                unwrappedSelf.showThumbnail()
                DispatchQueue.main.async {
                    unwrappedSelf.thumbnailImage.image = UIImage(data: data)
                }
            }.resume()
        }
        postTitle.text = redditPostViewModel.title
        commentCount.text = redditPostViewModel.commentsCountText
    }
    
    @IBAction func dismissPostTapped() {
        
    }
    
    func showThumbnail(_ show: Bool = true) {
        DispatchQueue.main.async {
            self.thumbnailWidth.constant = show ? 64 : 0
            self.thumbnailSeparatorWidth.constant = show ? 10 : 0
        }
    }
}

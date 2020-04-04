//
//  RedditViewController.swift
//  deviget-reddit-test
//
//  Created by Christopher Amato on 04/04/2020.
//  Copyright © 2020 Christo Apps. All rights reserved.
//

import UIKit

class RedditViewController: UIViewController {
    
    @IBOutlet var redditDataViewModel: RedditDataViewModel!
    @IBOutlet var redditPostTableView: UITableView!
    @IBOutlet var firstLoadSpinner: UIActivityIndicatorView!
    
    private var redditPostViewModels: [RedditPostViewModel]?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        redditDataViewModel.fetchRedditData { [weak self] (redditPostViewModels) in
            guard let unwrappedSelf = self else {
                print("\(RedditViewController.self) is nil")
                return
            }
            
            unwrappedSelf.redditPostViewModels = redditPostViewModels
            
            DispatchQueue.main.async {
                unwrappedSelf.redditPostTableView.isHidden = false
                unwrappedSelf.redditPostTableView.reloadData()
                unwrappedSelf.firstLoadSpinner.stopAnimating()
            }
        }
        
    }
    
}

//This can be in other files but RedditViewController isn't that big yet.
extension RedditViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return redditPostViewModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RedditPostTableViewCellIdentifier, for: indexPath) as! RedditPostTableViewCell
        cell.selectionStyle = .none
        if let viewModel = redditPostViewModels?[indexPath.item] {
            cell.configureWith(redditPostViewModel: viewModel)
        }
        return cell
    }
    
}

extension RedditViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return RedditPostTableViewCellHeight
        
    }

}

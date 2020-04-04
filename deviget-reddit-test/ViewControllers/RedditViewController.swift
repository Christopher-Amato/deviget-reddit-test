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
    private var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redditPostTableView.separatorStyle = .none
        setupTableFooter()
        setupPullToRefresh()
        loadFirstPage()
        
    }
    
    func loadFirstPage() {
        firstLoadSpinner.startAnimating()
        redditDataViewModel.fetchRedditData(firstPage: true) { [weak self] (redditPostViewModels) in
            
            guard let unwrappedSelf = self else {
                print("\(RedditViewController.self) is nil")
                return
            }
            unwrappedSelf.redditPostViewModels = redditPostViewModels
            DispatchQueue.main.async {
                unwrappedSelf.redditPostTableView.isHidden = false
                unwrappedSelf.redditPostTableView.reloadData()
                unwrappedSelf.firstLoadSpinner.stopAnimating()
                unwrappedSelf.refreshControl.endRefreshing()
            }
        }
    }
    
    func setupTableFooter() {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 150))
        let footerIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 150))
        footerIndicator.style = .large
        footerIndicator.color = .lightGray
        footerIndicator.startAnimating()
        footerView.addSubview(footerIndicator)
        redditPostTableView.tableFooterView = footerView
    }
    
    func setupPullToRefresh() {
        refreshControl.tintColor = .lightGray
        refreshControl.attributedTitle = NSAttributedString(string: "Pull To Refresh", attributes: [.foregroundColor: UIColor.lightGray])
        refreshControl.addTarget(self, action: #selector(refreshPosts), for: UIControl.Event.valueChanged)
        redditPostTableView.addSubview(refreshControl)
    }
    
    @objc func refreshPosts() {
        loadFirstPage()
    }
    
    func dismissPost(postCell: RedditPostTableViewCell) {
        guard let index = redditPostTableView.indexPath(for: postCell) else {
            print("Invalid indexPath")
            return
        }
        redditPostTableView.beginUpdates()
        redditPostTableView.deleteRows(at: [index], with: .fade)
        redditPostViewModels?.remove(at: index.item)
        redditPostTableView.endUpdates()
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
            cell.dismissPostTappedCallback = { [weak self] (postCell) in
                guard let unwrappedSelf = self else {
                    print("\(RedditViewController.self) is nil")
                    return
                }
                if !unwrappedSelf.redditDataViewModel.dismissedPostsIds.contains(viewModel.id) {
                    unwrappedSelf.redditDataViewModel.dismissedPostsIds.append(viewModel.id)
                }
                unwrappedSelf.dismissPost(postCell: postCell)
            }
        }
        return cell
    }
}

extension RedditViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return RedditPostTableViewCellHeight
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.item >= (redditPostViewModels?.count ?? 0) - 1 {
            redditDataViewModel.fetchRedditData() { [weak self] (redditPostViewModels) in
                guard let unwrappedSelf = self else {
                    print("\(RedditViewController.self) is nil")
                    return
                }
                DispatchQueue.main.async {
                    if unwrappedSelf.redditPostViewModels == nil {
                        print("\([RedditPostViewModel].self) is nil")
                        return
                    }
                    unwrappedSelf.redditPostTableView.beginUpdates()
                    var rows = [IndexPath]()
                    for i in 0..<redditPostViewModels.count {
                        rows.append(IndexPath(row: unwrappedSelf.redditPostViewModels!.count + i, section: 0))
                    }
                    unwrappedSelf.redditPostViewModels! += redditPostViewModels
                    unwrappedSelf.redditPostTableView.insertRows(at: rows, with: .fade)
                    unwrappedSelf.redditPostTableView.endUpdates()
                }
            }
        }
    }
}

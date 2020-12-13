//
//  FeedViewController+UITableViewDataSource.swift
//  Reddit-Prototype-iOS
//
//  Created by Pavel Palancica on 12/11/20.
//

import UIKit

// MARK: - UITableViewDataSource methods

extension FeedViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedViewModel.numberOfFeedItems
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let feedItemViewModel = feedViewModel.viewModelForCell(at: indexPath.row),
           let feedCell = feedItemCell(for: tableView, at: indexPath) as? FeedTableViewCell {
            feedCell.configure(with: feedItemViewModel)
            return feedCell
        } else if feedViewModel.isLoadingCell(at: indexPath.row) {
            downloadNextPage()
            return loadingCell(for: tableView, at: indexPath)
        } else {
            return UITableViewCell()
        }
    }
}

// MARK: - Helper methods

extension FeedViewController
{
    func feedItemCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        
        let feedCellIdentifier = String(describing: FeedTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: feedCellIdentifier,
                                                 for: indexPath)
        guard let feedCell = cell as? FeedTableViewCell else {
            fatalError("Make sure you registered the FeedTableViewCell class")
        }
        return feedCell
    }
    
    func loadingCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let loadingCellIdentifier = String(describing: LoadingTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: loadingCellIdentifier,
                                                 for: indexPath)
        guard let loadingCell = cell as? LoadingTableViewCell else {
            fatalError("Make sure you registered the LoadingTableViewCell class")
        }        
        return loadingCell
    }
}

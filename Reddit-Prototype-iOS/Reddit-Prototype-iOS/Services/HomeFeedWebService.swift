//
//  HomeFeedWebService.swift
//  Reddit-Prototype-iOS
//
//  Created by Pavel Palancica on 12/11/20.
//

import Foundation

class HomeFeedWebService: FeedWebService {
    private static let mainURL = "https://www.reddit.com/.json"
    private static let afterURL = "http://www.reddit.com/.json?after="
    
    static func downloadFirstPageData(success: @escaping (FeedItemsData) -> Void,
                                      failure: @escaping (Error) -> Void) {
        guard let url = URL(string: mainURL) else { return }
        downloadDataForPage(url: url, success: success, failure: failure)
    }
    
    static func downloadNextPageData(afterLink: String,
                                     success: @escaping (FeedItemsData) -> Void,
                                     failure: @escaping (Error) -> Void) {
        guard let url = URL(string: "\(afterURL)\(afterLink)") else { return }
        downloadDataForPage(url: url, success: success, failure: failure)
    }
}

// MARK - Private Helper Methods

extension HomeFeedWebService {
    private static func downloadDataForPage(url: URL,
                                            success: @escaping (FeedItemsData) -> Void,
                                            failure: @escaping (Error) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            if let feedData = feedJSONData(from: data) {
                DispatchQueue.main.async {
                    success(feedData)
                }
            }
       }.resume()
    }
    
    private static func feedJSONData(from data: Data) -> FeedItemsData? {
        guard let feedItemsData = try? JSONDecoder().decode(FeedItemsData.self, from: data) else {
            print("Error! Couldn't decode data into a FeedItemsData object")
            return nil
        }
        return feedItemsData
    }
}

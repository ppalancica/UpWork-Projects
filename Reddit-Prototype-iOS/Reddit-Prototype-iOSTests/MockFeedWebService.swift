//
//  MockFeedWebService.swift
//  Reddit-Prototype-iOSTests
//
//  Created by Pavel Palancica on 12/11/20.
//

import Foundation

enum MockWebServiceError: Error {
    case dataNotAvailable
}

class MockFeedWebService: FeedWebService {
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

extension MockFeedWebService {
    private static func downloadDataForPage(url: URL,
                                            success: @escaping (FeedItemsData) -> Void,
                                            failure: @escaping (Error) -> Void) {
        
        if url.absoluteString == mainURL {
            
            guard let path = Bundle(for: MockFeedWebService.self).path(forResource: "reddit_feed", ofType: "json")
                else { fatalError("Can't find search.json file") }
            
            let data = try! Data(contentsOf: URL(fileURLWithPath: path))
            
            if let feedData = feedJSONData(from: data) {
                DispatchQueue.main.async {
                    success(feedData)
                }
            }
            
        } else {
            DispatchQueue.main.async {
                failure(MockWebServiceError.dataNotAvailable)
            }
        }        
    }
    
    private static func feedJSONData(from data: Data) -> FeedItemsData? {
        guard let feedItemsData = try? JSONDecoder().decode(FeedItemsData.self, from: data) else {
            print("Error! Couldn't decode data into a FeedItemsData object")
            return nil
        }
        return feedItemsData
    }
}


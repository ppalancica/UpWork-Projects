//
//  FeedItemsData.swift
//  Reddit-Prototype-iOS
//
//  Created by Pavel Palancica on 12/11/20.
//

import UIKit

fileprivate struct RawServerResponse: Decodable {
    struct FeedItemsData: Decodable {
        var after: String
        var children: [FeedItemWrapper]
    }
    
    struct FeedItemWrapper: Decodable {
        var kind: String
        var data: FeedItemData
    }
    
    struct FeedItemData: Decodable {
        var title: String
        var thumbnail: String
        var score: Int
        var num_comments: Int
        var thumbnail_width: Float?
        var thumbnail_height: Float?
    }
    
    var data: FeedItemsData
}

struct FeedItemsData: Decodable {
    var afterLink: String
    var feedItems: [FeedItem] = []
    
    init(from decoder: Decoder) throws {
        let rawResponse = try RawServerResponse(from: decoder)
        
        for child in rawResponse.data.children {
            var feedItem = FeedItem(title: child.data.title,
                                    thumbnail: child.data.thumbnail,
                                    score: child.data.score,
                                    commentsNumber: child.data.num_comments)
            if let thumbnailWidth = child.data.thumbnail_width {
                feedItem.thumbnailWidth = thumbnailWidth
            }
            if let thumbnailHeight = child.data.thumbnail_height {
                feedItem.thumbnailHeight = thumbnailHeight
            }
            feedItems.append(feedItem)
        }
        
        afterLink = rawResponse.data.after
    }
}

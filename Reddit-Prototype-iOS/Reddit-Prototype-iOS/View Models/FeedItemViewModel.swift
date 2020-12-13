//
//  FeedItemViewModel.swift
//  Reddit-Prototype-iOS
//
//  Created by Pavel Palancica on 12/11/20.
//

import Foundation

private struct PaddingConstants
{
    static let left: Float = 20.0
    static let right: Float = 20.0
}

private struct HeightConstants
{
    static let titleLabelHeight: Float = 80.0
    static let socialStatsViewHeight: Float = 60.0
    static let separatorViewHeight: Float = 12.0
    static let defaultImageHeight: Float = 200.0
}

struct FeedItemViewModel
{
    var title: String
    var thumbnail: String // thumbnail values - spoiler, default, self
    var score: String
    var commentsNumber: String
    var thumbnailWidth: Float?
    var thumbnailHeight: Float?
    // Will be injected, since it's not good practice
    // to directly access UIKit code from ViewModel classes
    var deviceScreenWidth: Float?
    
    init(model: FeedItem) {
        title = model.title
        thumbnail = model.thumbnail
        score = String(model.score)
        commentsNumber = String(model.commentsNumber)
    }
    
    func heightForCell() -> Float {
        var totalHeight = HeightConstants.titleLabelHeight + HeightConstants.socialStatsViewHeight + HeightConstants.separatorViewHeight
        
        if let thumbnailWidth = thumbnailWidth, let thumbnailHeight = thumbnailHeight,
           let deviceScreenWidth = deviceScreenWidth, thumbnailWidth > 0 && thumbnailHeight > 0 {
            
            let ratio = Float(thumbnailHeight) / Float(thumbnailWidth)
            let imageHeight = (deviceScreenWidth - PaddingConstants.left - PaddingConstants.right) * ratio
            
            totalHeight += imageHeight
        } else {
            totalHeight += HeightConstants.defaultImageHeight
        }
        
        return totalHeight
    }
}

//
//  FeedWebService.swift
//  Reddit-Prototype-iOS
//
//  Created by Pavel Palancica on 12/11/20.
//

import UIKit

protocol FeedWebService {
    static func downloadFirstPageData(success: @escaping (FeedItemsData) -> Void,
                                      failure: @escaping (Error) -> Void)
    
    static func downloadNextPageData(afterLink: String,
                                     success: @escaping (FeedItemsData) -> Void,
                                     failure: @escaping (Error) -> Void)
}

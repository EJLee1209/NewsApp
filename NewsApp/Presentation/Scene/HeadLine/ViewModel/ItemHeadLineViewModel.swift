//
//  ItemHeadLineViewModel.swift
//  NewsApp
//
//  Created by 이은재 on 1/19/24.
//

import Foundation

struct ItemHeadLineViewModel {
    private(set) var article: Article
    
    var title: String? {
        article.title
    }
    
    var publishedAt: String? {
        article.publishedAt
    }
    
    var imageURL: URL? {
        URL(string: article.urlToImage ?? "")
    }
}

//
//  ItemHeadLineViewModel.swift
//  NewsApp
//
//  Created by 이은재 on 1/19/24.
//


struct ItemHeadLineViewModel {
    private(set) var article: Article
    
    var title: String? {
        article.title
    }
    
    var publishedAt: String? {
        article.publishedAt
    }
    
    var imageURL: String? {
        article.urlToImage
    }
}

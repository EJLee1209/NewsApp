//
//  ItemSearchResultViewModel.swift
//  NewsApp
//
//  Created by 이은재 on 1/20/24.
//

struct ItemSearchResultViewModel {
    
    private let article: Article
    
    init(article: Article) {
        self.article = article
    }
    
    var imageUrl: String? {
        article.urlToImage
    }
    
    var title: String? {
        article.title
    }
    
    var publishedAt: String? {
        article.publishedAt
    }
    
}

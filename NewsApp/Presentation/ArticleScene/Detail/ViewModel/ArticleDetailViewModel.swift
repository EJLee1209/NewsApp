//
//  ArticleDetailViewModel.swift
//  NewsApp
//
//  Created by 이은재 on 1/20/24.
//
import Foundation

struct ArticleDetailViewModel {
    private let article: Article
    
    var imageUrl: URL? {
        URL(string: article.urlToImage ?? "")
    }
    
    var title: String? {
        article.title
    }
    
    var description: String? {
        article.description
    }
    
    var author: String {
        "출처: \(article.author ?? "Unknown")"
    }
    
    var publishedAt: String? {
        article.publishedAt
    }
    
    
    init(article: Article) {
        self.article = article
    }
}

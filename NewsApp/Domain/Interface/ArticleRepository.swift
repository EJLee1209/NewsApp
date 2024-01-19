//
//  ArticleRepository.swift
//  NewsApp
//
//  Created by 이은재 on 1/19/24.
//

protocol ArticleRepository {
    
    func fetchHeadLineArticles(
        endPoint: String,
        query: [String: String]
    ) async throws -> [Article]
    
}

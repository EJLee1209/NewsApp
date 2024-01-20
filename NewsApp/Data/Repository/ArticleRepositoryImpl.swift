//
//  ArticleRepositoryImpl.swift
//  NewsApp
//
//  Created by 이은재 on 1/19/24.
//

struct ArticleRepositoryImpl: ArticleRepository {
    
    private(set) var apiClient: ApiClientService
    
    func fetchArticles(
        endPoint: String,
        query: [String : String]
    ) async throws -> [Article] {
        
        try await apiClient.request(
            endPoint: endPoint,
            query: query,
            decodeType: ResultArticleDTO.self
        ).toDomain()
    }
}

//
//  LoadSearchResultArticlesUseCase.swift
//  NewsApp
//
//  Created by 이은재 on 1/20/24.
//

protocol LoadSearchResultArticlesUseCase {
    
    func execute(
        query: SearchQuery
    ) async -> Result<[Article], Error>
    
}

struct LoadSearchResultArticlesUseCaseImpl: LoadSearchResultArticlesUseCase {
    private(set) var articleRepository: ArticleRepository
    private(set) var endPoint: String
    
    func execute(
        query: SearchQuery
    ) async -> Result<[Article], Error> {
        do {
            let result = try await articleRepository.fetchArticles(
                endPoint: endPoint,
                query: query.toDict()
            )
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
}

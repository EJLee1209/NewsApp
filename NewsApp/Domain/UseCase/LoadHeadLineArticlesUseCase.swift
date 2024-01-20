//
//  LoadHeadLineArticlesUseCase.swift
//  NewsApp
//
//  Created by 이은재 on 1/19/24.
//

protocol LoadHeadLineArticlesUseCase {
    func execute(
        query: HeadLineQuery
    ) async -> Result<[Article], Error>
}

struct LoadHeadLineArticlesUseCaseImpl: LoadHeadLineArticlesUseCase {
    private(set) var articleRepository: ArticleRepository
    private(set) var endPoint: String
    
    func execute(query: HeadLineQuery) async -> Result<[Article], Error> {
        do {
            let articles = try await articleRepository.fetchArticles(
                endPoint: endPoint,
                query: query.toDict()
            )
            return .success(articles)
        } catch {
            return .failure(error)
        }
    }
}

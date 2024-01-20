//
//  AppDIContainer.swift
//  NewsApp
//
//  Created by 이은재 on 1/20/24.
//

protocol AppDIContainer {
    func makeHeadLineViewModel() -> HeadLineViewModel
    func makeArticleViewModel(article: Article) -> ArticleDetailViewModel
}

struct AppDIContainerImpl: AppDIContainer {
    struct Dependency {
        let apiClient: ApiClientService
    }
    
    private let dependencies: Dependency
    
    init(dependencies: Dependency) {
        self.dependencies = dependencies
    }
    
    func makeHeadLineViewModel() -> HeadLineViewModel {
        let useCase = makeLoadHeadLineArticleUseCase()
        return HeadLineViewModelImpl(loadHeadLineArticlesUseCase: useCase)
    }
    
    private func makeLoadHeadLineArticleUseCase() -> LoadHeadLineArticlesUseCase {
        let repository = makeArticleRepository()
        return LoadHeadLineArticlesUseCaseImpl(
            articleRepository: repository,
            endPoint: EndPoint.headline
        )
    }
    
    private func makeArticleRepository() -> ArticleRepository {
        ArticleRepositoryImpl(apiClient: dependencies.apiClient)
    }
    
    
    func makeArticleViewModel(article: Article) -> ArticleDetailViewModel {
        ArticleDetailViewModel(article: article)
    }
}

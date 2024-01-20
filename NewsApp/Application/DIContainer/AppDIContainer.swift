//
//  AppDIContainer.swift
//  NewsApp
//
//  Created by 이은재 on 1/20/24.
//

/// 앱 의존성 관리를 위한 DIContainer
protocol AppDIContainer {
    func makeCategoryViewModel() -> CategoryViewModel
    func makeHeadLineViewModel(category: String) -> HeadLineViewModel
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
    
    func makeCategoryViewModel() -> CategoryViewModel {
        CategoryViewModel()
    }
    
    func makeHeadLineViewModel(category: String) -> HeadLineViewModel {
        HeadLineViewModelImpl(
            loadHeadLineArticlesUseCase: makeLoadHeadLineArticleUseCase(),
            category: category
        )
    }
    
    func makeArticleViewModel(article: Article) -> ArticleDetailViewModel {
        ArticleDetailViewModel(article: article)
    }
    
    private func makeLoadHeadLineArticleUseCase() -> LoadHeadLineArticlesUseCase {
        LoadHeadLineArticlesUseCaseImpl(
            articleRepository: makeArticleRepository(),
            endPoint: EndPoint.headline
        )
    }
    
    private func makeArticleRepository() -> ArticleRepository {
        ArticleRepositoryImpl(apiClient: dependencies.apiClient)
    }
    
}

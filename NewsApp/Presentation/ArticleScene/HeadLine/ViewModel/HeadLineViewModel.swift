//
//  HeadLineViewModel.swift
//  NewsApp
//
//  Created by 이은재 on 1/19/24.
//

import Combine

protocol HeadLineViewModel: BaseViewModel {
    var itemArticlesCount: Int { get }
    
    func makeItemViewModel(row: Int) -> ItemHeadLineViewModel
}

final class HeadLineViewModelImpl: HeadLineViewModel {
    var itemArticlesCount: Int {
        articles.count
    }
    
    var state: PassthroughSubject<ViewState, Never> = .init()
    
    private var loadHeadLineArticlesUseCase: LoadHeadLineArticlesUseCase
    private var articles: [Article] = []
    
    init(
        loadHeadLineArticlesUseCase: LoadHeadLineArticlesUseCase
    ) {
        self.loadHeadLineArticlesUseCase = loadHeadLineArticlesUseCase
    }
    
    func viewDidLoad() {
        state.send(.loading)
        
        Task {
            let query = HeadLineQuery(
                category: nil,
                country: HeadLineCountry.kr.rawValue,
                apiKey: EndPoint.apiKey
            )
            updateHeadLineArticles(
                result: await loadHeadLineArticlesUseCase.execute(query: query)
            )
        }
    }
    
    private func updateHeadLineArticles(result: Result<[Article], Error>) {
        switch result {
        case .success(let articles):
            self.articles = articles
            state.send(.success)
        case .failure(let error):
            state.send(.fail(errorMsg: error.localizedDescription))
        }
    }
    
    func makeItemViewModel(row: Int) -> ItemHeadLineViewModel {
        ItemHeadLineViewModel(article: articles[row])
    }
}

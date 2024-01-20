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
    func getArticle(row: Int) -> Article
    func changeCountry(country: HeadLineCountry)
}

final class HeadLineViewModelImpl: HeadLineViewModel {
    var itemArticlesCount: Int {
        articles.count
    }
    
    var state: PassthroughSubject<ViewState, Never> = .init()
    
    private var loadHeadLineArticlesUseCase: LoadHeadLineArticlesUseCase
    private let category: String
    private var articles: [Article] = []
    private var country: HeadLineCountry
    
    init(
        loadHeadLineArticlesUseCase: LoadHeadLineArticlesUseCase,
        category: String,
        country: HeadLineCountry = .kr
    ) {
        self.loadHeadLineArticlesUseCase = loadHeadLineArticlesUseCase
        self.category = category
        self.country = country
    }
    
    func viewDidLoad() {
        state.send(.loading)
        
        Task {
            let query = HeadLineQuery(
                category: category,
                country: country.rawValue,
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
    
    func getArticle(row: Int) -> Article {
        articles[row]
    }
    
    func changeCountry(country: HeadLineCountry) {
        self.country = country
        viewDidLoad()
    }
}

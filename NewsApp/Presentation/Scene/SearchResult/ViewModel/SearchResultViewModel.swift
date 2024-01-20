//
//  SearchResultViewModel.swift
//  NewsApp
//
//  Created by 이은재 on 1/20/24.
//

import Combine

protocol SearchResultViewModel: BaseViewModel {
    var itemSearchResultCount: Int { get }
    
    func search(withKeyword keyword: String)
    func makeItemSearchResultViewModel(row: Int) -> ItemSearchResultViewModel
    func getArticle(row: Int) -> Article
}

final class SearchResultViewModelImpl: SearchResultViewModel {
    var itemSearchResultCount: Int {
        searchResults.count
    }
    
    var state: PassthroughSubject<ViewState, Never> = .init()
    private var searchResults: [Article] = []
    
    private let loadSearchResultArticlesUseCase: LoadSearchResultArticlesUseCase
    
    init(loadSearchResultArticlesUseCase: LoadSearchResultArticlesUseCase) {
        self.loadSearchResultArticlesUseCase = loadSearchResultArticlesUseCase
    }
    
    func viewDidLoad() {}
    
    func search(withKeyword keyword: String) {
        Task {
            let result = await makeQueryAndExecuteUseCase(keyword: keyword)
            updateSearchResult(result)
        }
    }
    
    private func makeQueryAndExecuteUseCase(
        keyword: String
    ) async -> Result<[Article], Error> {
        let query = SearchQuery(
            q: keyword,
            searchIn: nil,
            sortBy: nil
        )
        return await loadSearchResultArticlesUseCase.execute(query: query)
    }
    
    private func updateSearchResult(_ result: Result<[Article], Error>) {
        switch result {
        case .success(let articles):
            searchResults = articles
            state.send(.success)
        case .failure(let error):
            state.send(.fail(errorMsg: error.localizedDescription))
        }
    }
    
    func makeItemSearchResultViewModel(row: Int) -> ItemSearchResultViewModel {
        ItemSearchResultViewModel(article: searchResults[row])
    }
    
    func getArticle(row: Int) -> Article {
        searchResults[row]
    }
}

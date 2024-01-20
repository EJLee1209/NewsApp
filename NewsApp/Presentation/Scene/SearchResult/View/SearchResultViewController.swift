//
//  SearchResultViewController.swift
//  NewsApp
//
//  Created by 이은재 on 1/19/24.
//

import UIKit
import Combine

protocol SearchResultViewControllerCoordinator: AnyObject {
    func didSelectSearchResult(article: Article)
}

final class SearchResultViewController: UITableViewController {
    //MARK: - Properties
    
    private let viewModel: SearchResultViewModel
    private var cancellable = Set<AnyCancellable>()
    private weak var coordinator: SearchResultViewControllerCoordinator?
    
    //MARK: - Life Cycle
    
    init(
        viewModel: SearchResultViewModel,
        coordinator: SearchResultViewControllerCoordinator
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(style: .plain)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        stateController()
    }
    
    //MARK: - Helpers
    private func configUI() {
        view.backgroundColor = .systemBackground
        
        tableView.register(
            ItemSearchResultTableViewCell.self,
            forCellReuseIdentifier: ItemSearchResultTableViewCell.identifier
        )
    }
    
    private func stateController() {
        viewModel.state
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                self?.didUpdateViewState(state)
            }.store(in: &cancellable)
    }
    
    private func didUpdateViewState(_ state: ViewState) {
        switch state {
        case .loading:
            print("DEBUG: 로딩..")
        case .success:
            tableView.reloadData()
        case .fail(let errorMsg):
            print("DEBUG: 검색 실패 \(errorMsg)")
        }
    }
    
    //MARK: - Actions
    
}

//MARK: - UISearchResultsUpdating
extension SearchResultViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        dump(searchController.searchBar.text)
        guard let searchKeyword = searchController.searchBar.text,
              !searchKeyword.isEmpty else {
            return
        }
        
        viewModel.search(withKeyword: searchKeyword)
        
    }
}

//MARK: - DataSource
extension SearchResultViewController {
    override func tableView(
        _ tableView: UITableView, 
        numberOfRowsInSection section: Int
    ) -> Int {
        viewModel.itemSearchResultCount
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ItemSearchResultTableViewCell.identifier,
            for: indexPath
        ) as! ItemSearchResultTableViewCell
        let itemViewModel = viewModel.makeItemSearchResultViewModel(row: indexPath.row)
        cell.configData(viewModel: itemViewModel)
        return cell
    }
}

//MARK: - Delegate
extension SearchResultViewController {
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = viewModel.getArticle(row: indexPath.row)
        coordinator?.didSelectSearchResult(article: article)
    }
}

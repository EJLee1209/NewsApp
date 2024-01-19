//
//  HeadLineViewController.swift
//  NewsApp
//
//  Created by 이은재 on 1/19/24.
//

import UIKit
import Combine

final class HeadLineViewController: UITableViewController {
    //MARK: - Properties
    
    private let viewModel: HeadLineViewModel
    private var cancellable = Set<AnyCancellable>()
    
    init(viewModel: HeadLineViewModel) {
        self.viewModel = viewModel
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        configSearchController()
        configViewState()
        viewModel.viewDidLoad()
    }
    
    //MARK: - Helpers
    private func configUI() {
        view.backgroundColor = .systemBackground
        
    }
    
    private func configSearchController() {
        let searchResultController = SearchResultViewController()
        let searchController = UISearchController(searchResultsController: searchResultController)
        searchController.searchBar.placeholder = "Search News"
        searchController.searchResultsUpdater = searchResultController
        self.navigationItem.searchController = searchController
    }
    
    private func configViewState() {
        viewModel.state
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                self?.updateUI(state: state)
            }.store(in: &cancellable)
    }
    
    private func updateUI(state: ViewState) {
        switch state {
        case .loading:
            print("DEBUG: 로딩 중..")
        case .success:
            print("DEBUG: 아티클 수 \(viewModel.itemArticlesCount)")
        case .fail(let errorMsg):
            print("DEBUG: \(errorMsg)")
        }
    }
    
    
    //MARK: - Actions
    
}


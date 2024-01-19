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
    
    private let testView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        return view
    }()
    
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
        
        tableView.register(
            ItemHeadLineTableViewCell.self,
            forCellReuseIdentifier: ItemHeadLineTableViewCell.identifier
        )
        tableView.separatorStyle = .none
        
    }
    
    private func configSearchController() {
        let searchResultController = SearchResultViewController()
        let searchController = UISearchController(searchResultsController: searchResultController)
        searchController.searchBar.placeholder = "Search Articles"
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
        hideSpinner()
        
        switch state {
        case .loading:
            showSpinner()
        case .success:
            tableView.reloadData()
        case .fail(let errorMsg):
            presentAlert(title: "Error", message: errorMsg)
        }
    }
    
    
    //MARK: - Actions
    
}

//MARK: - DataSource
extension HeadLineViewController {
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        viewModel.itemArticlesCount
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ItemHeadLineTableViewCell.identifier,
            for: indexPath
        ) as! ItemHeadLineTableViewCell
        let itemViewModel = viewModel.makeItemViewModel(row: indexPath.row)
        cell.configData(viewModel: itemViewModel)
        return cell
    }
}

extension HeadLineViewController: SpinnerDisplayable, MessageDisplayable {}
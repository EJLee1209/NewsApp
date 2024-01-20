//
//  HeadLineViewController.swift
//  NewsApp
//
//  Created by 이은재 on 1/19/24.
//

import UIKit
import Combine

protocol HeadLineViewControllerCoordinator: AnyObject {
    func didSelectArticle(_ article: Article)
}

final class HeadLineViewController: UITableViewController {
    //MARK: - Properties

    private let viewModel: HeadLineViewModel
    private weak var coordinator: HeadLineViewControllerCoordinator?
    private var cancellable = Set<AnyCancellable>()
    
    init(
        viewModel: HeadLineViewModel,
        coordinator: HeadLineViewControllerCoordinator
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
    
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        configViewState()
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: - Helpers
    private func configUI() {
        view.backgroundColor = .systemBackground
        
        tableView.separatorStyle = .none
        tableView.register(
            ItemHeadLineTableViewCell.self,
            forCellReuseIdentifier: ItemHeadLineTableViewCell.identifier
        )
        
        configRightBarButton()
    }
    
    private func configRightBarButton() {
        let menuItems = HeadLineCountry.allCases.map { country in
            UIAction(
                title: country.description,
                handler: { [weak self] action in
                    self?.viewModel.changeCountry(country: country)
                }
            )
        }
        
        let menu = UIMenu(title: "Select Country", options: .displayInline, children: menuItems)
        
        let rightBarButton = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis.circle"),
            menu: menu
        )
        navigationItem.setRightBarButton(rightBarButton, animated: true)
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
    
}

//MARK: - UITableViewDataSource
extension HeadLineViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.itemArticlesCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ItemHeadLineTableViewCell.identifier,
            for: indexPath
        ) as! ItemHeadLineTableViewCell
        let itemViewModel = viewModel.makeItemViewModel(row: indexPath.row)
        cell.configData(viewModel: itemViewModel)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension HeadLineViewController {
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let article = viewModel.getArticle(row: indexPath.row)
        coordinator?.didSelectArticle(article)
    }
}


extension HeadLineViewController: SpinnerDisplayable, MessageDisplayable {}

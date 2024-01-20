//
//  CategoryViewController.swift
//  NewsApp
//
//  Created by 이은재 on 1/20/24.
//

import UIKit

protocol CategoryViewControllerCoordinator: AnyObject {
    func didSelectCategory(category: String)
}

final class CategoryViewController: UICollectionViewController {
    //MARK: - Properties
    
    private let viewModel: CategoryViewModel
    private weak var coodinator: CategoryViewControllerCoordinator?
    
    //MARK: - Life Cycle
    init(
        viewModel: CategoryViewModel,
        layout: UICollectionViewLayout,
        coodinator: CategoryViewControllerCoordinator
    ) {
        self.viewModel = viewModel
        self.coodinator = coodinator
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configUI()
        configSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true 
    }
    
    //MARK: - Helpers
    
    private func configUI() {
        view.backgroundColor = .systemBackground
        
        collectionView.register(
            ItemCategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: ItemCategoryCollectionViewCell.identifier
        )
        
    }
    
    private func configSearchController() {
        let searchResultController = SearchResultViewController()
        let searchController = UISearchController(searchResultsController: searchResultController)
        searchController.searchBar.placeholder = "Search Articles"
        searchController.searchResultsUpdater = searchResultController
        self.navigationItem.searchController = searchController
    }
    
    //MARK: - Actions
    
}


//MARK: - DataSource
extension CategoryViewController {
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        viewModel.itemCategoriesCount
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ItemCategoryCollectionViewCell.identifier,
            for: indexPath
        ) as! ItemCategoryCollectionViewCell
        let itemViewModel = viewModel.makeItemCategoryViewModel(row: indexPath.row)
        cell.configData(viewModel: itemViewModel)
        return cell
    }
}

//MARK: - Delegate
extension CategoryViewController {
    override func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let category = viewModel.getSelectedCategory(row: indexPath.row)
        coodinator?.didSelectCategory(category: category)
    }
}

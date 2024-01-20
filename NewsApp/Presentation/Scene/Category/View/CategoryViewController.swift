//
//  CategoryViewController.swift
//  NewsApp
//
//  Created by 이은재 on 1/20/24.
//

import UIKit

final class CategoryViewController: UICollectionViewController {
    //MARK: - Properties
    
    private let viewModel: CategoryViewModel
    
    //MARK: - Life Cycle
    init(
        viewModel: CategoryViewModel,
        layout: UICollectionViewLayout
    ) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configUI()
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

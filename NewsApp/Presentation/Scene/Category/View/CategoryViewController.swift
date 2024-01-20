//
//  CategoryViewController.swift
//  NewsApp
//
//  Created by 이은재 on 1/20/24.
//

import UIKit

final class CategoryViewController: UICollectionViewController {
    //MARK: - Properties
    
    //MARK: - Life Cycle
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
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
    }
    
    //MARK: - Actions
    
}


//MARK: - DataSource
extension CategoryViewController {
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 10
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cell",
            for: indexPath
        )
        cell.backgroundColor = .systemBlue
        cell.layer.cornerRadius = 12
        cell.clipsToBounds = true
        return cell
    }
}

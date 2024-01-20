//
//  SearchResultViewController.swift
//  NewsApp
//
//  Created by 이은재 on 1/19/24.
//

import UIKit

final class SearchResultViewController: UITableViewController {
    //MARK: - Properties
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    private func configUI() {
        view.backgroundColor = .systemGray
    }
    
    //MARK: - Helpers
    
    //MARK: - Actions
    
}

extension SearchResultViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        dump(searchController.searchBar.text)
    }
}

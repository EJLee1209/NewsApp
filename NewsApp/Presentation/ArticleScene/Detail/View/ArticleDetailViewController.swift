//
//  ArticleDetailViewController.swift
//  NewsApp
//
//  Created by 이은재 on 1/20/24.
//

import UIKit

final class ArticleDetailViewController: UIViewController {
    //MARK: - Properties
    
    private let viewModel: ArticleDetailViewModel
    
    //MARK: - Life Cycle
    init(viewModel: ArticleDetailViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
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
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    //MARK: - Helpers
    private func configUI() {
        view.backgroundColor = .systemBackground
    }
    
    //MARK: - Actions
    
}

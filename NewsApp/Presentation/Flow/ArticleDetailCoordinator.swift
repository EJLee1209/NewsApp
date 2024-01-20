//
//  ArticleDetailCoordinator.swift
//  NewsApp
//
//  Created by 이은재 on 1/20/24.
//

import UIKit

final class ArticleDetailCoordinator: Coordinator {
    var navigation: UINavigationController
    var appDIContainer: AppDIContainer
    
    private let article: Article
    
    init(
        navigation: UINavigationController,
        appDIContainer: AppDIContainer,
        article: Article
    ) {
        self.navigation = navigation
        self.appDIContainer = appDIContainer
        self.article = article
    }
    
    func start() {
        let controller = makeArticleDetailViewController()
        navigation.pushViewController(controller, animated: true)
    }
    
    private func makeArticleDetailViewController() -> UIViewController {
        let viewModel = appDIContainer.makeArticleViewModel(article: article)
        return ArticleDetailViewController(viewModel: viewModel)
    }
    
    
}

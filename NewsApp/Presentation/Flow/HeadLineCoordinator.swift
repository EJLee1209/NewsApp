//
//  HeadLineCoordinator.swift
//  NewsApp
//
//  Created by 이은재 on 1/19/24.
//

import UIKit



final class HeadLineCoordinator: Coordinator {
    
    var navigation: UINavigationController
    var appDIContainer: AppDIContainer
    private let window: UIWindow
    
    private var articleDetailCoordinator: Coordinator?
    
    init(
        navigation: UINavigationController,
        appDIContainer: AppDIContainer,
        window: UIWindow
    ) {
        self.navigation = navigation
        self.appDIContainer = appDIContainer
        self.window = window
    }
    
    func start() {
        let controller = makeHeadLineViewController()
        controller.title = "Top Headline"
        navigation.pushViewController(controller, animated: true)
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
    
    private func makeHeadLineViewController() -> UIViewController {
        let viewModel = appDIContainer.makeHeadLineViewModel()
        return HeadLineViewController(
            viewModel: viewModel,
            coordinator: self
        )
    }
}

extension HeadLineCoordinator: HeadLineViewControllerCoordinator {
    func didSelectArticle(_ article: Article) {
        articleDetailCoordinator = makeArticleDetailCoordinator(article: article)
        articleDetailCoordinator?.start()
    }
    
    private func makeArticleDetailCoordinator(article: Article) -> Coordinator {
        ArticleDetailCoordinator(
            navigation: navigation,
            appDIContainer: appDIContainer,
            article: article
        )
    }
}

//
//  HeadLineCoordinator.swift
//  NewsApp
//
//  Created by 이은재 on 1/19/24.
//

import UIKit

final class HeadLineCoordinator: Coordinator {
    var navigation: UINavigationController
    private let window: UIWindow
    
    init(
        navigation: UINavigationController,
        window: UIWindow
    ) {
        self.navigation = navigation
        self.window = window
    }
    
    func start() {
        let apiClient = ApiClientServiceImpl()
        let articleRepository = ArticleRepositoryImpl(apiClient: apiClient)
        let loadHeadLineArticlesUseCase = LoadHeadLineArticlesUseCaseImpl(
            articleRepository: articleRepository,
            endPoint: EndPoint.headline
        )
        let headLineViewModel = HeadLineViewModelImpl(
            loadHeadLineArticlesUseCase: loadHeadLineArticlesUseCase
        )
        let controller = HeadLineViewController(viewModel: headLineViewModel)
        controller.title = "HeadLine"
        navigation.pushViewController(controller, animated: true)
        navigation.navigationBar.prefersLargeTitles = true
        
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
}

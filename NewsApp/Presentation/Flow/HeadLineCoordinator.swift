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
        controller.title = "HeadLine"
        navigation.pushViewController(controller, animated: true)
        navigation.navigationBar.prefersLargeTitles = true
        
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
        print("DEBUG: 선택된 아티클 \(article)")
    }
}

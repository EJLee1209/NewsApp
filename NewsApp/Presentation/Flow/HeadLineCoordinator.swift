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
        let controller = HeadLineViewController()
        controller.title = "HeadLine"
        navigation.pushViewController(controller, animated: true)
        
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
}

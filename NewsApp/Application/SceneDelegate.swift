//
//  SceneDelegate.swift
//  NewsApp
//
//  Created by 이은재 on 1/19/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    private var headLineCoodinator: Coordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let apiClientService = ApiClientServiceImpl()
        let appDIContainer = AppDIContainerImpl(dependencies: .init(apiClient: apiClientService))
        let headLineCoodinator = HeadLineCoordinator(
            navigation: UINavigationController(),
            appDIContainer: appDIContainer,
            window: window
        )
        headLineCoodinator.start()
        self.headLineCoodinator = headLineCoodinator
    }
}


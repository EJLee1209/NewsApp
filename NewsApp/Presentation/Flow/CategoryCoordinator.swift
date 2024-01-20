//
//  CategoryViewController.swift
//  NewsApp
//
//  Created by 이은재 on 1/20/24.
//

import UIKit

final class CategoryCoordinator: Coordinator {
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
        let categoryViewController = CategoryViewController(
            viewModel: appDIContainer.makeCategoryViewModel(),
            layout: makeCollectionViewLayout()
        )
        categoryViewController.title = "News App"
        navigation.pushViewController(categoryViewController, animated: true)
        
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
    
    private func makeCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = ViewValue.normalPadding
        layout.minimumInteritemSpacing = ViewValue.normalPadding
        layout.sectionInset = .init(
            top: 0,
            left: ViewValue.largePadding,
            bottom: 0,
            right: ViewValue.largePadding
        )
        layout.itemSize = makeCellSize(
            itemSpace: ViewValue.normalPadding,
            sectionHorizonInset: ViewValue.largePadding,
            numberOfColumn: 2
        )
        return layout
    }
    
    private func makeCellSize(
        itemSpace: CGFloat,
        sectionHorizonInset: CGFloat,
        numberOfColumn: Int
    ) -> CGSize {
        let usableWidth = ViewValue.screenWidth - 2 * sectionHorizonInset - (CGFloat(numberOfColumn) - 1) * itemSpace
        
        let cellWidth = usableWidth / CGFloat(numberOfColumn)
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    
}



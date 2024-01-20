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
    
    private var headlineCoodinator: Coordinator?
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
        let categoryViewController = CategoryViewController(
            viewModel: appDIContainer.makeCategoryViewModel(),
            layout: makeCollectionViewLayout(),
            coodinator: self
        )
        categoryViewController.title = "News App"
        navigation.pushViewController(categoryViewController, animated: true)
        
        configSearchController(categoryViewController)
        
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
    
    private func configSearchController(_ viewController: UIViewController) {
        let searchResultController = SearchResultViewController(
            viewModel: appDIContainer.makeSearchResultViewModel(), 
            coordinator: self
        )
        let searchController = UISearchController(searchResultsController: searchResultController)
        searchController.searchBar.placeholder = "Search Articles"
        searchController.searchResultsUpdater = searchResultController
        viewController.navigationItem.searchController = searchController
    }
}

//MARK: - CategoryViewControllerCoordinator
extension CategoryCoordinator: CategoryViewControllerCoordinator {
    func didSelectCategory(category: String) {
        headlineCoodinator = makeHeadlineCoordinator(category: category)
        headlineCoodinator?.start()
    }
    
    private func makeHeadlineCoordinator(category: String) -> Coordinator {
        HeadLineCoordinator(
            navigation: navigation,
            appDIContainer: appDIContainer,
            category: category
        )
    }
}

extension CategoryCoordinator: SearchResultViewControllerCoordinator {
    func didSelectSearchResult(article: Article) {
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

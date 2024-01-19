//
//  Coordinator.swift
//  NewsApp
//
//  Created by 이은재 on 1/19/24.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigation: UINavigationController { get }
    
    func start()
}

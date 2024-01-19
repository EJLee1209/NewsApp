//
//  BaseViewModel.swift
//  NewsApp
//
//  Created by 이은재 on 1/19/24.
//

import Combine

protocol BaseViewModel {
    var state: PassthroughSubject<ViewState, Never> { get }
    
    func viewDidLoad()
}

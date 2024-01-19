//
//  SpinnerDisplayable.swift
//  NewsApp
//
//  Created by 이은재 on 1/19/24.
//

import UIKit

protocol SpinnerDisplayable: AnyObject {
    func showSpinner()
    func hideSpinner()
}

extension SpinnerDisplayable where Self : UIViewController {
    func showSpinner() {
        guard doesNotExistAnotherSpinner else { return }
        configureSpinner()
    }
    
    private func configureSpinner() {
        let containerView = UIView()
        containerView.tag = 123
        parentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(parentView)
        }
        containerView.backgroundColor = .black.withAlphaComponent(0.3)
        addSpinnerIndicatorToContainer(containerView: containerView)
    }
    
    private func addSpinnerIndicatorToContainer(containerView: UIView) {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        
        containerView.addSubview(spinner)
        
        spinner.snp.makeConstraints { make in
            make.center.equalTo(containerView)
        }
    }
    
    func hideSpinner(){
        if let foundView = parentView.viewWithTag(123) {
            foundView.removeFromSuperview()
        }
    }
    
    private var doesNotExistAnotherSpinner: Bool {
        parentView.viewWithTag(123) == nil
    }
    
    private var parentView: UIView {
        navigationController?.view ?? view
    }

}

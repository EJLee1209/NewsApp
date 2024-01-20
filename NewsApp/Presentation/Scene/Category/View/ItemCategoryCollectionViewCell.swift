//
//  ItemCategoryCollectionViewCell.swift
//  NewsApp
//
//  Created by 이은재 on 1/20/24.
//

import UIKit

final class ItemCategoryCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGroupedBackground
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    private let categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configUI() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.addSubview(categoryImageView)
        categoryImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        configGradient()
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(ViewValue.normalPadding)
        }
    }
    
    private func configGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.4, 0.9]
        containerView.layer.addSublayer(gradientLayer)
    }
    
    func configData(viewModel: ItemCategoryViewModel) {
        categoryImageView.image = UIImage(named: viewModel.imageName)
        titleLabel.text = viewModel.title
    }
    
    //MARK: - Actions
    
}

extension ItemCategoryCollectionViewCell: Reusable {}

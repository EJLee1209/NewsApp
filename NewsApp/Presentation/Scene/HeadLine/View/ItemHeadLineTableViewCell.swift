//
//  ItemHeadLineTableViewCell.swift
//  NewsApp
//
//  Created by 이은재 on 1/19/24.
//

import UIKit
import SnapKit
import SDWebImage

final class ItemHeadLineTableViewCell: UITableViewCell {
    //MARK: - Properties
    private let outerBackgroundView: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.9
        return view
    }()
    
    private let containerBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGroupedBackground
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = 2
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var containerLabelStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [titleLabel, dateLabel])
        sv.axis = .vertical
        sv.spacing = 4
        return sv
    }()
    
    //MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    private func configUI() {
        selectionStyle = .none
        contentView.addSubview(outerBackgroundView)
        outerBackgroundView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.verticalEdges.equalToSuperview().inset(10)
        }
        
        outerBackgroundView.addSubview(containerBackgroundView)
        containerBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerBackgroundView.addSubview(articleImageView)
        articleImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(articleImageView.snp.width).dividedBy(2)
        }
        
        containerBackgroundView.addSubview(containerLabelStackView)
        containerLabelStackView.snp.makeConstraints { make in
            make.top.equalTo(articleImageView.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    func configData(viewModel: ItemHeadLineViewModel) {
        articleImageView.sd_setImage(with: viewModel.imageURL)
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.publishedAt
    }
    
    
    //MARK: - Actions
    
}


extension ItemHeadLineTableViewCell: Reusable {}

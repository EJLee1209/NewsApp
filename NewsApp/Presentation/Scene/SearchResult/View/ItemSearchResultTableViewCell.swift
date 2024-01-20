//
//  ItemSearchResultTableViewCell.swift
//  NewsApp
//
//  Created by 이은재 on 1/20/24.
//

import UIKit

final class ItemSearchResultTableViewCell: UITableViewCell {
    //MARK: - Properties

    private let articleImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var titleLabel = makeLabel(
        font: .systemFont(ofSize: 18, weight: .semibold)
    )
    
    private lazy var dateLabel = makeLabel(
        font: .systemFont(ofSize: 14),
        color: .systemGray
    )
    
    private lazy var containerLabelStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [titleLabel, dateLabel])
        sv.axis = .vertical
        sv.spacing = 3
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
        contentView.addSubview(articleImageView)
        articleImageView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.size.equalTo(80)
            make.left.equalToSuperview()
        }
        contentView.addSubview(containerLabelStackView)
        containerLabelStackView.snp.makeConstraints { make in
            make.left.equalTo(articleImageView.snp.right).offset(ViewValue.normalPadding)
            make.right.equalToSuperview().inset(ViewValue.normalPadding)
            make.centerY.equalTo(articleImageView)
        }
    }
    
    private func makeLabel(font: UIFont, color: UIColor? = nil) -> UILabel {
        let label = UILabel()
        label.font = font
        if let color = color {
            label.textColor = color
        }
        return label
    }
    
    func configData(viewModel: ItemSearchResultViewModel) {
        if let imageUrl = viewModel.imageUrl {
            articleImageView.sd_setImage(with: URL(string: imageUrl))
        } else {
            articleImageView.image = UIImage(named: "defaultImage")
        }
        
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.publishedAt
    }
    
    //MARK: - Actions
    
}

extension ItemSearchResultTableViewCell: Reusable {}

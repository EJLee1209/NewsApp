//
//  ArticleDetailViewController.swift
//  NewsApp
//
//  Created by 이은재 on 1/20/24.
//

import UIKit

final class ArticleDetailViewController: UIViewController {
    //MARK: - Properties
    private let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = makeLabel(font: .systemFont(ofSize: 25, weight: .bold))
    private lazy var authorLabel: UILabel = makeLabel(font: .systemFont(ofSize: 14))
    private lazy var dateLabel: UILabel = makeLabel(font: .systemFont(ofSize: 12))
    private lazy var descriptionLabel: UILabel = makeLabel(font: .systemFont(ofSize: 16))
    
    private lazy var containerStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            titleLabel, authorLabel, dateLabel, articleImageView, descriptionLabel
        ])
        sv.axis = .vertical
        sv.spacing = 8
        return sv
    }()
    
    private let viewModel: ArticleDetailViewModel
    
    //MARK: - Life Cycle
    init(viewModel: ArticleDetailViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        configData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    //MARK: - Helpers
    private func configUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(containerStackView)
        containerStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(12)
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        articleImageView.snp.makeConstraints { make in
            make.height.equalTo(articleImageView.snp.width)
        }
    }
    
    private func configData() {
        if let imageUrl = viewModel.imageUrl {
            articleImageView.sd_setImage(with: URL(string: imageUrl))
        } else {
            articleImageView.image = UIImage(named: "defaultImage")
        }
        
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.publishedAt
        authorLabel.text = viewModel.author
        descriptionLabel.text = viewModel.description
    }
    
    private func makeLabel(font: UIFont) -> UILabel {
        let label = UILabel()
        label.font = font
        label.numberOfLines = 0
        return label
    }
    
    //MARK: - Actions
    
}

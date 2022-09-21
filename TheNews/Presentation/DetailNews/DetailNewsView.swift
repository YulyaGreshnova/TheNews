//
//  DetailNewsView.swift
//  TheNews
//
//  Created by Yulya Greshnova on 13.09.2022.
//

import Foundation
import UIKit

protocol IDetailNewsView: AnyObject {
    func didReadMoreNews()
}

final class DetailNewsView: UIView {
    private let titleLable: UILabel
    private let newsImageView: UIImageView
    private let descriptionLabel: UILabel
    private let readMoreButton: UIButton
    weak var delegate: IDetailNewsView?
    
    init() {
        titleLable = UILabel()
        newsImageView = UIImageView()
        descriptionLabel = UILabel()
        readMoreButton = UIButton()
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWith(detailNewsViewModel: DetailNewsViewModel) {
        titleLable.text = detailNewsViewModel.title
        if let image = detailNewsViewModel.imageUrl {
            newsImageView.loadFrom(urlAddress: image)
        }
        descriptionLabel.text = detailNewsViewModel.decription
    }
    
    @objc func readMore() {
        delegate?.didReadMoreNews()
    }
}

//MARK: - Private functions
private extension DetailNewsView {
    func setupView() {
        titleLable.font = .boldSystemFont(ofSize: 26)
        titleLable.numberOfLines = 0
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLable)
        
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        newsImageView.contentMode = .scaleAspectFit
        addSubview(newsImageView)
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(descriptionLabel)
        
        readMoreButton.backgroundColor = .white
        readMoreButton.addTarget(self, action: #selector(readMore), for: .touchUpInside)
        readMoreButton.setTitleColor(.systemBlue, for: .normal)
        readMoreButton.setTitle("Read more", for: .normal)
        readMoreButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(readMoreButton)
        
        NSLayoutConstraint.activate([
            titleLable.topAnchor.constraint(equalTo: topAnchor),
            titleLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            newsImageView.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 10),
            newsImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            newsImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            newsImageView.heightAnchor.constraint(equalToConstant: 200),
            
            descriptionLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            readMoreButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            readMoreButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            readMoreButton.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -10),
            readMoreButton.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor)
        ])
    }
}

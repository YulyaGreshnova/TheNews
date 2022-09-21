//
//  NewsListTableViewCell.swift
//  TheRussianNews
//
//  Created by Yulya Greshnova on 09.09.2022.
//

import UIKit

final class NewsListTableViewCell: UITableViewCell {
    
    private let titleLabel: UILabel
    private let dateLabel: UILabel
    private let sourceLabel: UILabel
    private let countViewLabel: UILabel
    private let newsImageView: UIImageView
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }()

    static let cellIdentifier = "NewsListCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        titleLabel = UILabel()
        dateLabel = UILabel()
        sourceLabel = UILabel()
        countViewLabel = UILabel()
        newsImageView = UIImageView()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWith(newsListModel: NewsListViewModel) {
        titleLabel.text = newsListModel.title
        dateLabel.text = dateFormatter.string(from: newsListModel.date)
        sourceLabel.text = newsListModel.source
        countViewLabel.text = "Viewed: \(newsListModel.viewCount)"
        if let url = newsListModel.url {
            newsImageView.loadFrom(urlAddress: url)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        newsImageView.image = nil
    }
}

//MARK: - Private functions
private extension NewsListTableViewCell {
    private func setupCell() {
        titleLabel.font = .boldSystemFont(ofSize: ConstantsNewsListCell.titleFont)
        titleLabel.numberOfLines = 3
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        sourceLabel.font = .italicSystemFont(ofSize: ConstantsNewsListCell.sourceFont)
        sourceLabel.textColor = .systemGray
        sourceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(sourceLabel)
        
        dateLabel.font = .systemFont(ofSize: ConstantsNewsListCell.dateFont)
        dateLabel.textColor = .systemGray2
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateLabel)
        
        countViewLabel.font = .systemFont(ofSize: ConstantsNewsListCell.countViewFont)
        countViewLabel.textColor = .systemGreen
        countViewLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(countViewLabel)
        
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        newsImageView.contentMode = .scaleAspectFit
        contentView.addSubview(newsImageView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                            constant: ConstantsNewsListCell.titleConstaint),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                constant: ConstantsNewsListCell.titleConstaint),
            
            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                               constant: ConstantsNewsListCell.imageViewNewsConstaint),
            newsImageView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor,
                                                   constant: 8),
            newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                    constant: -ConstantsNewsListCell.imageViewNewsConstaint),
            newsImageView.widthAnchor.constraint(equalToConstant: 80),
            newsImageView.heightAnchor.constraint(equalTo: newsImageView.widthAnchor),
            
            sourceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            sourceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                 constant: ConstantsNewsListCell.sourceConstaint),
            sourceLabel.trailingAnchor.constraint(equalTo: newsImageView.leadingAnchor,
                                                  constant: -ConstantsNewsListCell.sourceConstaint),
            
            dateLabel.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                               constant: ConstantsNewsListCell.dateConstaint),
            dateLabel.trailingAnchor.constraint(equalTo: newsImageView.leadingAnchor,
                                                constant: -ConstantsNewsListCell.dateConstaint),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                              constant: -ConstantsNewsListCell.dateConstaint),
            
            countViewLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 8),
            countViewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                              constant: -ConstantsNewsListCell.countViewConstaint),
            countViewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                constant: -ConstantsNewsListCell.countViewConstaint)
        ])
    }
}

struct ConstantsNewsListCell {
    static let titleFont: CGFloat = 16
    static let sourceFont: CGFloat = 14
    static let dateFont: CGFloat = 14
    static let countViewFont: CGFloat = 14
    
    static let multiplierImageViewNews: CGFloat = 0.25
    
    static let titleConstaint: CGFloat = 16
    static let sourceConstaint: CGFloat = 16
    static let dateConstaint: CGFloat = 16
    static let countViewConstaint: CGFloat = 8
    static let imageViewNewsConstaint: CGFloat = 12
}



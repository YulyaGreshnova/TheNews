//
//  DetailNewsViewController.swift
//  TheRussianNews
//
//  Created by Yulya Greshnova on 09.09.2022.
//

import UIKit

protocol IDetailNewsViewController: AnyObject {
    func showDetailNews(viewModel: DetailNewsViewModel)
}

final class DetailNewsViewController: UIViewController {
    private let detailNewsView: DetailNewsView
    private let presenter: IDetailNewsPresenter
    
    init(presenter: IDetailNewsPresenter) {
        self.presenter = presenter
        detailNewsView = DetailNewsView()
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupView()
        presenter.viewLoaded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private functions
private extension DetailNewsViewController {
    func setupView() {
        detailNewsView.delegate = self
        detailNewsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(detailNewsView)
        
        NSLayoutConstraint.activate([
            detailNewsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailNewsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            detailNewsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            detailNewsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

//MARK: - IDetailNewsView
extension DetailNewsViewController: IDetailNewsView {
    func didReadMoreNews() {
        presenter.readMore()
    }
}

//MARK: - IDetailNewsViewController
extension DetailNewsViewController: IDetailNewsViewController {
    func showDetailNews(viewModel: DetailNewsViewModel) {
        detailNewsView.configureWith(detailNewsViewModel: viewModel)
    }
}


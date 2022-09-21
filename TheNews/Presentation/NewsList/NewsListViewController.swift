//
//  NewsListViewController.swift
//  TheRussianNews
//
//  Created by Yulya Greshnova on 08.09.2022.
//

import UIKit

protocol INewsListViewController: AnyObject {
    func showNewsViewModels(viewModels: [NewsListViewModel])
    func showMoreNews(viewModels: [NewsListViewModel])
    func showError()
    func endRefreshingNews()
    func updateViewModel(index: Int, viewCount: Int)
}

final class NewsListViewController: UIViewController {
    private let tableView: UITableView
    private let presenter: INewsListPresenter
    private var newsListViewModels: [NewsListViewModel]
    
    init(presenter: INewsListPresenter) {
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        self.presenter = presenter
        newsListViewModels = []
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "The News"
        setupTableView()
        setupNavigationBar()
        setupRefreshControl()
        presenter.viewLoaded()
    }
}

//MARK: - Private functions
private extension NewsListViewController {
    private func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsListTableViewCell.self, forCellReuseIdentifier: NewsListTableViewCell.cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                                                            target: self,
                                                            action: #selector(refreshNews))
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
}

//MARK: - Actions
extension NewsListViewController {
    @objc func refreshNews() {
        presenter.loadMoreNews()
    }
}

//MARK: - UITableViewDelegate
extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == newsListViewModels.count - 4 {
            presenter.loadMoreNews()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.showDetailNews(index: indexPath.row)
    }
}

//MARK: - UITableViewDataSource
extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsListViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsListTableViewCell.cellIdentifier, for: indexPath) as? NewsListTableViewCell else {
            return UITableViewCell()
        }
        let news = newsListViewModels[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.configureWith(newsListModel: news)
        
        return cell
    }
}

//MARK: - INewsListViewController
extension NewsListViewController: INewsListViewController {
    func showNewsViewModels(viewModels: [NewsListViewModel]) {
        newsListViewModels = viewModels
        tableView.reloadData()
    }
    
    func showMoreNews(viewModels: [NewsListViewModel]) {
        let prevCount = newsListViewModels.count
        newsListViewModels.append(contentsOf: viewModels)
        let newCount = prevCount + viewModels.count
        let insertingIndexPath = (prevCount ..< newCount).map { IndexPath(item: $0, section: 0) }
        tableView.insertRows(at: insertingIndexPath, with: .automatic)
    }
    
    func updateViewModel(index: Int, viewCount: Int) {
        newsListViewModels[index].viewCount = viewCount
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    func showError() {
        let alertController = UIAlertController(title: "Не удалось загрузить новости. Попробуйте позже.",
                                   message: nil,
                                   preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    func endRefreshingNews() {
        tableView.refreshControl?.endRefreshing()
    }
}

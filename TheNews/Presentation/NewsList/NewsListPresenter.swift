//
//  NewsListPresenter.swift
//  TheRussianNews
//
//  Created by Yulya Greshnova on 09.09.2022.
//

import Foundation

protocol INewsListPresenter: AnyObject {
    func viewLoaded()
    func loadMoreNews()
    func showDetailNews(index: Int)
}

final class NewsListPresenter: INewsListPresenter {
    weak var viewController: INewsListViewController?
    
    private let networkService: INetworkService
    private let storageService: IStorageService
    private let router: INewsListRouter
    private var newsModels: [NewsModel]
    private var currentPage = 1
    private var isLoading = false
    
    private struct Constants {
        static let page = 1
        static let perPage = 20
    }
    
    init(networkService: INetworkService, storageService: IStorageService, router: INewsListRouter) {
        self.networkService = networkService
        self.storageService = storageService
        self.router = router
        newsModels = []
    }
    
    func viewLoaded() {
        storageService.loadNews { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let news):
                    self.newsModels = news
                    let viewModels = self.newsModels.map { self.createViewModel(newsModel: $0)}
                    self.viewController?.showNewsViewModels(viewModels: viewModels)
                    self.loadNews()
                case .failure(_):
                    self.loadNews()
                }
            }
        }
    }
    
    func loadMoreNews() {
        if isLoading { return }
        
        isLoading = true
        currentPage += 1
        networkService.fetchNews(page: currentPage, perPage: Constants.perPage) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .failure(_):
                    self.viewController?.showError()
                case .success(let networkModels):
                    let moreNews = networkModels.map { self.createNewsModel(networkNewsModel: $0) }
                    self.newsModels.append(contentsOf: moreNews)
                    let viewModels = moreNews.map { self.createViewModel(newsModel: $0) }
                    self.viewController?.showMoreNews(viewModels: viewModels)
                    self.saveNewsModel(newsModels: self.newsModels)
                }
                self.isLoading = false
                self.viewController?.endRefreshingNews()
            }
        }
    }
    
    func showDetailNews(index: Int) {
        newsModels[index].viewCount += 1
        saveNewsModel(newsModels: newsModels)
        viewController?.updateViewModel(index: index, viewCount: newsModels[index].viewCount)
        let newsModel = newsModels[index]
        router.navigate(to: .detailNews(newsModel))
    }
    
}

//MARK: - Private functions
private extension NewsListPresenter {
    func createNewsModel(networkNewsModel: NetworkNewsModel) -> NewsModel {
        return NewsModel(title: networkNewsModel.title,
                         date: networkNewsModel.publishedAt,
                         source: networkNewsModel.sourceNews,
                         url: networkNewsModel.url,
                         imageUrl: networkNewsModel.urlToImage,
                         description: networkNewsModel.description)
    }
    
    func createViewModel(newsModel: NewsModel) -> NewsListViewModel {
        return NewsListViewModel(title: newsModel.title,
                                 date: newsModel.date,
                                 source: newsModel.source,
                                 url: newsModel.imageUrl,
                                 description: newsModel.description,
                                 urlSource: newsModel.url)
    }
    
    func loadNews() {
        networkService.fetchNews(page: Constants.page, perPage: Constants.perPage) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .failure(_):
                    self.viewController?.showError()
                    
                case .success(let networkModels):
                    self.newsModels = networkModels.map { self.createNewsModel(networkNewsModel: $0)}
                    self.newsModels.sort {$0.date > $1.date }
                    let viewModels = self.newsModels.map { self.createViewModel(newsModel: $0) }
                    self.viewController?.showNewsViewModels(viewModels: viewModels)
                    self.saveNewsModel(newsModels: self.newsModels)
                }
            }
        }
    }
    
    func saveNewsModel(newsModels: [NewsModel]) {
        storageService.save(newsModels: newsModels) { _ in }
    }
}

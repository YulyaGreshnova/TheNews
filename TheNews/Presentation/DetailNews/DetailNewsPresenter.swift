//
//  DetailNewsPresenter.swift
//  TheRussianNews
//
//  Created by Yulya Greshnova on 09.09.2022.
//

import Foundation

protocol IDetailNewsPresenter: AnyObject {
    func viewLoaded()
    func readMore()
}

final class DetailNewsPresenter: IDetailNewsPresenter {
    private let newsModel: NewsModel
    weak var viewController: IDetailNewsViewController?
    private let router: IDetailNewsRouter
    
    init(newsModel: NewsModel, router: IDetailNewsRouter) {
        self.router = router
        self.newsModel = newsModel
    }
    
    func readMore() {
        router.navigate(to: .safariViewController(newsModel.url))
    }
    
    func viewLoaded() {
        let detailViewController = createViewModel(newsModel: newsModel)
        viewController?.showDetailNews(viewModel: detailViewController)
    }
}

//MARK: - Private functions
private extension DetailNewsPresenter {
    func createViewModel(newsModel: NewsModel) -> DetailNewsViewModel {
        return DetailNewsViewModel(title: newsModel.title,
                                   imageUrl: newsModel.imageUrl,
                                   url: newsModel.url,
                                   decription: newsModel.description)
    }
}


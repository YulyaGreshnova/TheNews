//
//  NewsListAssembly.swift
//  TheRussianNews
//
//  Created by Yulya Greshnova on 09.09.2022.
//

import UIKit

protocol INewsListAssembly: AnyObject { }

final class NewsListAssembly: INewsListAssembly {
    func buildViewController() -> UIViewController {
        let networkingService = NetworkService()
        let storageService = StorageService()
        let router = NewsListRouter()
        let presenter = NewsListPresenter(networkService: networkingService,
                                          storageService: storageService,
                                          router: router)
        let viewController = NewsListViewController(presenter: presenter)
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
}

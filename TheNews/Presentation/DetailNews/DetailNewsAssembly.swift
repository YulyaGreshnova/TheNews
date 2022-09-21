//
//  DetailNewsAssembly.swift
//  TheRussianNews
//
//  Created by Yulya Greshnova on 09.09.2022.
//

import Foundation
import UIKit

protocol IDetailNewsAssembly: AnyObject {
    func buildViewController(newsModel: NewsModel) -> UIViewController
}

final class DetailNewsAssembly: IDetailNewsAssembly {
    func buildViewController(newsModel: NewsModel) -> UIViewController {
        let router = DetailNewsRouter()
        let presenter = DetailNewsPresenter(newsModel: newsModel, router: router)
        let viewController = DetailNewsViewController(presenter: presenter)
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
}

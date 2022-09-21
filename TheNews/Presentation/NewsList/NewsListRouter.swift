//
//  NewsListRouter.swift
//  TheRussianNews
//
//  Created by Yulya Greshnova on 09.09.2022.
//

import Foundation
import UIKit

protocol INewsListRouter: AnyObject {
    func navigate(to destination: NewsListRouterDestination)
}

enum NewsListRouterDestination {
    case detailNews(NewsModel)
}

final class NewsListRouter: INewsListRouter {
    weak var viewController: UIViewController?
    
    func navigate(to destination: NewsListRouterDestination) {
        switch destination {
        case .detailNews(let newsModel):
            let detailViewController = DetailNewsAssembly().buildViewController(newsModel: newsModel)
            viewController?.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}

//
//  DetailNewsRouter.swift
//  TheRussianNews
//
//  Created by Yulya Greshnova on 09.09.2022.
//

import SafariServices
import UIKit

protocol IDetailNewsRouter: AnyObject {
    func navigate(to destination: DetailNewsRouterDestination)
}

enum DetailNewsRouterDestination {
    case safariViewController(String)
}

final class DetailNewsRouter: IDetailNewsRouter {
    weak var viewController: UIViewController?
    
    func navigate(to destination: DetailNewsRouterDestination) {
        switch destination {
        case .safariViewController(let urlString):
            let config = SFSafariViewController.Configuration()
            
            guard let url = URL(string: urlString) else { return }
            let safariViewController = SFSafariViewController(url: url, configuration: config)
            viewController?.present(safariViewController, animated: true)
        }
    }
}

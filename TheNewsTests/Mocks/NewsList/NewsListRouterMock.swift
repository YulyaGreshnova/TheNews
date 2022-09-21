//
//  NewsListRouterMock.swift
//  TheNewsTests
//
//  Created by Yulya Greshnova on 19.09.2022.
//

@testable import TheNews

class NewsListRouterMock: INewsListRouter {
    var invokedNavigate = false
    var invokedNavigateCount = 0
    var invokedNavigateParameters: (destination: NewsListRouterDestination, Void)?
    var invokedNavigateParametersList = [(destination: NewsListRouterDestination, Void)]()

    func navigate(to destination: NewsListRouterDestination) {
        invokedNavigate = true
        invokedNavigateCount += 1
        invokedNavigateParameters = (destination, ())
        invokedNavigateParametersList.append((destination, ()))
    }
}

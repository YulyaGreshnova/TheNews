//
//  DetailRouterMock.swift
//  TheNewsTests
//
//  Created by Yulya Greshnova on 19.09.2022.
//

@testable import TheNews

class DetailNewsRouterMock: IDetailNewsRouter {
    var invokedNavigate = false
    var invokedNavigateCount = 0
    var invokedNavigateParameters: (destination: DetailNewsRouterDestination, Void)?
    var invokedNavigateParametersList = [(destination: DetailNewsRouterDestination, Void)]()

    func navigate(to destination: DetailNewsRouterDestination) {
        invokedNavigate = true
        invokedNavigateCount += 1
        invokedNavigateParameters = (destination, ())
        invokedNavigateParametersList.append((destination, ()))
    }
}

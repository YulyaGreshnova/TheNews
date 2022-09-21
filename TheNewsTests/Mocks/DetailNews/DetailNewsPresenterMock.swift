//
//  DetailNewsPresenterMock.swift
//  TheNewsTests
//
//  Created by Yulya Greshnova on 19.09.2022.
//

@testable import TheNews

class DetailNewsPresenterMock: IDetailNewsPresenter {
    var invokedViewLoaded = false
    var invokedViewLoadedCount = 0

    func viewLoaded() {
        invokedViewLoaded = true
        invokedViewLoadedCount += 1
    }

    var invokedReadMore = false
    var invokedReadMoreCount = 0
    var invokedReadMoreParameters: (urlString: String, Void)?
    var invokedReadMoreParametersList = [(urlString: String, Void)]()

    func readMore(urlString: String) {
        invokedReadMore = true
        invokedReadMoreCount += 1
        invokedReadMoreParameters = (urlString, ())
        invokedReadMoreParametersList.append((urlString, ()))
    }
}

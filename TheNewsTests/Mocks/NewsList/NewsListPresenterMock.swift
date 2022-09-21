//
//  NewsListPresenterMock.swift
//  TheNewsTests
//
//  Created by Yulya Greshnova on 19.09.2022.
//

@testable import TheNews

class NewsListPresenterMock: INewsListPresenter {
    var invokedViewLoaded = false
    var invokedViewLoadedCount = 0

    func viewLoaded() {
        invokedViewLoaded = true
        invokedViewLoadedCount += 1
    }

    var invokedLoadMoreNews = false
    var invokedLoadMoreNewsCount = 0

    func loadMoreNews() {
        invokedLoadMoreNews = true
        invokedLoadMoreNewsCount += 1
    }

    var invokedShowDetailNews = false
    var invokedShowDetailNewsCount = 0
    var invokedShowDetailNewsParameters: (index: Int, Void)?
    var invokedShowDetailNewsParametersList = [(index: Int, Void)]()

    func showDetailNews(index: Int) {
        invokedShowDetailNews = true
        invokedShowDetailNewsCount += 1
        invokedShowDetailNewsParameters = (index, ())
        invokedShowDetailNewsParametersList.append((index, ()))
    }
}

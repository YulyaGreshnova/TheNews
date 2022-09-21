//
//  NewsListViewControllerMock.swift
//  TheNewsTests
//
//  Created by Yulya Greshnova on 19.09.2022.
//

@testable import TheNews

class NewsListViewControllerMock: INewsListViewController {
    var invokedShowNewsViewModels = false
    var invokedShowNewsViewModelsCount = 0
    var invokedShowNewsViewModelsParameters: (viewModels: [NewsListViewModel], Void)?
    var invokedShowNewsViewModelsParametersList = [(viewModels: [NewsListViewModel], Void)]()

    func showNewsViewModels(viewModels: [NewsListViewModel]) {
        invokedShowNewsViewModels = true
        invokedShowNewsViewModelsCount += 1
        invokedShowNewsViewModelsParameters = (viewModels, ())
        invokedShowNewsViewModelsParametersList.append((viewModels, ()))
    }

    var invokedShowMoreNewsViewModels = false
    var invokedShowMoreNewsViewModelsCount = 0
    var invokedShowMoreNewsViewModelsParameters: (viewModels: [NewsListViewModel], Void)?
    var invokedShowMoreNewsViewModelsParametersList = [(viewModels: [NewsListViewModel], Void)]()

    func showMoreNews(viewModels: [NewsListViewModel]) {
        invokedShowMoreNewsViewModels = true
        invokedShowMoreNewsViewModelsCount += 1
        invokedShowMoreNewsViewModelsParameters = (viewModels, ())
        invokedShowMoreNewsViewModelsParametersList.append((viewModels, ()))
    }

    var invokedShowError = false
    var invokedShowErrorCount = 0

    func showError() {
        invokedShowError = true
        invokedShowErrorCount += 1
    }

    var invokedEndRefreshingNews = false
    var invokedEndRefreshingNewsCount = 0

    func endRefreshingNews() {
        invokedEndRefreshingNews = true
        invokedEndRefreshingNewsCount += 1
    }

    var invokedUpdateViewModel = false
    var invokedUpdateViewModelCount = 0
    var invokedUpdateViewModelParameters: (index: Int, viewCount: Int)?
    var invokedUpdateViewModelParametersList = [(index: Int, viewCount: Int)]()

    func updateViewModel(index: Int, viewCount: Int) {
        invokedUpdateViewModel = true
        invokedUpdateViewModelCount += 1
        invokedUpdateViewModelParameters = (index, viewCount)
        invokedUpdateViewModelParametersList.append((index, viewCount))
    }
}

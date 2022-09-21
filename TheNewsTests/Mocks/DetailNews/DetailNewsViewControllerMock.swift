//
//  DetailNewsViewControllerMock.swift
//  TheNewsTests
//
//  Created by Yulya Greshnova on 19.09.2022.
//

@testable import TheNews

class DetailNewsViewControllerMock: IDetailNewsViewController {
    var invokedShowDetailNewsViewModel = false
    var invokedShowDetailNewsViewModelCount = 0
    var invokedShowDetailNewsViewModelParameters: (detailNewsViewModel: DetailNewsViewModel, Void)?
    var invokedShowDetailNewsViewModelParametersList = [(detailNewsViewModel: DetailNewsViewModel, Void)]()

    func showDetailNewsViewModel(detailNewsViewModel: DetailNewsViewModel) {
        invokedShowDetailNewsViewModel = true
        invokedShowDetailNewsViewModelCount += 1
        invokedShowDetailNewsViewModelParameters = (detailNewsViewModel, ())
        invokedShowDetailNewsViewModelParametersList.append((detailNewsViewModel, ()))
    }
}

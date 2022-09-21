//
//  DetailNewsPresenterTests.swift
//  TheNewsTests
//
//  Created by Yulya Greshnova on 19.09.2022.
//

import XCTest
@testable import TheNews

class DetailNewsPresenterTests: XCTestCase {
    var router: DetailNewsRouterMock!
    var viewController: DetailNewsViewControllerMock!
    
    override func setUp() {
        super.setUp()
        router = DetailNewsRouterMock()
        viewController = DetailNewsViewControllerMock()
    }
    
    override func tearDown() {
        super.tearDown()
        router = nil
        viewController = nil
    }
    
    func testNavigateToSafariCalled() {
        // Arrange
        let presenter = DetailNewsPresenter(newsModel: NewsModelMock().newsModel,
                                            router: router)
        
        // Act
        presenter.readMore(urlString: NewsModelMock().newsModel.url)
        
        // Assert
        XCTAssertTrue(router.invokedNavigate)
        XCTAssertEqual(router.invokedNavigateCount, 1)
    }
    
    func testShowDetailNewsViewModelCalled() {
        // Arrange
        let presenter = DetailNewsPresenter(newsModel: NewsModelMock().newsModel,
                                            router: router)
        presenter.viewController = viewController
        
        // Act
        presenter.viewLoaded()
        
        // Assert
        XCTAssertTrue(viewController.invokedShowDetailNewsViewModel)
        XCTAssertEqual(viewController.invokedShowDetailNewsViewModelCount, 1)
    }
}

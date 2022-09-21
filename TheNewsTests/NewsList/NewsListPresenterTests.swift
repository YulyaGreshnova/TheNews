//
//  NewsListPresenterTests.swift
//  NewsListPresenterTests
//
//  Created by Yulya Greshnova on 19.09.2022.
//

import XCTest
@testable import TheNews

class NewsListPresenterTests: XCTestCase {

    var storageServiceMock: StorageServiceMock!
    var networkServiceMock: NetworkServiceMock!
    var router: NewsListRouterMock!
    
    override func setUp() {
        super.setUp()
        
        storageServiceMock = StorageServiceMock()
        networkServiceMock = NetworkServiceMock()
        router = NewsListRouterMock()
    }
    
    override func tearDown() {
        super.tearDown()
        
        storageServiceMock = nil
        networkServiceMock = nil
        router = nil
    }
    
    func testLoadNewsCalled() {
        // Arrange
        let presenter = NewsListPresenter(networkService: networkServiceMock,
                                          storageService: storageServiceMock,
                                          router: router)
        
        // Act
        presenter.viewLoaded()
        
        // Assert
        XCTAssertTrue(storageServiceMock.invokedLoadNews)
        XCTAssertEqual(storageServiceMock.invokedLoadNewsCount, 1)
    }
    
    func testFetchNewsFromNetworkCalled() {
        // Arrange
        let presenter = NewsListPresenter(networkService: networkServiceMock,
                                          storageService: storageServiceMock,
                                          router: router)
        
        // Act
        presenter.loadMoreNews()
        
        // Assert
        XCTAssertTrue(networkServiceMock.invokedFetchNews)
        XCTAssertEqual(networkServiceMock.invokedFetchNewsCount, 1)
        XCTAssertNotNil(networkServiceMock.invokedFetchNewsParameters)
    }
}

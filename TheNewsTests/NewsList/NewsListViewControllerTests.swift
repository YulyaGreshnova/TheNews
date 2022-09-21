//
//  NewsListViewControllerTests.swift
//  TheNewsTests
//
//  Created by Yulya Greshnova on 19.09.2022.
//

import XCTest
@testable import TheNews

class NewsListViewControllerTests: XCTestCase {
    var presenter: NewsListPresenterMock!
    
    override func setUp() {
        super.setUp()
        presenter = NewsListPresenterMock()
      
    }
    
    override func tearDown() {
        super.tearDown()
        
        presenter = nil
    }
    
    func testViewLoadedCalled() {
        // Arrange
        let viewController = NewsListViewController(presenter: presenter)
        
        // Act
        viewController.viewDidLoad()
        
        // Assert
        XCTAssertTrue(presenter.invokedViewLoaded)
    }
    
    func testShowDetailNewsCalled() {
        // Arrange
        let viewController = NewsListViewController(presenter: presenter)
        
        // Act
        viewController.tableView(UITableView(),
                                 didSelectRowAt: IndexPath(row: 0, section: 0))
        
        // Assert
        XCTAssertTrue(presenter.invokedShowDetailNews)
    }
}

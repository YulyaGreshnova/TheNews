//
//  DetailViewControllerTests.swift
//  TheNewsTests
//
//  Created by Yulya Greshnova on 19.09.2022.
//

import XCTest
@testable import TheNews

class DetailViewControllerTests: XCTestCase {
    var presenter: DetailNewsPresenterMock!
    
    override func setUp() {
        super.setUp()
        presenter = DetailNewsPresenterMock()
      
    }
    
    override func tearDown() {
        super.tearDown()
        
        presenter = nil
    }
    
    func testViewLoadedCalled() {
        // Arrange
        let viewController = DetailNewsViewController(presenter: presenter)
        
        // Act
        viewController.viewDidLoad()
        
        // Assert
        XCTAssertTrue(presenter.invokedViewLoaded)
    }
}

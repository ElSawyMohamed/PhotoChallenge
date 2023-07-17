//
//  PhotosChallengeUITests.swift
//  PhotosChallengeUITests
//
//  Created by Mohamed El Sawy on 14/07/2023.
//

import XCTest

final class PhotosChallengeUITests: XCTestCase {

    override func setUpWithError() throws {

    }
    
    func testExample() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        app.tables.children(matching: .cell).element(boundBy: 1).children(matching: .other).element(boundBy: 1).swipeDown()
        app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

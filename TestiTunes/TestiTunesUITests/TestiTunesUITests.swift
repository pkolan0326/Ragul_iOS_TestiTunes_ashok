//
//  TestiTunesUITests.swift
//  TestiTunesUITests
//
//  Created by Ragul kts on 17/04/20.
//  Copyright © 2020 Ragul kts. All rights reserved.
//

import XCTest

class TestiTunesUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // UI tests must launch the application that they test.
        
        
//        tablesQuery.staticTexts["K CAMP"].swipeUp()
//        tablesQuery.staticTexts["Bad Bunny"].swipeUp()
//        tablesQuery.cells.containing(.staticText, identifier:"Jackboy").children(matching: .staticText).matching(identifier: "Jackboy").element(boundBy: 1).swipeUp()
//        tablesQuery.cells.containing(.staticText, identifier:"Still Flexin, Still Steppin").staticTexts["YoungBoy Never Broke Again"].swipeUp()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testAlbumVC (){
        let app = XCUIApplication()
        app.launch()
        
        let navbar = app.navigationBars.staticTexts["Top 100 Albums"]
        let viewAppeared = waiterResultWithExpextation(navbar)
        checkExceptions(viewAppeared)
        let tablesQuery = app.tables
        sleep(5)
        XCTAssertEqual(100, tablesQuery.cells.count)
        tablesQuery.cells.element(boundBy: 0).tap()
        
    }
    
    func testAlbumDetailVC () {
        let app = XCUIApplication()
        app.launch()
        
        let navbar = app.navigationBars.staticTexts["Top 100 Albums"]
        let viewAppeared = waiterResultWithExpextation(navbar)
        checkExceptions(viewAppeared)
        let tablesQuery = app.tables
        let cell = tablesQuery.cells.element(boundBy: 0)
        let cellAppeared = waiterResultWithExpextation(cell)
        checkExceptions(cellAppeared)
        XCTAssertEqual(100, tablesQuery.cells.count)
        tablesQuery.cells.element(boundBy: 0).tap()
        sleep(2)
        app.staticTexts["Release Date : "].tap()
        app.staticTexts["Geners : "].tap()
        app.buttons["Goto iTunes"].tap()
                
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    func waiterResultWithExpextation(_ element: XCUIElement) -> XCTWaiter.Result {
            let myPredicate = NSPredicate(format: "exists == true")
            let myExpectation = expectation(for: myPredicate, evaluatedWith: element,
                                          handler: nil)
            let result = XCTWaiter().wait(for: [myExpectation], timeout: 10)
            return result
    }
    func checkExceptions(_ result : XCTWaiter.Result)  {
        switch(result) {
        case .completed:
            print("Passed")
        case .timedOut:
            print("Timed out")
        case .incorrectOrder:
            print("Incorrect order")
        case .invertedFulfillment:
            print("InvertedFulfillment")
        case .interrupted:
            print("Interrupted")
            XCTAssertTrue(false)
        @unknown default:
            print("Do nothing")
            fatalError()

        }
    }
}

//
//  TestiTunesTests.swift
//  TestiTunesTests
//
//  Created by Ragul kts on 17/04/20.
//  Copyright © 2020 Ragul kts. All rights reserved.
//

import XCTest
@testable import TestiTunes
/*
Unit test cases
1)Service call response validation check  for status code 200
2)Service call response validation check  for status code 201
3)Error Validation
4)network check


UI Validation
1)Active screen UIloading with Image loading
2)Active screen UIloading with album and artist name
2)On tap - detail page  check
3)Detail page contains Album Name, Geners, Release date, copyrights
4)Detail page image loading
 */
class TestiTunesTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testServiceCall(){
       let getAblumVc = HomeVC()
        getAblumVc.getTopAlbums()
        sleep(5)
        XCTAssertNotNil(getAblumVc.tblData)
    }
    func testAlbumCount(){
       let getAblumVc = HomeVC()
        getAblumVc.getTopAlbums()
        sleep(5)
        XCTAssertEqual(100, getAblumVc.tblData.count)
    }
    func testSelectedAlbum(){
       let getAblumVc = HomeVC()
        getAblumVc.getTopAlbums()
        sleep(10)
        XCTAssertEqual(100, getAblumVc.tblData.count)
        let ablumDetailVc = AlbumDetailsVC()
        ablumDetailVc.selectedAlbum = getAblumVc.tblData[0]
        ablumDetailVc.addControls()
        ablumDetailVc.loadSelectedAlbum()
        XCTAssertEqual(getAblumVc.tblData[0].name, ablumDetailVc.nameLbl.text)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}


//
//  MainDataManagerTests.swift
//  ToDoListSwiftDataTests
//
//  Created by Carlos Barron on 01/09/24.
//

import XCTest
@testable import ToDoListSwiftData

final class MainDataManagerTests: XCTestCase {

    private var sut: MainDataManager!

    override func setUp() async throws {
        sut = try MainDataManager()
    }

    override func tearDown() {
        sut = nil
    }

    func test_insert() throws {
        let expectedTitle: String = "Test add data"
        let expectedDescription: String = "New Data"

        sut.insert(ToDo(title: expectedTitle, toDoDescription: expectedDescription))
        let result: ToDo? = try sut.find().first

        XCTAssertNotNil(result)
        XCTAssertEqual(result?.title, expectedTitle)
        XCTAssertEqual(result?.toDoDescription, expectedDescription)
        XCTAssertEqual(result?.isFinished, false)
    }

    func test_update() throws {
        let model = ToDo(title: "Test add data", toDoDescription: "New Data")

        sut.insert(model)
        model.title = "new title"
        let result: ToDo? = sut.get(model.id)

        XCTAssertNotNil(result)
        XCTAssertEqual(result?.title, "new title")
    }
}

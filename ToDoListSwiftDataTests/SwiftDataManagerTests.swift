//
//  SwiftDataManagerTests.swift
//  ToDoListSwiftDataTests
//
//  Created by Carlos Barron on 01/09/24.
//

import XCTest
@testable import ToDoListSwiftData

final class SwiftDataManagerTests: XCTestCase {

    private var swiftDataManager: ToDoManager? = SwiftDataManager.shared

    override func setUp() {
        swiftDataManager = SwiftDataManager.shared
    }

    override func tearDown() {
        swiftDataManager = nil
    }

    func test_addNewData() {
        swiftDataManager?.deleteAll()

        let expectedTitle: String = "Test add data"
        let expectedDescription: String = "New Data"

        swiftDataManager?.addNewData(title: expectedTitle, description: expectedDescription)

        guard let data = swiftDataManager?.fetchData() else {
            XCTFail("No data was added")
            return
        }

        let result = data.contains(where: { todo in
            todo.title == expectedTitle && todo.toDoDescription == expectedDescription
        })

        XCTAssertNotNil(result)
        XCTAssertTrue(result)
        XCTAssertEqual(data.count, 1)
    }
}

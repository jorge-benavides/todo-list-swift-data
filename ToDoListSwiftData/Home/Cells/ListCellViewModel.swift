//
//  ListCellViewModel.swift
//  ToDoListSwiftData
//
//  Created by Carlos Barron on 31/08/24.
//

import Foundation

class ListCellViewModel {

    // MARK: Properties
    private let uuid: String
    private let title: String
    private let description: String
    private let isFinished: Bool

    init(uuid: String, title: String, description: String, isFinished: Bool) {
        self.uuid = uuid
        self.title = title
        self.description = description
        self.isFinished = isFinished
    }

    func getData() -> (title: String, description: String, isFinished: Bool) {
        return (title, description, isFinished)
    }
}

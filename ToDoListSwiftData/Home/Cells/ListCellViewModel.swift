//
//  ListCellViewModel.swift
//  ToDoListSwiftData
//
//  Created by Carlos Barron on 31/08/24.
//

import Foundation

class ListCellViewModel {

    // MARK: Properties
    private let title: String
    private let description: String
    private let isFinished: Bool

    init(title: String, description: String, isFinished: Bool) {
        self.title = title
        self.description = description
        self.isFinished = isFinished
    }

    func getData() -> (title: String, description: String, isFinished: Bool) {
        return (title, description, isFinished)
    }
}

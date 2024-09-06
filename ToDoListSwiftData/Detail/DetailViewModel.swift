//
//  DetailViewModel.swift
//  ToDoListSwiftData
//
//  Created by Carlos Barron on 31/08/24.
//

import Foundation
import SwiftData

protocol DetailViewProtocol {
    var titleTextField: String { get }
    var descriptionTextField: String { get }
    var isFinished: Bool { get }
    func save(title: String, description: String) throws
}

class DetailViewModel: DetailViewProtocol {

    // MARK: Properties
    let dataManager: SwiftDataManager
    var model: ToDo?

    // MARK: Life cycle
    init(_ dataManager: SwiftDataManager, id: PersistentIdentifier? = nil) {
        self.dataManager = dataManager
        guard let id else { return }
        model = dataManager.get(id)
    }

    var titleTextField: String {
        model?.title ?? ""
    }

    var descriptionTextField: String {
        model?.toDoDescription ?? ""
    }

    var isFinished: Bool {
        model?.isFinished ?? false
    }

    // MARK: Helpers
    func save(title: String, description: String) throws {
        guard !title.isEmpty && !description.isEmpty else { throw SaveError.badData }
        if let model {
            model.title = title
            model.toDoDescription = description
        } else {
            dataManager.insert(ToDo(title: title, toDoDescription: description))
        }
    }

    enum SaveError: String, Error {
        case badData = "Invalid data"
    }
}

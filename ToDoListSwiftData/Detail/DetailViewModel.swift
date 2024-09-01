//
//  DetailViewModel.swift
//  ToDoListSwiftData
//
//  Created by Carlos Barron on 31/08/24.
//

import Foundation

protocol DetailViewProtocol {
    var type: DetailType { get }
    var id: UUID { get }
    var titleTextField: String { get }
    var descriptionTextField: String { get }
    var isFinished: Bool { get }
    func save(title: String, description: String) -> Result<Bool, Error>
}

class DetailViewModel: DetailViewProtocol {

    // MARK: Properties
    private let toDosManager: ToDoManager
    var type: DetailType
    var id: UUID
    var titleTextField: String
    var descriptionTextField: String
    var isFinished: Bool

    // MARK: Life cycle
    init(toDosManager: ToDoManager = SwiftDataManager(), type: DetailType = .new, id: UUID = .init(), titleTextField: String = .init(), descriptionTextField: String = .init(), isFinished: Bool = false) {
        self.toDosManager = toDosManager
        self.type = type
        self.id = id
        self.titleTextField = titleTextField
        self.descriptionTextField = descriptionTextField
        self.isFinished = isFinished
    }

    // MARK: Helpers
    func save(title: String, description: String) -> Result<Bool, Error> {
        switch type {
        case .new:
            if title != "" && description != "" {
                toDosManager.addNewData(title: title, description: description)
                return .success(true)
            } else {
                return .failure(SaveError.badData("Invalid data"))
            }
        case .update:
            if title != "" && description != "" {
                toDosManager.updateData(id: id, title: title, description: description, isFinished: false)
                return .success(true)
            } else {
                return .failure(SaveError.badData("Invalid data"))
            }
        }


    }

    enum SaveError: Error {
        case badData(String)
    }
}



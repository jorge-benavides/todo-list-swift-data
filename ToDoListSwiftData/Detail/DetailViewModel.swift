//
//  DetailViewModel.swift
//  ToDoListSwiftData
//
//  Created by Carlos Barron on 31/08/24.
//

import Foundation

protocol DetailViewProtocol {
    var id: UUID { get }
    var type: DetailType { get }
    func save(title: String, description: String) -> Result<Bool, Error>
}

class DetailViewModel: DetailViewProtocol {

    var type: DetailType
    var id: UUID

    private let toDosManager: ToDoManager

    init(toDosManager: ToDoManager = SwiftDataManager(), id: UUID = UUID(), type: DetailType = .new) {
        self.toDosManager = toDosManager
        self.id = id
        self.type = type
    }

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



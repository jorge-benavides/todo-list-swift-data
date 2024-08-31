//
//  DetailViewModel.swift
//  ToDoListSwiftData
//
//  Created by Carlos Barron on 31/08/24.
//

import Foundation

protocol DetailViewProtocol {
    func save(title: String, description: String) -> Result<Bool, Error>
}

class DetailViewModel: DetailViewProtocol {

    private let toDosManager: ToDoManager

    init(toDosManager: ToDoManager = SwiftDataManager()) {
        self.toDosManager = toDosManager
    }

    func save(title: String, description: String) -> Result<Bool, Error> {
        if title != "" && description != "" {
            toDosManager.addNewData(title: title, description: description)
            return .success(true)
        } else {
            return .failure(SaveError.badData("Invalid data"))
        }
    }

    enum SaveError: Error {
        case badData(String)
    }
}



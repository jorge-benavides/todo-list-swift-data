//
//  SwiftDataManager.swift
//  ToDoListSwiftData
//
//  Created by Jorge Benavides Ojinaga on 05/09/24.
//

import Foundation
import SwiftData

protocol SwiftDataManager {
    func insert<Model>(_ models: Model...) where Model : PersistentModel
    func delete<Model>(_ models: Model...) where Model : PersistentModel
    func delete<Model>(_ predicate: Predicate<Model>?) throws where Model : PersistentModel
    func get<Model>(_ id: PersistentIdentifier) -> Model? where Model : PersistentModel
    func find<Model>(_ predicate: Predicate<Model>?, sortBy sortDescriptors: [SortDescriptor<Model>]) throws -> [Model] where Model : PersistentModel
    func save() throws
}

extension SwiftDataManager {
    func find<Model>() throws -> [Model] where Model : PersistentModel {
        try find(nil)
    }
    func find<Model>(_ predicate: Predicate<Model>?) throws -> [Model] where Model : PersistentModel {
        try find(predicate, sortBy: [])
    }
}

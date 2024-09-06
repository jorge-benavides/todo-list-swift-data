//
//  DataSource.swift
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

final class ConfigurableSwiftDataManager: SwiftDataManager {
    private let context: ModelContext

    init(modelConfiguration: ModelConfiguration) throws {
        guard let schema = modelConfiguration.schema 
        else { throw SwiftDataError.unknownSchema }
        context = ModelContext(
            try ModelContainer(
                for: schema, 
                configurations: modelConfiguration
            )
        )
    }

    // MARK: Writing context data

    func insert<Model: PersistentModel>(_ models: Model...) {
        for model in models {
            context.insert(model)
        }
    }

    // MARK: Deleting context data

    func delete<Model: PersistentModel>(_ models: Model...) {
        for model in models {
            context.delete(model)
        }
    }

    func delete<Model: PersistentModel>(_ predicate: Predicate<Model>? = nil) throws {
        try context.delete(model: Model.self, where: predicate, includeSubclasses: true)
    }

    // MARK: Reading context data

    func get<Model: PersistentModel>(_ id: PersistentIdentifier) -> Model? {
        context.registeredModel(for: id)
    }

    func find<Model: PersistentModel>(
        _ predicate: Predicate<Model>? = nil,
        sortBy sortDescriptors: [SortDescriptor<Model>] = []
    ) throws -> [Model] {
        try context.fetch(
            FetchDescriptor(
                predicate: predicate, 
                sortBy: sortDescriptors
            )
        )
    }

    // MARK: Save context

    func save() throws {
        try context.save()
    }
}

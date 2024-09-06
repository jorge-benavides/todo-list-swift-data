//
//  MainDataManager.swift
//  ToDoListSwiftData
//
//  Created by Jorge Benavides Ojinaga on 05/09/24.
//

import Foundation
import SwiftData

final class MainDataManager: SwiftDataManager {

    private let context: ModelContext

    init() throws {
        let container = try! ModelContainer(
            for: CurrentSchema.ToDo.self,
            migrationPlan: MainMigrationPlan.self,
            configurations: ModelConfiguration(schema: Schema([CurrentSchema.ToDo.self], version: CurrentSchema.versionIdentifier), allowsSave: true)
        )
        context = ModelContext(container)
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


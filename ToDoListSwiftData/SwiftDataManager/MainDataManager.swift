//
//  MainDataManager.swift
//  ToDoListSwiftData
//
//  Created by Jorge Benavides Ojinaga on 05/09/24.
//

import Foundation
import SwiftData

typealias CurrentSchema = SchemaV3
typealias ToDo = CurrentSchema.ToDo

enum DataMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [SchemaV1.self, SchemaV2.self, SchemaV3.self]
    }

    static var stages: [MigrationStage] {
        [migrationV1ToV2, migrationV2ToV3]
    }

    static let migrationV1ToV2: MigrationStage = .lightweight(fromVersion: SchemaV1.self, toVersion: SchemaV2.self)

    static let migrationV2ToV3: MigrationStage = .custom(
        fromVersion: SchemaV2.self,
        toVersion: SchemaV3.self,
        willMigrate: { context in
            let todos = try context.fetch(FetchDescriptor<SchemaV2.ToDo>())
            for todo in todos {
                todo.title = todo.title + " v3"
            }
            try context.save()
        },
        didMigrate: { context in
            let todos = try context.fetch(FetchDescriptor<SchemaV3.ToDo>())
            for todo in todos {
                todo.category = "default value from migration"
            }
            try context.save()
        }
    )
}

final class MainDataManager: SwiftDataManager {

    private let context: ModelContext

    init() throws {
        let container = try! ModelContainer(
            for: CurrentSchema.ToDo.self,
            migrationPlan: DataMigrationPlan.self,
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


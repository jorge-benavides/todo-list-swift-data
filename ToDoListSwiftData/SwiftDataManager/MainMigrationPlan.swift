//
//  MainMigrationPlan.swift
//  ToDoListSwiftData
//
//  Created by Jorge Benavides Ojinaga on 05/09/24.
//

import Foundation
import SwiftData

typealias CurrentSchema = SchemaV1
typealias ToDo = CurrentSchema.ToDo

enum MainMigrationPlan: SchemaMigrationPlan {
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

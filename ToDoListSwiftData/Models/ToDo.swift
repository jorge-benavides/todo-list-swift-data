//
//  ToDo.swift
//  ToDoListSwiftData
//
//  Created by Carlos Barron on 31/08/24.
//

import Foundation
import SwiftData

enum SchemaV1: VersionedSchema {
    static var versionIdentifier: Schema.Version = .init(1, 0, 0)

    static var models: [any PersistentModel.Type] {
        [SchemaV1.ToDo.self]
    }

    @Model
    class ToDo {
        @Attribute(.unique)
        var title: String
        var toDoDescription: String
        var isFinished: Bool

        init(
            title: String,
            toDoDescription: String,
            isFinished: Bool = false
        ) {
            self.title = title
            self.toDoDescription = toDoDescription
            self.isFinished = isFinished
        }
    }

}

enum SchemaV2: VersionedSchema {
    static var versionIdentifier: Schema.Version = .init(1, 1, 0)

    static var models: [any PersistentModel.Type] {
        [SchemaV2.ToDo.self]
    }

    @Model
    final class ToDo {
        @Attribute(.unique)
        var title: String
        @Attribute(originalName: "toDoDescription")
        var extraDescription: String
        var isFinished: Bool

        init(
            title: String,
            toDoDescription: String,
            isFinished: Bool = false
        ) {
            self.title = title
            self.extraDescription = toDoDescription
            self.isFinished = isFinished
        }

        var toDoDescription: String {
            get { extraDescription }
            set { extraDescription = newValue}
        }
    }
}

enum SchemaV3: VersionedSchema {
    static var versionIdentifier: Schema.Version = .init(1, 2, 0)

    static var models: [any PersistentModel.Type] {
        [SchemaV3.ToDo.self]
    }

    @Model
    final class ToDo {
        @Attribute(.unique)
        var title: String
        @Attribute(originalName: "toDoDescription")
        var extraDescription: String
        var category: String = ""
        var isFinished: Bool

        init(
            title: String,
            toDoDescription: String,
            category: String = "New category",
            isFinished: Bool = false
        ) {
            self.title = title
            self.extraDescription = toDoDescription
            self.category = category
            self.isFinished = isFinished
        }

        var toDoDescription: String {
            get { extraDescription }
            set { extraDescription = newValue}
        }
    }
}

//
//  ToDo.swift
//  ToDoListSwiftData
//
//  Created by Carlos Barron on 31/08/24.
//

import Foundation
import SwiftData

@Model
class ToDo {
    @Attribute(.unique) var id: UUID
    var title: String
    var toDoDescription: String
    var isFinished: Bool

    init(id: UUID, title: String, toDoDescription: String, isFinished: Bool) {
        self.id = id
        self.title = title
        self.toDoDescription = toDoDescription
        self.isFinished = isFinished
    }
}

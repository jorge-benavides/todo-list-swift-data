//
//  SwiftDataManager.swift
//  ToDoListSwiftData
//
//  Created by Carlos Barron on 31/08/24.
//

import Foundation
import SwiftData

protocol ToDoManager {
    func addNewData(title: String, description: String)
    func updateData(id: UUID, title: String, description: String, isFinished: Bool)
    func fetchData() -> [ToDo]
    func deleteData(toDo: ToDo)
}

class SwiftDataManager: ToDoManager {

    static let shared: ToDoManager = SwiftDataManager()

    private var container: ModelContainer?

    private init() {
        do {
            container = try ModelContainer(for: ToDo.self)
        } catch {
            print(error.localizedDescription)
        }
    }

    @MainActor 
    func addNewData(title: String, description: String) {
        container?.mainContext.insert(ToDo(id: UUID(), title: title, toDoDescription: description, isFinished: false))
    }

    @MainActor
    func updateData(id: UUID, title: String, description: String, isFinished: Bool) {
        container?.mainContext.insert(ToDo(id: id, title: title, toDoDescription: description, isFinished: isFinished))
    }

    @MainActor 
    func fetchData() -> [ToDo] {
        do {
            let descriptor = FetchDescriptor<ToDo>()
            guard let items = try container?.mainContext.fetch(descriptor) else {
                return []
            }

            return items
        } catch {
            print(error.localizedDescription)
            return []
        }
    }

    @MainActor
    func deleteData(toDo: ToDo) {
        container?.mainContext.delete(toDo)
    }
}

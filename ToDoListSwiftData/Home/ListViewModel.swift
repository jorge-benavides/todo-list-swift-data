//
//  ListViewModel.swift
//  ToDoListSwiftData
//
//  Created by Carlos Barron on 31/08/24.
//

import Foundation

class ListViewModel {

    private let toDosManager: ToDoManager
    private var toDos: [ToDo]

    init(toDosManager: ToDoManager = SwiftDataManager()) {
        self.toDosManager = toDosManager
        toDos = self.toDosManager.fetchData()
    }

    func count() -> Int {
        toDos.count
    }

    func getListCellViewModel(at index: Int) -> ListCellViewModel {
        let item = toDos[index]
        return ListCellViewModel(uuid: item.id.uuidString, title: item.title, description: item.toDoDescription, isFinished: item.isFinished)
    }

    func deleteItem(at index: Int, completion: () -> ()) {
        let toDo = toDos[index]
        toDosManager.deleteData(toDo: toDo)
        toDos = self.toDosManager.fetchData()
        completion()
    }
}

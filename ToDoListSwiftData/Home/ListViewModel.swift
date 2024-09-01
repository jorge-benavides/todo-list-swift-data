//
//  ListViewModel.swift
//  ToDoListSwiftData
//
//  Created by Carlos Barron on 31/08/24.
//

import Foundation

protocol ListViewProtocol {
    func count() -> Int
    func updateTodos()
    func getListCellViewModel(at index: Int) -> ListCellViewModel
    func deleteItem(at index: Int, completion: () -> ())
    func getListDetailsViewModel(at index: Int) -> DetailViewProtocol
}

class ListViewModel: ListViewProtocol {

    private let toDosManager: ToDoManager
    private var toDos: [ToDo] = []

    init(toDosManager: ToDoManager = SwiftDataManager.shared) {
        self.toDosManager = toDosManager
    }

    func count() -> Int {
        toDos.count
    }

    func updateTodos() {
        toDos = self.toDosManager.fetchData()
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

    func getListDetailsViewModel(at index: Int) -> DetailViewProtocol {
        let toDo = toDos[index]
        let viewModel = DetailViewModel(type: .update, id: toDo.id, titleTextField: toDo.title, descriptionTextField: toDo.toDoDescription, isFinished: toDo.isFinished)
        return viewModel
    }
}

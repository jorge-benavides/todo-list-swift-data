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
    func deleteItem(at index: Int)
    func getListDetailsViewModel() -> DetailViewProtocol
    func getListDetailsViewModel(at index: Int) -> DetailViewProtocol
}

class ListViewModel: ListViewProtocol {

    private let dataManager: SwiftDataManager
    private var toDos: [ToDo] = []

    init(_ dataManager: SwiftDataManager) {
        self.dataManager = dataManager
    }

    func count() -> Int {
        toDos.count
    }

    func updateTodos() {
        toDos = (try? dataManager.find()) ?? []
    }

    func getListCellViewModel(at index: Int) -> ListCellViewModel {
        let item = toDos[index]
        return ListCellViewModel(title: item.title, description: item.toDoDescription, isFinished: item.isFinished)
        // after migration we can use category
        //return ListCellViewModel(title: item.title, description: "\(item.category): \(item.toDoDescription)", isFinished: item.isFinished)
    }

    func deleteItem(at index: Int) {
        dataManager.delete(toDos.remove(at: index))
    }

    func getListDetailsViewModel() -> DetailViewProtocol {
        return DetailViewModel(dataManager)
    }

    func getListDetailsViewModel(at index: Int) -> DetailViewProtocol {
        let toDo = toDos[index]
        let viewModel = DetailViewModel(dataManager, id: toDo.id)
        return viewModel
    }
}

//
//  ListViewCoordinator.swift
//  ToDoListSwiftData
//
//  Created by Carlos Barron on 31/08/24.
//

import UIKit

protocol Coordinator {
    func start()
}

class AppCoordinator: Coordinator {

    private let window: UIWindow
    private let listViewController: ListViewController
    private let listViewModel: ListViewModel
    private let navigationController: UINavigationController

    init(listViewModel: ListViewModel = ListViewModel(toDosManager: SwiftDataManager()), window: UIWindow) {
        self.listViewModel = listViewModel
        listViewController = ListViewController(viewModel: self.listViewModel)
        navigationController = UINavigationController(rootViewController: listViewController)
        self.window = window
    }

    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

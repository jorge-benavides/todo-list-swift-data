//
//  DetailViewCoordinator.swift
//  ToDoListSwiftData
//
//  Created by Carlos Barron on 31/08/24.
//

import UIKit

enum DetailType {
    case new
    case update
}

class DetailViewCoordinator: Coordinator {
    
    private let detailViewController: DetailViewController
    private let detailViewModel: DetailViewProtocol
    private let navigationController: UINavigationController

    init(detailViewModel: DetailViewProtocol = DetailViewModel(toDosManager: SwiftDataManager()), navigationController: UINavigationController) {
        self.detailViewModel = detailViewModel
        self.detailViewController = DetailViewController(viewModel: detailViewModel)
        self.navigationController = navigationController
    }

    func start() {
        navigationController.pushViewController(detailViewController, animated: true)
    }
}

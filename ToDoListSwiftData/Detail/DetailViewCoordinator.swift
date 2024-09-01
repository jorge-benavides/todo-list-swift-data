//
//  DetailViewCoordinator.swift
//  ToDoListSwiftData
//
//  Created by Carlos Barron on 31/08/24.
//

import UIKit

enum DetailType {
    case new
    case withData
}

class DetailViewCoordinator: Coordinator {
    
    private let detailViewController: DetailViewController
    private let detailViewModel: DetailViewModel
    private let type: DetailType
    private let navigationController: UINavigationController

    init(detailViewModel: DetailViewModel = DetailViewModel(toDosManager: SwiftDataManager()), type: DetailType, navigationController: UINavigationController) {
        self.detailViewModel = detailViewModel
        self.detailViewController = DetailViewController(viewModel: detailViewModel)
        self.type = type
        self.navigationController = navigationController
    }

    func start() {
        switch type {
        case .new:
            navigationController.pushViewController(detailViewController, animated: true)
        case .withData:
            print("TO DO")
        }
    }
}

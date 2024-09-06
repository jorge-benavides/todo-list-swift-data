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
    private let detailViewModel: DetailViewProtocol
    private let navigationController: UINavigationController

    init(detailViewModel: DetailViewProtocol, navigationController: UINavigationController) {
        self.detailViewModel = detailViewModel
        self.navigationController = navigationController
    }

    func start() {
        navigationController.pushViewController(DetailViewController(viewModel: detailViewModel), animated: true)
    }
}

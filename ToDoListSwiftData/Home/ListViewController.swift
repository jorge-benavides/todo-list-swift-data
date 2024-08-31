//
//  ListViewController.swift
//  ToDoListSwiftData
//
//  Created by Carlos Barron on 31/08/24.
//

import UIKit

class ListViewController: UIViewController {

    // MARK: Properties
    private lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        button.tintColor = .wizelineBlue
        return button
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: Helpers
    private func configureUI() {
        title = Constants.title
        view.backgroundColor = .wizelineLightGrey
        self.navigationController?.navigationItem.rightBarButtonItem = addButton
        navigationItem.rightBarButtonItem = addButton
    }

    @objc private func addTapped() {

    }
}

// MARK: Extensions

extension ListViewController {
    private enum Constants {
        static let title = "List"
    }
}

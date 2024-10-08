//
//  ListViewController.swift
//  ToDoListSwiftData
//
//  Created by Carlos Barron on 31/08/24.
//

import UIKit

class ListViewController: UIViewController {

    // MARK: Properties
    private let viewModel: ListViewProtocol

    private lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        button.tintColor = .wizelineBlue
        return button
    }()

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        return table
    }()

    private lazy var noDataView: NoDataView = {
        let view = NoDataView()
        return view
    }()

    // MARK: Lifecycle
    init(viewModel: ListViewProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        viewModel.updateTodos()
        tableView.reloadData()
    }

    // MARK: Helpers
    private func configureUI() {
        title = Constants.title
        view.backgroundColor = .wizelineLightGrey
        self.navigationController?.navigationItem.rightBarButtonItem = addButton
        self.navigationController?.navigationBar.barTintColor = .wizelineRed
        tabBarController?.tabBar.tintColor = .wizelineRed
        navigationItem.rightBarButtonItem = addButton

        view.addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: Constants.standardSpacing).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.standardSpacing).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: Constants.minusStandardSpacing).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constants.minusStandardSpacing).isActive = true
        self.tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.identifier)

        configureNavBar()
    }

    private func configureNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .wizelineRed
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    @objc private func addTapped() {
        guard let navigationController = navigationController else { return }
        let viewModel = viewModel.getListDetailsViewModel()
        let coordinator = DetailViewCoordinator(detailViewModel: viewModel, navigationController: navigationController)
        coordinator.start()
    }
}

// MARK: Extensions

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundView = viewModel.count() > .zero ? nil : noDataView
        return viewModel.count() > .zero ? viewModel.count() : .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.identifier, for: indexPath) as! ToDoTableViewCell
        cell.listCellViewModel = viewModel.getListCellViewModel(at: indexPath.row)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navigationController = navigationController else { return }
        let viewModel = viewModel.getListDetailsViewModel(at: indexPath.row)
        let coordinator = DetailViewCoordinator(detailViewModel: viewModel, navigationController: navigationController)
        coordinator.start()
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
}

extension ListViewController {
    private enum Constants {
        static let title = "List"
        static let standardSpacing: CGFloat = 8.0
        static let minusStandardSpacing: CGFloat = -8.0
    }
}

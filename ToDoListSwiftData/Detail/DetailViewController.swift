//
//  DetailViewController.swift
//  ToDoListSwiftData
//
//  Created by Carlos Barron on 31/08/24.
//

import UIKit

class DetailViewController: UIViewController {

    //MARK: Properties
    private let viewModel: DetailViewProtocol

    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = Constants.titlePlaceholder
        textField.delegate = self
        textField.becomeFirstResponder()
        return textField
    }()

    private lazy var descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = Constants.descriptionPlaceholder
        textField.delegate = self
        return textField
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = Constants.textFieldsSpacing
        return stackView
    }()

    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .wizelineRed
        button.tintColor = .white
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        button.setTitle(Constants.buttonTitle, for: .normal)
        button.layer.cornerRadius = Constants.cornerRadius
        button.layer.masksToBounds = true
        return button
    }()

    private lazy var loader: UIAlertController = {
        let loader = UIAlertController(title: nil, message: "Saving, please wait...", preferredStyle: .alert)
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        indicator.hidesWhenStopped = true
        indicator.style = .large
        indicator.startAnimating()
        loader.view.addSubview(indicator)
        return loader
    }()

    // MARK: Life cycle
    init(viewModel: DetailViewProtocol) {
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

    // MARK: Helpers
    private func configureUI() {
        view.backgroundColor = .wizelineLightGrey
        view.addSubview(stackView)
        stackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: Constants.standardSpacing).isActive = true
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.standardSpacing).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: Constants.minusStandardSpacing).isActive = true
        stackView.addArrangedSubview(titleTextField)
        titleTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        stackView.addArrangedSubview(descriptionTextField)
        descriptionTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        view.addSubview(saveButton)
        saveButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: Constants.standardSpacing).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constants.minusStandardSpacing).isActive = true
        saveButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: Constants.minusStandardSpacing).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: Constants.buttonheight).isActive = true

        if viewModel.type == .update {
            titleTextField.text = viewModel.titleTextField
            descriptionTextField.text = viewModel.descriptionTextField
        }
    }

    @objc private func saveButtonTapped() {
        let result = viewModel.save(title: titleTextField.text ?? "", description: descriptionTextField.text ?? "")

        switch result {
        case .success:
            self.present(loader, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.loader.dismiss(animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
            }
        case .failure(let error):
            let alertViewController = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: .alert)
            alertViewController.addAction(.init(title: "Ok", style: .destructive))
            self.present(alertViewController, animated: true)
        }
    }
}

// MARK: Extensions
extension DetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        descriptionTextField.resignFirstResponder()
        return true
    }
}

extension DetailViewController {
    private enum Constants {
        static let standardSpacing: CGFloat = 8.0
        static let minusStandardSpacing: CGFloat = -8.0
        static let buttonheight: CGFloat = 50
        static let borderWith: CGFloat = 1.5
        static let cornerRadius: CGFloat = 15.0
        static let textFieldsSpacing: CGFloat = 15
        static let buttonTitle: String = "Save"
        static let titlePlaceholder: String = "Enter title"
        static let descriptionPlaceholder: String = "Enter Description"
    }
}

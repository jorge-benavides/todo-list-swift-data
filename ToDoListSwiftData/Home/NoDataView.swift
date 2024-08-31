//
//  NoDataView.swift
//  ToDoListSwiftData
//
//  Created by Carlos Barron on 31/08/24.
//

import UIKit

class NoDataView: UIView {

    // MARK: Properties
    private let noDataImage: UIImageView = {
        let image = UIImageView(image: .noData)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .wizelineRed
        return image
    }()

    private let noDataLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: Constants.fontSize)
        label.text = Constants.title
        return label
    }()

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        return stack
    }()

    // MARK: Life cycle
    init() {
        super.init(frame: .init())
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Helpers
    private func configureUI() {
        addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        stackView.addArrangedSubview(noDataImage)
        stackView.addArrangedSubview(noDataLabel)

        noDataImage.widthAnchor.constraint(equalToConstant: Constants.imageWidth).isActive = true
        noDataImage.heightAnchor.constraint(equalToConstant: Constants.imageHeight).isActive = true
    }
}

// MARK: Extensions
extension NoDataView {
    private enum Constants {
        static let imageHeight: CGFloat = 250
        static let imageWidth: CGFloat = 200
        static let fontSize: CGFloat = 25
        static let title: String = "No Data"
    }
}

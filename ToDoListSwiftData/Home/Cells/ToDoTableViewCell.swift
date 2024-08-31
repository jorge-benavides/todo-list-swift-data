//
//  ToDoTableViewCell.swift
//  ToDoListSwiftData
//
//  Created by Carlos Barron on 31/08/24.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {

    // MARK: Properties
    static let identifier: String = String(describing: ToDoTableViewCell.self)

    var listCellViewModel: ListCellViewModel = ListCellViewModel(uuid: "", title: "", description: "", isFinished: false) {
        didSet {
            self.titleLabel.text = listCellViewModel.getData().title
            self.descriptionLabel.text = listCellViewModel.getData().description
            self.checkImage.image = listCellViewModel.getData().isFinished ? UIImage(named: "checkmark.circle") : UIImage(systemName: "checkmark.circle.fill")
        }
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = .zero
        label.text = "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto."
        label.textAlignment = .justified
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = .zero
        label.text = "Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta)"
        label.font = .italicSystemFont(ofSize: 13)
        return label
    }()

    private let checkImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "checkmark.circle"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .wizelineRed
        return image
    }()

    // MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK: Helpers

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func configureUI() {
        contentView.addSubview(checkImage)
        checkImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        checkImage.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor, constant: -8.0).isActive = true
        checkImage.widthAnchor.constraint(equalToConstant: 35).isActive = true
        checkImage.heightAnchor.constraint(equalToConstant: 35).isActive = true

        contentView.addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 8.0).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8.0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: checkImage.leftAnchor, constant: -8.0).isActive = true
        checkImage.topAnchor.constraint(greaterThanOrEqualTo: titleLabel.topAnchor).isActive = true

        contentView.addSubview(descriptionLabel)
        descriptionLabel.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 8.0).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: checkImage.leftAnchor, constant: -8.0).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -8.0).isActive = true
        checkImage.bottomAnchor.constraint(lessThanOrEqualTo: descriptionLabel.bottomAnchor, constant: -8.0).isActive = true
    }

}

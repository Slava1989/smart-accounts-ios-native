//
//  FormField.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 03.01.2023.
//

import UIKit

final class AddAccountFormField: UIView {
    private var isExpandable: Bool = false
    private var title: String = ""

    private lazy var fieldTitle: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont(name: "Helvetica", size: 13)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var fieldValue: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Helvetica", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var textFieldValue: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "Helvetica", size: 17)
        textField.borderStyle = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var chevronImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.down")
        imageView.tintColor = .darkGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var expandableStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(frame: CGRect, isExpandable: Bool, title: String) {
        self.init(frame: frame)

        self.isExpandable = isExpandable
        self.title = title

        setupUI()
//        configureField()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.addSubview(containerStackView)
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: self.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])

        containerStackView.addArrangedSubview(fieldTitle)
        containerStackView.addArrangedSubview(expandableStackView)
        containerStackView.addArrangedSubview(separatorView)
        NSLayoutConstraint.activate([
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])


        if isExpandable {
            expandableStackView.addArrangedSubview(fieldValue)
            expandableStackView.addArrangedSubview(chevronImage)
            NSLayoutConstraint.activate([
                chevronImage.widthAnchor.constraint(equalToConstant: 20),
                chevronImage.heightAnchor.constraint(equalToConstant: 20)
            ])
        } else {
            expandableStackView.addArrangedSubview(textFieldValue)
            NSLayoutConstraint.activate([
                textFieldValue.heightAnchor.constraint(equalToConstant: 35)
            ])
        }
    }

    func setupDefault(value: String) {
        fieldTitle.text = title
        fieldValue.text = value
    }

    func setupValue(option: String) {
        fieldValue.text = option
    }
}

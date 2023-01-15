//
//  SearchTextField.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 09.01.2023.
//

import UIKit

protocol SearchTextFieldDelegate: AnyObject {
    func didChaneText(text: String)
    func didTapFilter()
}

final class SearchTextField: UIView {

    weak var delegate: SearchTextFieldDelegate?

    private lazy var magnifyingGlassImageView: UIImageView = {
        let uiImageView = UIImageView()
        uiImageView.image = UIImage(systemName: "magnifyingglass")
        uiImageView.contentMode = .scaleAspectFill
        uiImageView.tintColor = .lightGray
        uiImageView.translatesAutoresizingMaskIntoConstraints = false
        return uiImageView
    }()

    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.resignFirstResponder()
        textField.addTarget(self, action: #selector(didChaneText), for: .editingChanged)
        textField.selectedTextRange = nil
        textField.placeholder = "Cauta in tranzactii"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var filterImageView: UIImageView = {
        let uiImageView = UIImageView()
        uiImageView.image = UIImage(systemName: "slider.horizontal.3")
        uiImageView.tintColor = .black
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapFilter))
        uiImageView.addGestureRecognizer(tapGesture)
        uiImageView.isUserInteractionEnabled = true
        uiImageView.translatesAutoresizingMaskIntoConstraints = false
        return uiImageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func didTapFilter() {
        delegate?.didTapFilter()
    }

    @objc private func didChaneText(textField: UITextField) {
        delegate?.didChaneText(text: textField.text ?? "")
    }

    private func setupUI() {
        self.addSubview(magnifyingGlassImageView)
        NSLayoutConstraint.activate([
            magnifyingGlassImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            magnifyingGlassImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            magnifyingGlassImageView.widthAnchor.constraint(equalToConstant: 20),
            magnifyingGlassImageView.heightAnchor.constraint(equalToConstant: 30),
        ])

        self.addSubview(searchTextField)
        NSLayoutConstraint.activate([
            searchTextField.leadingAnchor.constraint(equalTo: magnifyingGlassImageView.trailingAnchor, constant: 20),
            searchTextField.topAnchor.constraint(equalTo: self.topAnchor),
            searchTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        self.addSubview(filterImageView)
        NSLayoutConstraint.activate([
            filterImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            filterImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            filterImageView.leadingAnchor.constraint(equalTo: searchTextField.trailingAnchor, constant: 20),
            filterImageView.widthAnchor.constraint(equalToConstant: 20),
            filterImageView.heightAnchor.constraint(equalToConstant: 20),
        ])
    }

}

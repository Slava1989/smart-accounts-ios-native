//
//  AddAccountViewController.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 03.01.2023.
//

import UIKit

final class AddAccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    weak var viewModel: AddAccountViewModelInput?

    private lazy var disclaimerContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var disclaimerLabel: UILabel = {
        let label = UILabel()
        label.text = "Please keep in mind that the data displayed will refresh every 60 minutes from the first time is displayed on this dashboard!"
        label.font = UIFont(name: "Helvetica", size: 15)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var infoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "info.circle.fill")
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var bankListContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var tableView: UITableView = {
        let tablewView = UITableView()
        tablewView.delegate = self
        tablewView.dataSource = self
        tablewView.translatesAutoresizingMaskIntoConstraints = false
        return tablewView
    }()

    init(viewModel: AddAccountViewModelInput) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "lightGray")
        setupUI()
    }

    private func setupUI() {
        view.addSubview(disclaimerContainer)
        NSLayoutConstraint.activate([
            disclaimerContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            disclaimerContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            disclaimerContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            disclaimerContainer.heightAnchor.constraint(equalToConstant: 90)
        ])

        disclaimerContainer.addSubview(infoImageView)
        NSLayoutConstraint.activate([
            infoImageView.topAnchor.constraint(equalTo: disclaimerContainer.topAnchor, constant: 5),
            infoImageView.trailingAnchor.constraint(equalTo: disclaimerContainer.trailingAnchor, constant: -5),
            infoImageView.heightAnchor.constraint(equalToConstant: 25),
            infoImageView.widthAnchor.constraint(equalToConstant: 25)
        ])

        disclaimerContainer.addSubview(disclaimerLabel)
        NSLayoutConstraint.activate([
            disclaimerLabel.topAnchor.constraint(equalTo: disclaimerContainer.topAnchor, constant: 15),
            disclaimerLabel.leadingAnchor.constraint(equalTo: disclaimerContainer.leadingAnchor, constant: 15),
            disclaimerLabel.trailingAnchor.constraint(equalTo: infoImageView.leadingAnchor, constant: 40)
        ])

        view.addSubview(bankListContainer)
        NSLayoutConstraint.activate([
            bankListContainer.topAnchor.constraint(equalTo: disclaimerContainer.bottomAnchor, constant: 10),
            bankListContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            bankListContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            bankListContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }

    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}

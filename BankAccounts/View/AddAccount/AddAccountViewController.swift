//
//  AddAccountViewController.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 03.01.2023.
//

import UIKit
import Combine

final class AddAccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SetupViewDelegate {
    private var viewModel: AddAccountViewModelInput
    private var banks: [Bank] = []
    private var heightConstraint: NSLayoutConstraint?
    private var cancellable = Set<AnyCancellable>()
    private var lastHeightConstant: Double = 0.0
    private var selectedBank: Bank?

    private lazy var contentContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

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
        tablewView.separatorStyle = .none
        tablewView.register(BankCell.self, forCellReuseIdentifier: "bankCell")
        tablewView.translatesAutoresizingMaskIntoConstraints = false
        return tablewView
    }()

    private lazy var setupView: SetupView = {
        let setupView = SetupView(frame: .zero)
        setupView.delegate = self
        setupView.translatesAutoresizingMaskIntoConstraints = false
        return setupView
    }()

    init(viewModel: AddAccountViewModelInput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "lightGray")
        setupUI()
        getBanks()
    }

    private func setupUI() {
        view.addSubview(contentContainerView)
        NSLayoutConstraint.activate([
            contentContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        contentContainerView.addSubview(disclaimerContainer)
        NSLayoutConstraint.activate([
            disclaimerContainer.topAnchor.constraint(equalTo: contentContainerView.topAnchor, constant: 10),
            disclaimerContainer.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor, constant: 10),
            disclaimerContainer.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor, constant: -10),
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

        contentContainerView.addSubview(bankListContainer)
        NSLayoutConstraint.activate([
            bankListContainer.topAnchor.constraint(equalTo: disclaimerContainer.bottomAnchor, constant: 10),
            bankListContainer.leadingAnchor.constraint(equalTo: contentContainerView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            bankListContainer.trailingAnchor.constraint(equalTo: contentContainerView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            bankListContainer.bottomAnchor.constraint(equalTo: contentContainerView.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])

        bankListContainer.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: bankListContainer.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: bankListContainer.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: bankListContainer.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: bankListContainer.bottomAnchor)
        ])

        view.addSubview(setupView)
        NSLayoutConstraint.activate([
            setupView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            setupView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            setupView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    private func getBanks() {
        viewModel.fetchBanks()
        viewModel.subject.sink(receiveCompletion: { completion in

        }, receiveValue: { [weak self] banks in
            self?.banks = banks
            self?.tableView.reloadData()
        }).store(in: &cancellable)
    }

    private func prepareSetupAccountView() {
        disclaimerContainer.backgroundColor = .gray
        contentContainerView.backgroundColor = .gray
        bankListContainer.backgroundColor = .gray

        disclaimerContainer.alpha = 0.4
        contentContainerView.alpha = 0.4
        bankListContainer.alpha = 0.4

        contentContainerView.isUserInteractionEnabled = false
        setupView.backgroundColor = .white

        if let heightConstraint = heightConstraint {
            heightConstraint.constant = 250
        } else {
            heightConstraint = setupView.heightAnchor.constraint(equalToConstant: 250)
            heightConstraint?.isActive = true
        }

        UIView.animate(withDuration: 0.5, delay: 0) {

            self.view.layoutIfNeeded()
        }
    }

    private func closeAccountView() {
        disclaimerContainer.backgroundColor = .white
        contentContainerView.backgroundColor = .white
        bankListContainer.backgroundColor = .white

        disclaimerContainer.alpha = 1
        contentContainerView.alpha = 1
        bankListContainer.alpha = 1

        contentContainerView.isUserInteractionEnabled = true
        setupView.backgroundColor = .white

        self.view.superview?.layoutIfNeeded()

        heightConstraint?.constant = 0

        UIView.animate(withDuration: 0.5, delay: 0) {

            self.view.layoutIfNeeded()
        }
    }

    private func configureSetupAccontView(bankTitle: String) {
        setupView.setBankTitle(bankTitle: bankTitle)
    }

    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        prepareSetupAccountView()
        configureSetupAccontView(bankTitle: banks[indexPath.row].name)
        selectedBank = banks[indexPath.row]

        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return banks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let bankCell = tableView.dequeueReusableCell(withIdentifier: "bankCell", for: indexPath) as? BankCell else {
            return UITableViewCell()
        }

        bankCell.config(bank: banks[indexPath.row])
        return bankCell
    }

    //MARK: SetupViewDelegate
    func didTapClose() {
        closeAccountView()
        setupView.resetView()
    }

    func showAccountTitleField() {
        heightConstraint?.constant += 100
        UIView.animate(withDuration: 0.5, delay: 0) {

            self.view.layoutIfNeeded()
        }
    }

    func showCurrencyFormField() {
        heightConstraint?.constant += 100
        UIView.animate(withDuration: 0.5, delay: 0) {

            self.view.layoutIfNeeded()
        }
    }

    func showCurrencyTableView() {
        lastHeightConstant = Double(heightConstraint?.constant ?? 0.0)
        heightConstraint?.constant = 250
        UIView.animate(withDuration: 0.5, delay: 0) {
            self.view.layoutIfNeeded()
        }
    }

    func hideCurrencyTableView() {
        heightConstraint?.constant = lastHeightConstant != 0 ? lastHeightConstant :  250
    }

    func sendRequest() {
        heightConstraint?.constant = 250
        viewModel.goToWebPage(bankURL: selectedBank?.url ?? "")
        setupView.resetView()
    }

    func showPeriodTableView() {

    }
}

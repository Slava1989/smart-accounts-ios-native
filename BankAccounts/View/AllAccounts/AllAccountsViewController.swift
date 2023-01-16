//
//  ViewController.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 02.01.2023.
//

import UIKit
import Charts
import Combine

final class AllAccountsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private var viewModel: AccountsViewModelInput
    private var bankAccounts: [BankAccount] = []
    private var cancellable = Set<AnyCancellable>()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        label.text = "Conturile tale"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var pieChartView: PieChartView = {
        let pieChartView = PieChartView()
        pieChartView.legend.enabled = false
        pieChartView.holeRadiusPercent = 0.35
        pieChartView.transparentCircleRadiusPercent = 0

        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        formatter.multiplier = 1.0
        pieChartView.data?.setValueFormatter(formatter as! ValueFormatter)

        pieChartView.highlightPerTapEnabled = false
        pieChartView.isUserInteractionEnabled = false
        pieChartView.contentMode = .scaleAspectFit
        pieChartView.translatesAutoresizingMaskIntoConstraints = false
        return pieChartView
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BankAccountCell.self, forCellReuseIdentifier: "bankAccountCell")
        tableView.register(TotalAmountCell.self, forCellReuseIdentifier: "totalAmountCell")
        tableView.register(AllTransactionsCell.self, forCellReuseIdentifier: "allTransactionsCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private lazy var addAccountButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "red")
        button.setTitle("Adauga un cont", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapAddAccount), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    init(viewModel: AccountsViewModelInput) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "lightGray")

        getBankAccounts()
        setupChart()
        setupUI()
    }

    private func getBankAccounts() {
        viewModel.subject.sink { complete in

        } receiveValue: { [weak self] bankAccounts in
            self?.bankAccounts = bankAccounts
            self?.tableView.reloadData()
        }.store(in: &cancellable)
    }

    private func setupChart() {
        viewModel.setupChart() { [weak self] chartData in
            self?.pieChartView.data = chartData
        }
    }

   @objc private func didTapAddAccount() {
        viewModel.didTapAddAccount()
    }

    private func setupUI() {
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])

        contentView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

        containerView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        ])

        containerView.addSubview(pieChartView)
        NSLayoutConstraint.activate([
            pieChartView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            pieChartView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25),
            pieChartView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -25),
            pieChartView.heightAnchor.constraint(equalToConstant: 300)
        ])

        containerView.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: pieChartView.bottomAnchor, constant: 25),
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])

        contentView.addSubview(addAccountButton)
        NSLayoutConstraint.activate([
            addAccountButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 20),
            addAccountButton.heightAnchor.constraint(equalToConstant: 48),
            addAccountButton.widthAnchor.constraint(equalToConstant: 250),
            addAccountButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            addAccountButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }

    private func makeAlert(actions: [UIAlertAction]) {
        let alert = UIAlertController(title: "Are you sure?", message: "Are you sure you want to delete all consents for this bank?", preferredStyle: .alert)

        actions.forEach { alert.addAction($0) }
        self.present(alert, animated: true)
    }

    //MARK: TableView Delegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == bankAccounts.count + 1 {
            viewModel.goToAllTransactions()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < bankAccounts.count {
            if bankAccounts[indexPath.row].currency.rawValue != "RON" {
                return 120
            }
        }

        return 60
    }

    //MARK: TableView DataSource

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row < bankAccounts.count
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            let deleteAction = UIAlertAction(title: "Sterge", style: .cancel) { [weak self] _ in
                self?.bankAccounts.remove(at: indexPath.row)
                self?.tableView.deleteRows(at: [indexPath], with: .automatic)
            }

            let cancelAction = UIAlertAction(title: "Anuleaza", style: .destructive)
            makeAlert(actions: [deleteAction, cancelAction])



//            viewModel.updatePieCahrt
        }
    }



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = bankAccounts.count + 2

        if bankAccounts.count > 0 {
            NSLayoutConstraint.activate([
                tableView.heightAnchor.constraint(equalToConstant: CGFloat((numberOfRows) * 60))
            ])
        }

        return numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < bankAccounts.count {
            guard let bankAccountCell = tableView.dequeueReusableCell(withIdentifier: "bankAccountCell", for: indexPath) as? BankAccountCell else { return UITableViewCell() }

            bankAccountCell.configure(bankAccount: bankAccounts[indexPath.row])
            return bankAccountCell
        }

        if indexPath.row == bankAccounts.count {
            guard let totalAmountCell = tableView.dequeueReusableCell(withIdentifier: "totalAmountCell", for: indexPath) as? TotalAmountCell else { return UITableViewCell() }

            totalAmountCell.configure(totalAmount: viewModel.totalAmount)
            return totalAmountCell
        }

        guard let allTransactionsCell = tableView.dequeueReusableCell(withIdentifier: "allTransactionsCell", for: indexPath) as? AllTransactionsCell else { return UITableViewCell() }

        return allTransactionsCell
    }
}

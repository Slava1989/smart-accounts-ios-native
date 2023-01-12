//
//  TableOptions.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 10.01.2023.
//

import UIKit

protocol TableOptionsDelegate: AnyObject {
    func didSelect(option: String, type: OptionsType)
}

enum OptionsType {
    case day
    case currency
}

final class TableOptions: UIView, UITableViewDelegate, UITableViewDataSource {
    private var options: [String] = []
    private var type: OptionsType = .day

    weak var delegate: TableOptionsDelegate?

    private lazy var selectLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var tableView: UITableView = {
        let tablewView = UITableView()
        tablewView.backgroundColor = .white
        tablewView.delegate = self
        tablewView.dataSource = self
        tablewView.separatorStyle = .none
        tablewView.register(OptionCell.self, forCellReuseIdentifier: "optionCell")
        tablewView.translatesAutoresizingMaskIntoConstraints = false
        return tablewView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(frame: CGRect, options: [String], type: OptionsType) {
        self.init(frame: frame)
        self.options = options
        self.type = type
        self.backgroundColor = .white
        tableView.reloadData()
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.addSubview(selectLabel)
        NSLayoutConstraint.activate([
            selectLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            selectLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])

        self.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: selectLabel.topAnchor, constant: 5),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }

    func didSelect(option: String) {
        delegate?.didSelect(option: option, type: type)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(option: options[indexPath.row], type: type)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "optionCell", for: indexPath) as? OptionCell else {
            return UITableViewCell()
        }

        cell.config(optionTitle: options[indexPath.row])
        return cell
    }
}

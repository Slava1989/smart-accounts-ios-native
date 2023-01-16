//
//  AllAccountsViewModel.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 02.01.2023.
//

import Foundation
import Charts
import Combine

protocol AccountsViewModelInput: AnyObject {
    var subject: CurrentValueSubject<[BankAccount], Error>{ get set }
    var totalAmount: Double { get set }

    func setupChart(completed: @escaping (PieChartData) -> Void)
    func goToAllTransactions()
    func didTapAddAccount()
}

final class AllAccountsViewModel: AccountsViewModelInput {
    private var coordinator: AllAccountsCoordinator
    private var bankAccounts: [BankAccount]?

    var subject = CurrentValueSubject<[BankAccount], Error>([])
    var totalAmount: Double = 0.0

    init(coordinator: AllAccountsCoordinator) {
        self.coordinator = coordinator

        setupTimer()
    }

    func setupChart(completed: @escaping (PieChartData) -> Void) {
        fetchBankAccounts() { [weak self] bankAccounts in
            guard let self = self else { return }

            self.bankAccounts = bankAccounts

            self.totalAmount = bankAccounts.map { bankAccount in
                if bankAccount.currency.rawValue != "RON" {
                    return bankAccount.amount * 20.24
                }

                return bankAccount.amount
            }.reduce(into: 0.0) { partialResult, amount in
                partialResult += amount
            }

            let entries = bankAccounts.map { bankAccount -> PieChartDataEntry in
                let percentValue = bankAccount.amount / self.totalAmount * 100
                return PieChartDataEntry(value: percentValue, label: bankAccount.bankNameShort)
            }

            let set = PieChartDataSet(entries: entries)
            set.drawIconsEnabled = false
            set.sliceSpace = 3
            set.selectionShift = 0
            set.colors = bankAccounts.map { UIColor(named: $0.color) ?? .black }

            completed(PieChartData(dataSet: set))
        }
    }

    func goToAllTransactions() {
        coordinator.goToAllTransactions(bankAccounts: bankAccounts ?? [])
    }

    func didTapAddAccount() {
        coordinator.goToAddAccount()
    }

    private func setupTimer() {
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(updateAccounts), userInfo: nil, repeats: true)
    }

    @objc private func updateAccounts() {
        bankAccounts?[2].loadStatus = .error
        subject.send(bankAccounts ?? [])
    }

    private func fetchBankAccounts(completed: @escaping ([BankAccount]) -> Void) {
        NetworkAccountManager.shared.fetchBankAccount { [weak self] bankAccounts, error in
            self?.subject.send(bankAccounts)
            completed(bankAccounts)
        }
    }
}

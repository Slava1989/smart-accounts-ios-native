//
//  NetworkAccountManager.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 02.01.2023.
//

import Foundation

protocol ServiceAPIProtocol {
    func fetchBankAccount(completed: @escaping ([BankAccount], NetworkError?) -> Void)
}

class NetworkAccountManager: ServiceAPIProtocol {
    static let shared: ServiceAPIProtocol = NetworkAccountManager()
    private init() { }

    func fetchBankAccount(completed: @escaping ([BankAccount], NetworkError?) -> Void) {
        let bankAccountMock = [
            BankAccount(
                bankName: "BRD",
                amount: 1036.00,
                currency: .RON,
                bankNameShort: "BRD",
                iban: "12345678909876543",
                color: "red",
                card: Card(
                    name: "Popescu Ion",
                    acountNumber: "RO99 BCRE 0000 9999 0000 9999",
                    balance: 2500,
                    currency: .EUR),
                loadStatus: .notloaded
            ),

            BankAccount(
                bankName: "ING",
                amount: 342.28,
                currency: .EUR,
                bankNameShort: "ING",
                iban: "12347890987654321",
                color: "orange",
                card: Card(
                    name: "Popescu Ion",
                    acountNumber: "RO99 BCRE 0000 9999 0000 9999",
                    balance: 2500,
                    currency: .EUR),
                loadStatus: .notloaded
            ),

            BankAccount(
                bankName: "BCR",
                amount: 900.00,
                currency: .RON,
                bankNameShort: "BCR",
                iban: "12347890987654321",
                color: "blue",
                card: Card(
                    name: "Popescu Ion",
                    acountNumber: "RO99 BCRE 0000 9999 0000 9999",
                    balance: 2500,
                    currency: .EUR),
                loadStatus: .notloaded
            ),

            BankAccount(
                bankName: "Banca Transilvania",
                amount: 520.50,
                currency: .RON,
                bankNameShort: "BT",
                iban: "12347890987654321",
                color: "black",
                card: Card(
                    name: "Popescu Ion",
                    acountNumber: "RO99 BCRE 0000 9999 0000 9999",
                    balance: 2500,
                    currency: .EUR),
                loadStatus: .notloaded
            )
        ]

        completed(bankAccountMock, nil)
    }
}


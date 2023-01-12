//
//  NetworkTransactionManager.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 04.01.2023.
//

import Foundation

protocol TransactionServiceAPIProtocol {
    func fetchTransactions(completed: @escaping ([Transaction], NetworkError?) -> Void)
}

class NetworkTransactionManager: TransactionServiceAPIProtocol {


    static let shared: TransactionServiceAPIProtocol = NetworkTransactionManager()
    private init() { }

    func fetchTransactions(completed: @escaping ([Transaction], NetworkError?) -> Void) {
        let transactionsMock = [
            Transaction(
                date: "12/01/2023",
                bankName: "BCR",
                iban: "RO65 BANK 0000 8888 2222 5555",
                descritpion: "carrefour",
                category: .grocerry,
                amount: 1300,
                currency: .RON,
                type: .debit
            ),

            Transaction(
                date: "12/01/2023",
                bankName: "BCR",
                iban: "RO65 BANK 0000 8888 2222 5555",
                descritpion: "carrefour",
                category: .grocerry,
                amount: 1300,
                currency: .RON,
                type: .debit
            ),

            Transaction(
                date: "11/01/2023",
                bankName: "BCR",
                iban: "RO65 BANK 0000 8888 2222 5555",
                descritpion: "carrefour",
                category: .grocerry,
                amount: 1300,
                currency: .RON,
                type: .debit
            ),

            Transaction(
                date: "10/01/2023",
                bankName: "BCR",
                iban: "RO65 BANK 0000 8888 2222 5555",
                descritpion: "carrefour",
                category: .grocerry,
                amount: 1300,
                currency: .RON,
                type: .debit
            ),

            Transaction(
                date: "09/01/2023",
                bankName: "BCR",
                iban: "RO65 BANK 0000 8888 2222 5555",
                descritpion: "carrefour",
                category: .grocerry,
                amount: 1300,
                currency: .RON,
                type: .debit
            ),

            Transaction(
                date: "08/01/2023",
                bankName: "BCR",
                iban: "RO65 BANK 0000 8888 2222 5555",
                descritpion: "salary income",
                category: .grocerry,
                amount: 1300,
                currency: .RON,
                type: .credit
            ),

            Transaction(
                date: "01/01/2023",
                bankName: "BCR",
                iban: "RO65 BANK 0000 8888 2222 5555",
                descritpion: "carrefour",
                category: .grocerry,
                amount: 1300,
                currency: .RON,
                type: .debit
            ),

            Transaction(
                date: "01/01/2023",
                bankName: "BCR",
                iban: "RO65 BANK 0000 8888 2222 5555",
                descritpion: "carrefour",
                category: .grocerry,
                amount: 1300,
                currency: .RON,
                type: .debit
            )
        ]

        completed(transactionsMock, nil)
    }
}

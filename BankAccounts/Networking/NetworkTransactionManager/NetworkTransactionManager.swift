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
                date: "16/01/2023",
                bankName: "BRD",
                iban: "RO65 BANK 0000 8888 2222 5555",
                descritpion: "shop haine pentru toti",
                category: .clothes,
                amount: 1300,
                currency: .RON,
                type: .debit,
                icon: "brd"
            ),

            Transaction(
                date: "16/01/2023",
                bankName: "BRD",
                iban: "RO65 BANK 0000 8888 2222 5555",
                descritpion: "shop haine pentru toti",
                category: .clothes,
                amount: 2700,
                currency: .RON,
                type: .debit,
                icon: "brd"
            ),

            Transaction(
                date: "15/01/2023",
                bankName: "BRD",
                iban: "RO65 BANK 0000 8888 2222 5555",
                descritpion: "shop haine pentru toti",
                category: .clothes,
                amount: 1300,
                currency: .RON,
                type: .debit,
                icon: "brd"
            ),

            Transaction(
                date: "12/01/2023",
                bankName: "BCR",
                iban: "RO65 BANK 0000 8888 2222 5555",
                descritpion: "carrefour",
                category: .grocerry,
                amount: 1300,
                currency: .RON,
                type: .debit,
                icon: "bcr"
            ),

            Transaction(
                date: "12/01/2023",
                bankName: "BCR",
                iban: "RO65 BANK 0000 8888 2222 5555",
                descritpion: "carrefour",
                category: .grocerry,
                amount: 1300,
                currency: .RON,
                type: .debit,
                icon: "bcr"
            ),

            Transaction(
                date: "11/01/2023",
                bankName: "BCR",
                iban: "RO65 BANK 0000 8888 2222 5555",
                descritpion: "carrefour",
                category: .grocerry,
                amount: 1300,
                currency: .RON,
                type: .debit,
                icon: "bcr"
            ),

            Transaction(
                date: "10/01/2023",
                bankName: "BCR",
                iban: "RO65 BANK 0000 8888 2222 5555",
                descritpion: "carrefour",
                category: .grocerry,
                amount: 1300,
                currency: .RON,
                type: .debit,
                icon: "bcr"
            ),

            Transaction(
                date: "09/01/2023",
                bankName: "BCR",
                iban: "RO65 BANK 0000 8888 2222 5555",
                descritpion: "carrefour",
                category: .grocerry,
                amount: 1300,
                currency: .RON,
                type: .debit,
                icon: "bcr"
            ),

            Transaction(
                date: "08/01/2023",
                bankName: "Banca Transilvania",
                iban: "RO65 BANK 0000 8888 2222 5555",
                descritpion: "salary income",
                category: .grocerry,
                amount: 1300,
                currency: .RON,
                type: .credit,
                icon: "bt"
            ),

            Transaction(
                date: "01/01/2023",
                bankName: "BCR",
                iban: "RO65 BANK 0000 8888 2222 5555",
                descritpion: "carrefour",
                category: .grocerry,
                amount: 1300,
                currency: .RON,
                type: .debit,
                icon: "bcr"
            ),

            Transaction(
                date: "01/01/2023",
                bankName: "BCR",
                iban: "RO65 BANK 0000 8888 2222 5555",
                descritpion: "carrefour",
                category: .grocerry,
                amount: 1300,
                currency: .RON,
                type: .debit,
                icon: "bcr"
            )
        ]

        completed(transactionsMock, nil)
    }
}

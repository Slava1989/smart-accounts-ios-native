//
//  Transaction.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 06.01.2023.
//

import Foundation



struct Transaction: Codable {
    let bankName: String
    let iban: String
    let descritpion: String
    let category: String
    let amount: String
    let currency: Currency
    let type: TransactionType

    enum Category: String, Codable {
        case grocerry
        case clothes
        case other
    }

    enum TransactionType: Int, Codable {
        case credit = 1
        case debit = -1
    }
}

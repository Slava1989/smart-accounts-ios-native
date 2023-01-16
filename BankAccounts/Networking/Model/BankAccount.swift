//
//  BankAccount.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 02.01.2023.
//

import Foundation

enum Currency: String, Codable {
    case RON = "RON"
    case USD = "USD"
    case EUR = "EUR"
}

enum LoadStatus: Int, Codable {
    case finished
    case notloaded
    case error
}

struct BankAccount: Codable {
    let bankName: String
    let amount: Double
    let currency: Currency
    let bankNameShort: String
    let iban: String
    let color: String
    let card: Card
    var loadStatus: LoadStatus
}

struct Card: Codable {
    let name: String
    let acountNumber: String
    let balance: Double
    let currency: Currency
}



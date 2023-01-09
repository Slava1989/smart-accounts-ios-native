//
//  NetworkBankManager.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 03.01.2023.
//

import Foundation

protocol ServiceBankAPIProtocol {
    func fetchBanks(completed: @escaping ([Bank], NetworkError?) -> Void)
}

class NetworkBankManager: ServiceBankAPIProtocol {
    static let shared: ServiceBankAPIProtocol = NetworkBankManager()
    private init() { }

    func fetchBanks(completed: @escaping ([Bank], NetworkError?) -> Void) {
        let bankMock = [
            Bank(imageName: "ing", name: "ING Bank"),
            Bank(imageName: "bt", name: "Banca Transilvania"),
            Bank(imageName: "rzb", name: "Raiffeisen Bank"),
            Bank(imageName: "unicredit", name: "Unicredit Bank"),
            Bank(imageName: "cec", name: "CEC Bank"),
            Bank(imageName: "bcr", name: "BCR")
        ]

        completed(bankMock, nil)
    }
}

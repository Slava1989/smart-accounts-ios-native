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
            Bank(imageName: "ing", name: "ING Bank", url: "https://ing.ro/"),
            Bank(imageName: "bt", name: "Banca Transilvania", url: "https://www.bancatransilvania.ro"),
            Bank(imageName: "rzb", name: "Raiffeisen Bank", url: "https://www.raiffeisen.ro"),
            Bank(imageName: "unicredit", name: "Unicredit Bank", url: "https://www.unicredit.ro"),
            Bank(imageName: "cec", name: "CEC Bank", url: "https://www.cec.ro"),
            Bank(imageName: "bcr", name: "BCR", url: "https://www.bcr.ro")
        ]

        completed(bankMock, nil)
    }
}

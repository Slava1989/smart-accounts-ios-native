//
//  NetworkError.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 02.01.2023.
//

import Foundation

enum NetworkError: Error {
    case serverError

    var errorDescription: String {
        switch self {
        case .serverError: return ""
        }
    }
}

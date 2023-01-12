//
//  String+Ext.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 12.01.2023.
//

import Foundation

extension String {
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.date(from: self)
    }
}

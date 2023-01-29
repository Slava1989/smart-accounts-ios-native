//
//  ErrorView.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 16.01.2023.
//

import UIKit

class ErrorView: UIView {
    private var attempts = 0
    @IBOutlet var contentView: UIView!

    @IBOutlet weak var retryButton: UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("ErrorView", owner: self)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]

        retryButton.layer.cornerRadius = 10
    }

    @IBAction func didTapRetry(_ sender: UIButton) {
        attempts += 1
        if attempts == 2 {
            retryButton.isHidden = true
        }
    }
}

//
//  WebPageController.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 05.01.2023.
//

import UIKit
import WebKit

final class WebPageController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var urlBankString: String

    init(url: String) {
        self.urlBankString = url
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        let url = URL(string: urlBankString)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}

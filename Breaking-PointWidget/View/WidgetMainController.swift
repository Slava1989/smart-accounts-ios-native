//
//  ViewController.swift
//  Breaking-PointWidget
//
//  Created by Veaceslav Chirita on 22.12.2022.
//

import UIKit

final class WidgetMainController: UIViewController {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupScrollView()
        setupViews()
    }

    private func setupScrollView() {
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Salut Alexandru"
        label.numberOfLines = 0
        label.sizeToFit()
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var subtitleLabel1: UILabel = {
        let label = UILabel()
        label.text = "Acesta este Dashboard-ul tau, aici iti poti aduce conturile tale de la celelalte banci pentru a le vedea pe toate in acelasi loc."
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica-Light", size: 18)
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var subtitleLabel2: UILabel = {
        let label = UILabel()
        label.text = "Pentru a face acest lucru, apasa butonul continua de mai jos."
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica-Light", size: 18)
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var continueButton1: RedButton = {
        let button = RedButton(frame: .zero, text: "Continua")
        button.setTitle("Continua", for: .normal)
        button.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var continueButton2: RedButton = {
        let button = RedButton(frame: .zero, text: "Continua")
        button.setTitle("Continua", for: .normal)
        button.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var grayContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var numberViewOne: RoundNumberView = {
        let view = RoundNumberView(frame: .zero, number: "1")
        view.layer.cornerRadius = 30
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var myDashboardLabel: UILabel = {
        let label = UILabel()
        label.text = "Dashboard-ul tau"
        label.numberOfLines = 0
        label.sizeToFit()
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var dashboardSubtitleLabel1: UILabel = {
        let label = UILabel()
        label.text = "Poti aduce toate informatiile de la conturile altor banci pentru a vedea usor si rapid toata situatia financiara."
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica-Light", size: 18)
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var chartImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dashboard")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var transactionsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "transactions")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var numberViewTwo: RoundNumberView = {
        let view = RoundNumberView(frame: .zero, number: "2")
        view.layer.cornerRadius = 30
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var myTransactionLabel: UILabel = {
        let label = UILabel()
        label.text = "Tranzactiile Tale"
        label.numberOfLines = 0
        label.sizeToFit()
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var transactionSubtitleLabel1: UILabel = {
        let label = UILabel()
        label.text = "Iti poti verifica de fiecare daca cand doresti tranzactiile de la alte banci, din YOU BRD."
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica-Light", size: 18)
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var tryLabel: UILabel = {
        let label = UILabel()
        label.text = "Incearca acum\nMultibanking YOU BRD"
        label.numberOfLines = 0
        label.sizeToFit()
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private func setupViews(){
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25)
        ])

        contentView.addSubview(subtitleLabel1)
        NSLayoutConstraint.activate([
            subtitleLabel1.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            subtitleLabel1.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            subtitleLabel1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 35),
            subtitleLabel1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -35)
        ])

        contentView.addSubview(subtitleLabel2)
        NSLayoutConstraint.activate([
            subtitleLabel2.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            subtitleLabel2.topAnchor.constraint(equalTo: subtitleLabel1.bottomAnchor, constant: 25),
            subtitleLabel2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 35),
            subtitleLabel2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -35)

        ])

        contentView.addSubview(continueButton1)
        NSLayoutConstraint.activate([
            continueButton1.topAnchor.constraint(equalTo: subtitleLabel2.bottomAnchor, constant: 30),
            continueButton1.heightAnchor.constraint(equalToConstant: 50),
            continueButton1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 35),
            continueButton1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -35)
        ])

        contentView.addSubview(grayContainerView)
        NSLayoutConstraint.activate([
            grayContainerView.topAnchor.constraint(equalTo: continueButton1.bottomAnchor, constant: 30),
            grayContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            grayContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            grayContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        grayContainerView.addSubview(numberViewOne)
        NSLayoutConstraint.activate([
            numberViewOne.widthAnchor.constraint(equalToConstant: 60),
            numberViewOne.heightAnchor.constraint(equalToConstant: 60),
            numberViewOne.topAnchor.constraint(equalTo: grayContainerView.topAnchor, constant: 45),
            numberViewOne.centerXAnchor.constraint(equalTo: grayContainerView.centerXAnchor)
        ])

        grayContainerView.addSubview(myDashboardLabel)
        NSLayoutConstraint.activate([
            myDashboardLabel.topAnchor.constraint(equalTo: numberViewOne.bottomAnchor, constant: 30),
            myDashboardLabel.centerXAnchor.constraint(equalTo: numberViewOne.centerXAnchor),
        ])

        grayContainerView.addSubview(dashboardSubtitleLabel1)
        NSLayoutConstraint.activate([
            dashboardSubtitleLabel1.centerXAnchor.constraint(equalTo: grayContainerView.centerXAnchor),
            dashboardSubtitleLabel1.topAnchor.constraint(equalTo: myDashboardLabel.bottomAnchor, constant: 25),
            dashboardSubtitleLabel1.leadingAnchor.constraint(equalTo: grayContainerView.leadingAnchor, constant: 35),
            dashboardSubtitleLabel1.trailingAnchor.constraint(equalTo: grayContainerView.trailingAnchor, constant: -35)
        ])

        grayContainerView.addSubview(chartImageView)
        NSLayoutConstraint.activate([
            chartImageView.topAnchor.constraint(equalTo: dashboardSubtitleLabel1.bottomAnchor, constant: -100),
            chartImageView.leadingAnchor.constraint(equalTo: grayContainerView.leadingAnchor, constant: 45),
            chartImageView.trailingAnchor.constraint(equalTo: grayContainerView.trailingAnchor, constant: -45),
            chartImageView.heightAnchor.constraint(equalToConstant: 900)
        ])

        grayContainerView.addSubview(numberViewTwo)
        NSLayoutConstraint.activate([
            numberViewTwo.topAnchor.constraint(equalTo: chartImageView.bottomAnchor),
            numberViewTwo.widthAnchor.constraint(equalToConstant: 60),
            numberViewTwo.heightAnchor.constraint(equalToConstant: 60),
            numberViewTwo.centerXAnchor.constraint(equalTo: grayContainerView.centerXAnchor)
        ])

        grayContainerView.addSubview(myTransactionLabel)
        NSLayoutConstraint.activate([
            myTransactionLabel.topAnchor.constraint(equalTo: numberViewTwo.bottomAnchor, constant: 30),
            myTransactionLabel.centerXAnchor.constraint(equalTo: grayContainerView.centerXAnchor)
        ])

        grayContainerView.addSubview(transactionSubtitleLabel1)
        NSLayoutConstraint.activate([
            transactionSubtitleLabel1.centerXAnchor.constraint(equalTo: grayContainerView.centerXAnchor),
            transactionSubtitleLabel1.topAnchor.constraint(equalTo: myTransactionLabel.bottomAnchor, constant: 25),
            transactionSubtitleLabel1.leadingAnchor.constraint(equalTo: grayContainerView.leadingAnchor, constant: 35),
            transactionSubtitleLabel1.trailingAnchor.constraint(equalTo: grayContainerView.trailingAnchor, constant: -35),

        ])

        grayContainerView.addSubview(transactionsImageView)
        NSLayoutConstraint.activate([
            transactionsImageView.topAnchor.constraint(equalTo: transactionSubtitleLabel1.bottomAnchor, constant: -100),
            transactionsImageView.leadingAnchor.constraint(equalTo: grayContainerView.leadingAnchor, constant: 45),
            transactionsImageView.trailingAnchor.constraint(equalTo: grayContainerView.trailingAnchor, constant: -45),
            transactionsImageView.heightAnchor.constraint(equalToConstant: 900),
            transactionsImageView.bottomAnchor.constraint(equalTo: grayContainerView.bottomAnchor, constant: 0)
        ])

        contentView.addSubview(tryLabel)
        NSLayoutConstraint.activate([
            tryLabel.topAnchor.constraint(equalTo: transactionsImageView.bottomAnchor, constant: 10),
            tryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            tryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
//            tryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        contentView.addSubview(continueButton2)
        NSLayoutConstraint.activate([
            continueButton2.topAnchor.constraint(equalTo: tryLabel.bottomAnchor, constant: 30),
            continueButton2.heightAnchor.constraint(equalToConstant: 50),
            continueButton2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 35),
            continueButton2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -35),
//            continueButton2.bottomAnchor.constraint(equalTo: con)
        ])
    }

    @objc func didTapContinue() {
        print("dsdsds")
    }


}


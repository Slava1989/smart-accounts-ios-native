//
//  BankAccountView.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 12.01.2023.
//

import UIKit

protocol BankAccountViewDelegate: AnyObject {
    func didSelect(bankAccount: BankAccount?)
}

final class BankAccountView: UIView, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    private var bankAccounts: [BankAccount] = []
    weak var delegate: BankAccountViewDelegate?

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CardCell.self, forCellWithReuseIdentifier: "cardCell")
        collectionView.register(AllCell.self, forCellWithReuseIdentifier: "allCell")

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 270)
        ])
    }

    func setupBankAccount(bankAccounts: [BankAccount]) {
        self.bankAccounts = bankAccounts
        collectionView.reloadData()
    }

    //MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let bankAccount = indexPath.row > 0 ? bankAccounts[indexPath.row - 1] : nil
        delegate?.didSelect(bankAccount: bankAccount)
    }

    //MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bankAccounts.count + 1

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "allCell", for: indexPath) as? AllCell else { return UICollectionViewCell() }

            return cell
        }

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as? CardCell else { return UICollectionViewCell() }

        let bankAccount = bankAccounts[indexPath.row - 1]
        cell.configureCell(bankAccount: bankAccount)
        return cell
    }

    //MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if indexPath.row == 0 {
            return CGSize(width: 270, height: 250)
        }

        return CGSize(width: 350, height: 250)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {


        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }


}

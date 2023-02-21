//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by Silviu Preoteasa on 21.02.2023.
//

import UIKit

class AccountSummaryViewController: UIViewController {
    
    struct Profile {
        let firstName: String
        let lastName: String
    }
    
    var profile: Profile?
    var accounts: [AccountSummaryCell.ViewModel] = []
    
    var tableView: UITableView = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        view.backgroundColor = appColor
        setupTableView()
        setupTableHeaderView()
        fetchData()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = appColor
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.tableFooterView = UIView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.constraintEqualToSafeAreLayoutGuide(of: view)
    }
    
    private func setupTableHeaderView() {
        
        let header = AccountSummaryHeaderView(frame: .zero)
        
        var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        header.frame.size = size
        
        tableView.tableHeaderView = header
    }
}

extension AccountSummaryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !accounts.isEmpty else {return UITableViewCell()}
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
        cell.configure(with: accounts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        accounts.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension AccountSummaryViewController {
    private func fetchData() {
        fetchAccounts()
        fetchProfile()
    }
    
    private func fetchAccounts() {
        let savings = AccountSummaryCell.ViewModel(accountType: .Banking, accountName: "Basic Savings", balance: 929466.00, currency: .DLR)
        let visa = AccountSummaryCell.ViewModel(accountType: .CreditCard, accountName: "Student Mastercard", balance: 12.3, currency: .EUR)
        let investment = AccountSummaryCell.ViewModel(accountType: .Investment, accountName: "Tav-Free Saver", balance: 99999.99, currency: .RON)
        let investment2 = AccountSummaryCell.ViewModel(accountType: .Investment, accountName: "Tav-Free Saver", balance: 99999.99, currency: .RON)
        let investment3 = AccountSummaryCell.ViewModel(accountType: .Investment, accountName: "Tav-Free Saver", balance: 99999.99, currency: .RON)
        let investment4 = AccountSummaryCell.ViewModel(accountType: .Investment, accountName: "Tav-Free Saver", balance: 99999.99, currency: .RON)
        
        accounts.append(savings)
        accounts.append(visa)
        accounts.append(investment)
        accounts.append(investment2)
        accounts.append(investment3)
        accounts.append(investment4)
    }
    private func fetchProfile() {
        profile = Profile(firstName: "COS TEL", lastName: "BI JU")
    }
}

//
//  AccountSummaryCellViewModel.swift
//  Bankey
//
//  Created by Silviu Preoteasa on 21.02.2023.
//

import Foundation

extension AccountSummaryCell {
    
    enum Currency: String {
        case DLR = "$"
        case RON = "RON"
        case EUR = "EUR"
    }
    
    struct ViewModel {
        let accountType: AccountType
        let accountName: String
        let balance: Decimal
        let currency: Currency
        
        
        var balanceAsAttributedString: NSAttributedString? {
            CurrencyFormatter().makeAttributedCurrency(for: balance, currency: currency.rawValue)
        }
    }
}

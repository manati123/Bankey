//
//  CurrencyFormatter.swift
//  Bankey
//
//  Created by Silviu Preoteasa on 21.02.2023.
//

import UIKit

struct CurrencyFormatter {
    
    func makeAttributedCurrency(for amount: Decimal, currency: String) -> NSMutableAttributedString {
        let tuple = breakIntoNaturalAndDecimalParts(amount)
        return makeFormattedBalance(currency: currency, lhsValue: tuple.0, rhsValue: tuple.1)
    }
    
    // Converts 929466.23 > "929,466" "23"
    func breakIntoNaturalAndDecimalParts(_ amount: Decimal) -> (String, String) {
        let tuple = modf(amount.doubleValue)
        
        let lhs = convertLhs(tuple.0)
        let rhs = convertRhs(tuple.1)
        
        return (lhs, rhs)
    }
    
    // Converts 929466 > 929,466
    private func convertLhs(_ naturalPart: Double) -> String {
        let lhsWithDecimal = lhsFormatted(naturalPart) // "$929,466.00"
        let formatter = NumberFormatter()
        let decimalSeparator = formatter.decimalSeparator! // "."
        let dollarComponents = lhsWithDecimal.components(separatedBy: decimalSeparator) // "$929,466" "00"
        var lhs = dollarComponents.first! // "$929,466"
        lhs.removeFirst() // "929,466"

        return lhs
    }
    
    // Convert 0.23 > 23
    private func convertRhs(_ decimalPart: Double) -> String {
        let rhs: String
        if decimalPart == 0 {
            rhs = "00"
        } else {
            rhs = String(format: "%.0f", decimalPart * 100)
        }
        return rhs
    }
    
    // Converts 929466 > $929,466.00
    func lhsFormatted(_ lhs: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        
        if let result = formatter.string(from: lhs as NSNumber) {
            return result
        }
        
        return ""
    }
    
    private func makeFormattedBalance(currency: String, lhsValue: String, rhsValue: String) -> NSMutableAttributedString {
        let currencySignAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
        let lhsAttribues: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
        let rhsAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .footnote), .baselineOffset: 8]
        
        let rootString = NSMutableAttributedString(string: currency, attributes: currencySignAttributes)
        let lhsString = NSAttributedString(string: String(lhsValue), attributes: lhsAttribues)
        let rhsString = NSAttributedString(string: String(rhsValue), attributes: rhsAttributes)
        
        rootString.append(lhsString)
        rootString.append(rhsString)
        return rootString
    }
}

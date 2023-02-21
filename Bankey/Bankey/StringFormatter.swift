//
//  StringFormatter.swift
//  Bankey
//
//  Created by Silviu Preoteasa on 21.02.2023.
//

import UIKit

class StringFormatter {
    static func makeFormattedBalance(currency: String, lhsValue: Int, rhsValue: Int) -> NSMutableAttributedString {
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

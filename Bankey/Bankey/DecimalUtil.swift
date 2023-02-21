//
//  File.swift
//  Bankey
//
//  Created by Silviu Preoteasa on 21.02.2023.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        NSDecimalNumber(decimal: self).doubleValue
    }
}

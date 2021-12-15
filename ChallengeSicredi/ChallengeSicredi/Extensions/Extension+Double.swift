//
//  Extension+Double.swift
//  ChallengeSicredi
//
//  Created by Josias Fabrício on 13/12/21.
//

import Foundation

extension Double {
    
    var currencyValue: String {
        get {
            let number: NSNumber! = NSNumber(value: self)
            let formatter = NumberFormatter()
            formatter.usesGroupingSeparator = true
            formatter.numberStyle = .currency
            formatter.currencyCode = "BRL"
            formatter.locale = Locale(identifier: "pt_BR")
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 2
            return formatter.string(from: number) ?? ""
        }
    }
}

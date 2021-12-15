//
//  Extension+Int.swift
//  ChallengeSicredi
//
//  Created by Josias Fabrício on 13/12/21.
//

import Foundation

extension Int{

    var intToDateTime: Date?{
        let epochTime = TimeInterval(self) / 1000
        let date = Date(timeIntervalSince1970: epochTime)
        return date
    }
}

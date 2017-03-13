//
//  Utils.swift
//  MadMineSweepper
//
//  Created by jason akakpo on 12/03/2017.
//  Copyright © 2017 MTT. All rights reserved.
//

import UIKit

extension UIColor {
    static let discoveredCellColor: UIColor = UIColor(colorLiteralRed: 187.0 / 255, green: 187.0 / 255, blue: 187.0 / 255, alpha: 1)

    static let hiddenCellColor: UIColor = UIColor(colorLiteralRed: 238.0 / 255, green: 238.0 / 255, blue: 238.0 / 255, alpha: 1)
    static let discoveredCellBorderColor = UIColor(colorLiteralRed: 153.0 / 255, green: 153.0 / 255, blue: 153.0 / 255, alpha: 1)

    public convenience init(hex6: UInt32) {
        let divisor = CGFloat(255)
        let red     = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
        let green   = CGFloat((hex6 & 0x00FF00) >>  8) / divisor
        let blue    = CGFloat( hex6 & 0x0000FF       ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}

extension TimeInterval {
    func digitalString() -> String {

        let minutes = Int(self) / 60
        let seconds = Int(self) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
}


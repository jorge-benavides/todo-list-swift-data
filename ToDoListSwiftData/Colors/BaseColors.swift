//
//  BaseColors.swift
//  ToDoListSwiftData
//
//  Created by Carlos Barron on 31/08/24.
//

import UIKit

extension UIColor {
    private convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }

    static let wizelineRed = UIColor.init(hex: "#E93D44FF")

    static let wizelineDarkBlue = UIColor.init(hex: "#203449FF")

    static let wizelineBlue = UIColor.init(hex: "#0071BCFF")

    static let wizelineLightBlue = UIColor.init(hex: "#03C4FFFF")

    static let wizelineLightGrey = UIColor.init(hex: "#D3D3D4FF")

    static let wizelineDarKGrey = UIColor.init(hex: "#4E5154FF")
}

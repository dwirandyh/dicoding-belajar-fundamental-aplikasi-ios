//
//  ResourceExtension.swift
//  dicoding-ios-fundamental
//
//  Created by Dwi Randy Herdinanto on 29/07/20.
//  Copyright © 2020 dwirandyh. All rights reserved.
//

import SwiftUI

extension Color {
    static let primaryText = Color("gray")
    static let gray80 = Color("gray80")
    static let gray20 = Color("gray20")
    static let red80 = Color("red")
}

extension CGFloat {
    static let spacingSmall: CGFloat = 4
    static let spacingNormal: CGFloat = 8
    static let spacingLarge: CGFloat = 16
}

extension Image {
    static let previewImage: Image = Image("previewImage")
    static let calendar: Image = Image(systemName: "calendar")
    static let timer: Image = Image(systemName: "timer")
    static let search: Image = Image(systemName: "magnifyingglass")
    static let starFill: Image = Image(systemName: "star.fill")
    static let profile: Image = Image("profile")
    static let background: Image = Image("background")
    static let info: Image = Image(systemName: "questionmark.circle.fill")
}

extension String {
    func convertToDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self)!
        return date
    }
}

extension Date {
    func convertToString(format: String) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

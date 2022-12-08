//
//  ColorStyle.swift
//  ToDoApp
//
//  Created by Trong Hieu Vuong on 2022-12-05.
//

import Foundation
import SwiftUI

enum ColorStyle: String {
    case primaryAccent // Swift will automatically synthesize cases and rawValue would be exactly "primaryAccent"
    case secondaryAccent
    case primaryText
    case primaryButton
    case caption
}

extension Color {
    init(_ colorStyle: ColorStyle) {
        self = .init(colorStyle.rawValue)
    }
}

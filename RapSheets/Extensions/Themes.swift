//
//  ThemeModel.swift
//  RapSheets
//
//  Created by Alexander Lester on 10/19/22.
//

import SwiftUI

protocol Theme {
    var buttonGradient: [Color] { get }
}

struct DefaultTheme: Theme {
    let buttonGradient = [ Color(hex: "4000FF"), Color(hex: "b452b4") ]
}

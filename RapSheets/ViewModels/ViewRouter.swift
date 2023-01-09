//
//  ViewRouter.swift
//  RapSheets
//
//  Created by Alexander Lester on 10/19/22.
//

import SwiftUI

class ViewRouter: ObservableObject {
    @Published var currentPage: Page = .Login
}

enum Page {
    case Login
    case Registration
    case Dashboard
    case CompleteProfile
}



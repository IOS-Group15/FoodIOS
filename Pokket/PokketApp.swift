//
//  PokketApp.swift
//  Pokket
//
//  Created by Minh Huynh on 4/19/24.
//

import SwiftUI

@main
struct PokketApp: App {
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

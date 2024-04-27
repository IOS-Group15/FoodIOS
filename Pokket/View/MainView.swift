//
//  MainView.swift
//  Pokket
//
//  Created by Minh Huynh on 4/19/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            Text("Dashboard")
                .tabItem {
                    Label("Dashboard", systemImage: "house")
                }
            Text("Transactions")
                .tabItem {
                    Label("Transactions", systemImage: "list.bullet")
                }
            BudgetsView()
                .tabItem {
                    Label("Budgets", systemImage: "dollarsign.circle")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}

#Preview {
    MainView()
}

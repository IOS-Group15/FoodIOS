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
            TransactionsView()
                .tabItem {
                    Label("Transactions", systemImage: "list.bullet")
                }
            BudgetsView()
                .tabItem {
                    Label("Budgets", systemImage: "dollarsign.circle")
                }
            SettigsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
        .navigationTitle("Pokket")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MainView()
}

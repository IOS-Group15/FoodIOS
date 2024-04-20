//
//  EditBudgetView.swift
//  Pokket
//
//  Created by Minh Huynh on 4/19/24.
//

import SwiftUI

struct EditBudgetView: View {
    @Binding var budgetCategory: BudgetCategory

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $budgetCategory.name)
                TextField("Budget Amount", value: $budgetCategory.budgetAmount, formatter: NumberFormatter())
                Picker("Category Type", selection: $budgetCategory.categoryType) {
                    ForEach(BudgetCategoryType.allCases, id: \.self) { type in
                        Text(type.rawValue.capitalized)
                    }
                }
            }
            Section {
                Text("Current Spent: $\(budgetCategory.currentSpent, specifier: "%.2f")")
                Text("Percentage Change: \(budgetCategory.percentageChange > 0 ? "↑" : "↓")\(abs(budgetCategory.percentageChange), specifier: "%.1f")% compared to last month")
            }
        }
        .navigationTitle("Edit Budget")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    EditBudgetView(budgetCategory: .constant(BudgetCategory(name: "", budgetAmount: 0.0, numberOfTransactions: 0, percentageChange: 0.0, currentSpent: 0.0, categoryType: .entertainment)))
}

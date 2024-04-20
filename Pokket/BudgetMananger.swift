//
//  BudgetMananger.swift
//  Pokket
//
//  Created by Minh Huynh on 4/19/24.
//
import SwiftUI

class BudgetManager: ObservableObject {
    @Published var monthlyBudgetCategories = [
        BudgetCategory(name: "Groceries", budgetAmount: 500.0, numberOfTransactions: 6, percentageChange: 68.3, currentSpent: 400.0, categoryType: .groceries),
        BudgetCategory(name:"Shopping", budgetAmount: 400.0, numberOfTransactions: 6, percentageChange: 32.1, currentSpent: 350.5, categoryType: .shopping),
        BudgetCategory(name: "Entertainment", budgetAmount: 200.0, numberOfTransactions: 6, percentageChange: -16.8, currentSpent: 195.5, categoryType: .entertainment)
    ]

    @Published var semesterBudgetCategories = [
        BudgetCategory(name: "Subscriptions", budgetAmount: 100.0, numberOfTransactions: 6, percentageChange: 11.5, currentSpent: 90.0, categoryType: .subscriptions),
        BudgetCategory(name: "Utilities", budgetAmount: 100.0, numberOfTransactions: 6, percentageChange: -9.0, currentSpent: 120, categoryType: .utilities)
    ]

    func addBudgetCategory(_ budgetCategory: BudgetCategory) {
        monthlyBudgetCategories.append(budgetCategory)
    }

    func updateBudgetCategory(_ budgetCategory: BudgetCategory) {
        if let index = monthlyBudgetCategories.firstIndex(where: { $0.id == budgetCategory.id }) {
            monthlyBudgetCategories[index] = budgetCategory
        }
    }

    func deleteBudgetCategory(_ budgetCategory: BudgetCategory) {
        if let index = monthlyBudgetCategories.firstIndex(where: { $0.id == budgetCategory.id }) {
            monthlyBudgetCategories.remove(at: index)
        }
    }
}

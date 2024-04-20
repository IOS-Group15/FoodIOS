//
//  BudgetsView.swift
//  Pokket
//
//  Created by Minh Huynh on 4/19/24.
//

import SwiftUI

struct BudgetCategory: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let budgetAmount: Double
    let numberOfTransactions: Int
    let percentageChange: Double
    let currentSpent: Double
    let categoryType: BudgetCategoryType
}

enum BudgetCategoryType: String, CaseIterable {
    case groceries = "basket"
    case shopping = "cart"
    case entertainment = "ticket"
    case subscriptions = "creditcard"
    case utilities = "lightbulb"
}

struct BudgetsView: View {
    @State private var path = NavigationPath()
    
    @StateObject var budgetManager = BudgetManager()
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.accent]
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                BudgetListView(budgetTitle: "Monthly Budget", budgetCategories: $budgetManager.monthlyBudgetCategories)
                BudgetListView(budgetTitle: "Semester Budget", budgetCategories: $budgetManager.semesterBudgetCategories)
                Spacer()
                NavigationLink(value: "Add New Budget") {
                    Spacer()
                    Image(systemName: "plus")
                    Text("Add New Budget")
                        .padding(15)
                    Spacer()
                }
                .foregroundStyle(.white)
                .fontWeight(.semibold)
                .frame(width: .infinity)
                .background(RoundedRectangle(cornerRadius: 20).fill(.green))
                .navigationDestination(for: String.self) { title in
                    Text(title)
                }
            }
            .padding(.horizontal)
            .padding(.horizontal)
        }
        .padding(.bottom)
    }
}

struct BudgetListView: View {
    let budgetTitle: String
    @Binding var budgetCategories: [BudgetCategory]
    
    var body: some View {
        VStack {
            HStack {
                Text(budgetTitle)
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            ForEach(budgetCategories) { budgetCategory in
                NavigationLink(value: budgetCategory) {
                    VStack {
                        HStack {
                            Circle()
                                .fill(getColor(for: budgetCategory.categoryType))
                                .overlay {
                                    Image(systemName: budgetCategory.categoryType.rawValue)
                                        .foregroundStyle(.white)
                                        .fontWeight(.semibold)
                                }
                            VStack(alignment: .leading) {
                                Text(budgetCategory.name)
                                    .font(.headline)
                                    .foregroundStyle(.black)
                                Text("\(budgetCategory.numberOfTransactions) Transactions")
                                    .font(.subheadline)
                                    .foregroundStyle(.gray)
                            }
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text("$\(budgetCategory.currentSpent, specifier: "%.2f")")
                                    .font(.headline)
                                    .foregroundStyle(.black)
                                Text("/ $\(budgetCategory.budgetAmount, specifier: "%.2f")")
                                                                    .font(.caption)
                                                                    .foregroundStyle(.gray)
                                                                                         
                            }
                        }
                        .frame(maxHeight: 40)
                        
                        ProgressView(value: budgetCategory.currentSpent / budgetCategory.budgetAmount, total: 1)
                                                            .progressViewStyle(.linear)
                                                            .tint(budgetCategory.currentSpent > budgetCategory.budgetAmount ? .red : .green)
                        HStack {
                            Spacer()
                            Text("\(budgetCategory.percentageChange > 0 ? "↓" : "↑")\(abs(budgetCategory.percentageChange), specifier: "%.1f")% compared to last month")
                                .font(.caption2)
                                .foregroundStyle(budgetCategory.percentageChange > 0 ? Color.green : Color.red )
                        }
                    }
                }
            }
            .padding(.vertical, 5)
            .navigationTitle("Pokket")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: BudgetCategory.self) { budgetCategory in
                Text("Detail View for \(budgetCategory.name)")
            }
        }
        .padding(.bottom)
    }
    
    func getColor(for categoryType: BudgetCategoryType) -> Color {
        switch categoryType {
        case .groceries:
            return Color.brown
        case .shopping:
            return Color.blue
        case .entertainment:
            return Color.purple
        case .subscriptions:
            return Color.orange
        case .utilities:
            return Color.green
        }
    }
}

struct AddBudgetView: View {
    var body: some View {
        Text("Add Budget View")
    }
}

#Preview {
    BudgetsView()
}

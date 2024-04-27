//
//  BudgetsView.swift
//  Pokket
//
//  Created by Minh Huynh on 4/19/24.
//

import SwiftUI

struct BudgetCategory: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var budgetAmount: Double
    let numberOfTransactions: Int
    let percentageChange: Double
    let currentSpent: Double
    var categoryType: BudgetCategoryType
    var budgetPeriod: BudgetPeriod
}

enum BudgetCategoryType: String, CaseIterable, Codable {
    case groceries, shopping, entertainment, subscriptions, utilities, other
}

enum BudgetPeriod: String, CaseIterable, Codable {
        case monthly, semester
    }

struct BudgetsView: View {
    @State private var path = NavigationPath()
    
    @StateObject var budgetManager = BudgetManager()
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.accent]
    }
    
    var body: some View {
            VStack {
                ScrollView {
                    VStack {
                        BudgetListView(budgetTitle: "Monthly Budget", budgetCategories: $budgetManager.monthlyBudgetCategories, datePeriod: "Apr 01 - Apr 30")
                        BudgetListView(budgetTitle: "Semester Budget", budgetCategories: $budgetManager.semesterBudgetCategories, datePeriod: "Jan 01 - Jun 30")
                    }
                }
                Spacer()
                NavigationLink(destination: AddBudgetView(budgetManager: budgetManager)) {
                    GreenButton(imageSystemName: "plus", text: "Add New Budget")
                }
            }
            .onAppear(perform: budgetManager.load)
            .padding(.horizontal)
            .padding(.horizontal)
    }
}

struct BudgetListView: View {
    let budgetTitle: String
    @Binding var budgetCategories: [BudgetCategory]
    @State var selectedBudgetCategory: BudgetCategory = BudgetCategory(name: "", budgetAmount: 0.0, numberOfTransactions: 0, percentageChange: 0.0, currentSpent: 0.0, categoryType: .entertainment, budgetPeriod: .monthly)
    let datePeriod: String
    
    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                Text(budgetTitle)
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Text(datePeriod) // Display the date period
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            ForEach(budgetCategories) { budgetCategory in
                NavigationLink(value: budgetCategory) {
                    VStack {
                        HStack {
                            Circle()
                                .fill(getColor(for: budgetCategory.categoryType))
                                .overlay {
                                    Image(systemName: getIcon(for: budgetCategory.categoryType))
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
                EditBudgetView(budgetCategory: $selectedBudgetCategory)
                    .onAppear() {
                        selectedBudgetCategory = budgetCategory
                    }
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
        case .other:
            return Color.gray
        }
    }
    
    func getIcon(for categoryType: BudgetCategoryType) -> String {
        switch categoryType {
        case .groceries:
            return "basket"
        case .shopping:
            return "cart"
        case .entertainment:
            return "ticket"
        case .subscriptions:
            return "creditcard"
        case .utilities:
            return "lightbulb"
        case .other:
            return "giftcard"
        }
    }
}

#Preview {
    BudgetsView()
}

//
//  AddBudgetView.swift
//  Pokket
//
//  Created by Minh Huynh on 4/26/24.
//

import SwiftUI

struct AddBudgetView: View {
    @ObservedObject var budgetManager: BudgetManager
    @State private var name = ""
    @State private var budgetAmount = 0.0
    @State private var categoryType = BudgetCategoryType.groceries
    @State private var budgetPeriod: BudgetPeriod = .monthly
    @State private var showingAlert = false
    
    var body: some View {
        VStack  {
            VStack (alignment: .leading) {
                Text("Add Budget")
                    .font(.title2)
                    .fontWeight(.bold)
                TextField("Name", text: $name)
                    .textFieldStyle(OutlinedTextFieldStyle())
                TextField("Budget Amount", value: $budgetAmount, formatter: NumberFormatter())
                    .textFieldStyle(OutlinedTextFieldStyle())
            }
            .padding(.horizontal)
            .padding(.horizontal)
            Form {
                Picker("Category Type", selection: $categoryType) {
                    ForEach(BudgetCategoryType.allCases, id: \.self) { type in
                        Text(type.rawValue.capitalized)
                    }
                }
                .pickerStyle(.menu)
                Picker("Budget Period", selection: $budgetPeriod) {
                    ForEach(BudgetPeriod.allCases, id: \.self) { period in
                        Text(period.rawValue.capitalized)
                    }
                }
                .pickerStyle(.menu)
            }
            .frame(maxHeight: 150)
            Spacer()
            Button(action: {
                let newCategory = BudgetCategory(name: name, budgetAmount: budgetAmount, numberOfTransactions: 0, percentageChange: 0, currentSpent: 0, categoryType: categoryType, budgetPeriod: budgetPeriod)
                budgetManager.addBudgetCategory(newCategory)
                showingAlert = true
            }, label: {
                GreenButton(imageSystemName: "plus", text: "Add")
            })
            .alert("Budget Added", isPresented: $showingAlert) {
                Button("OK", role: .cancel) {
                    budgetManager.load()
                }
            } message: {
                Text("The new budget has been added.")
            }
            .padding(.horizontal)
            .padding(.horizontal)
            
            
        }
        .navigationTitle("Add Budget")
    }
}

#Preview {
    AddBudgetView(budgetManager: BudgetManager())
}

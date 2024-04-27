//
//  EditBudgetView.swift
//  Pokket
//
//  Created by Minh Huynh on 4/19/24.
//

import SwiftUI

struct EditBudgetView: View {
    @StateObject var budgetManager = BudgetManager()
    @Binding var budgetCategory: BudgetCategory
    @State private var showingAlert = false
    
    var body: some View {
        VStack  {
            VStack (alignment: .leading){
                Text("Edit Budget")
                    .font(.title2)
                    .fontWeight(.bold)
                Section {
                    TextField("Name", text: $budgetCategory.name)
                        .textFieldStyle(OutlinedTextFieldStyle())
                    TextField("Budget Amount", value: $budgetCategory.budgetAmount, formatter: NumberFormatter())
                        .textFieldStyle(OutlinedTextFieldStyle())
                }
            }
            .padding(.horizontal)
            .padding(.horizontal)
            Form {
                Picker("Category Type", selection: $budgetCategory.categoryType) {
                    ForEach(BudgetCategoryType.allCases, id: \.self) { type in
                        Text(type.rawValue.capitalized)
                    }
                }
                Picker("Budget Period", selection: $budgetCategory.budgetPeriod) {
                    ForEach(BudgetPeriod.allCases, id: \.self) { period in
                        Text(period.rawValue.capitalized)
                    }
                }
            }
            .frame(maxHeight: 150)
            Spacer()
            Button(action: {
                showingAlert = true
            }, label: {
                GreenButton(imageSystemName: "", text: "Update")
            })
            .alert("Budget Added", isPresented: $showingAlert) {
                Button("OK", role: .cancel) {
                    budgetManager.updateBudgetCategory(budgetCategory)
                    budgetManager.load()
                }
            } message: {
                Text("The new budget has been added.")
            }
            .padding(.horizontal)
            .padding(.horizontal)
        }
        //        .navigationTitle("Edit Budget")
        //        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    EditBudgetView(budgetCategory: .constant(BudgetCategory(name: "", budgetAmount: 0.0, numberOfTransactions: 0, percentageChange: 0.0, currentSpent: 0.0, categoryType: .entertainment, budgetPeriod: .monthly)))
}

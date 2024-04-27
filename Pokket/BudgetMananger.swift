//
//  BudgetMananger.swift
//  Pokket
//
//  Created by Minh Huynh on 4/19/24.
//
import SwiftUI
import FirebaseFirestore

class BudgetManager: ObservableObject {
    @Published var budgetCategories: [BudgetCategory] = []
    @Published var monthlyBudgetCategories: [BudgetCategory] = []
    @Published var semesterBudgetCategories: [BudgetCategory] = []
    
    private let db = Firestore.firestore()
    
    init() {
    }
    
    func addBudgetCategory(_ category: BudgetCategory) {
        // Combine all budget categories into a single array on Firestore
        let db = Firestore.firestore()
        do {
            try db.collection("budgetCategories").addDocument(from: category)
        } catch {
            print("Error adding budget category: \(error)")
        }
    }
    
    func updateBudgetCategory(_ category: BudgetCategory) {
        // Update the budget category on Firestore
        let db = Firestore.firestore()
        do {
            try db.collection("budgetCategories").document(category.id.uuidString).setData(from: category)
        } catch {
            print("Error updating budget category: \(error)")
        }
    }
    
    func load() {
        // Load data from Firestore or other data source
        let db = Firestore.firestore()
        db.collection("budgetCategories").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                self.budgetCategories = querySnapshot!.documents.compactMap { document in
                    try? document.data(as: BudgetCategory.self)
                }
                // Separate the budget categories into monthly and semester arrays
                self.monthlyBudgetCategories = self.budgetCategories.filter { $0.budgetPeriod == .monthly }
                self.semesterBudgetCategories = self.budgetCategories.filter { $0.budgetPeriod == .semester }
            }
        }
    }
}

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
    static let shared = BudgetManager()
    
    init() {
    }
    
    func addBudgetCategory(_ category: BudgetCategory) {
        do {
            let docRef = try db.collection("budgetCategories").addDocument(from: category)
        } catch {
            print("Error adding budget category: \(error)")
        }
    }
    
    func updateBudgetCategory(_ category: BudgetCategory) {
        if let id = category.id {
            do {
                try db.collection("budgetCategories").document(id).setData(from: category)
            } catch {
                print("Error updating budget category: \(error)")
            }
        }
    }
    
    func load() {
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

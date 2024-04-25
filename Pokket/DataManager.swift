//
//  DataManager.swift
//  Pokket
//
//  Created by Elias Woldie on 4/24/24.
//

import Foundation
import FirebaseFirestore

class DataManager {
    static let shared = DataManager()
    let db = Firestore.firestore()

    init() {
        // Initialize any necessary data here
    }

    func addUser(name: String, email: String) {
        let usersRef = db.collection("users")
        usersRef.addDocument(data: [
            "name": name,
            "email": email,
            "createdAt": FieldValue.serverTimestamp()
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document successfully added")
            }
        }
    }

    // More Firestore methods can be added here...
}

//
//  Elements.swift
//  Pokket
//
//  Created by Minh Huynh on 4/26/24.
//

import SwiftUI

struct OutlinedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    .frame(minHeight: 40)
            )
            .padding(.bottom, 10)
    }
}

struct GreenButton: View {
    let imageSystemName: String
    let text: String
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: imageSystemName)
            Text(text)
                .padding(15)
            Spacer()
        }
        .foregroundStyle(.white)
        .fontWeight(.semibold)
        .frame(width: .infinity)
        .background(RoundedRectangle(cornerRadius: 20).fill(.green))
    }
}

#Preview {
    VStack {
        TextField("Name", text: .constant("name"))
            .textFieldStyle(OutlinedTextFieldStyle())
        TextField("Name", text: .constant("name"))
            .textFieldStyle(OutlinedTextFieldStyle())
        GreenButton(imageSystemName: "plus", text: "Add New Budget")
    }
}
